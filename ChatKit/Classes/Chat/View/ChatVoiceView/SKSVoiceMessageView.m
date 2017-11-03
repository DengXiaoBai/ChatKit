//
//  SKSVoiceMessageView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SKSVoiceMessageView.h"
#import "NSString+SKS.h"
#import "NSTimer+SKS.h"
#import "SKSShapeView.h"
#import "SKSWholeProgressView.h"
#import "SKSLabelWithEdgeInsets.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSVoiceMessageObject.h"
#import "SKSChatSessionConfig.h"
#import "SKSVoiceContentConfig.h"
#import "SKSChatCellConfig.h"
#import "SKSWeakProxy.h"


static const CGFloat kLeftPadding = 10.0f;
static const CGFloat kRightPadding = 10.0f;
static const CGFloat kTopPadding = 0.0f;
static const CGFloat kBottomPadding = 0.0f;

static const CGFloat kButtonSize = 40;

static const CGFloat kVoiceLineWidthWhenDurationLessThan5 = 50;
static const CGFloat kVoiceLineWidthWhenDurationMoreThan5 = 100;

#define kTimeLabelEdgeInset UIEdgeInsetsMake(4, -4, 4, 0)

static const NSInteger kVoiceLineWidthLimitNumber = 5;

static const BOOL kIsOpenUIDebugMode = NO;//是否开启UI测试模式, 开启之后的会点击播放按钮就会有开启定时器

@interface SKSVoiceMessageView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSVoiceMessageObject *voiceAdditionalMessage;
@property (nonatomic, strong) SKSVoiceContentConfig *contentConfig;
@property (nonatomic, strong) id<SKSChatCellConfig> cellConfig;

@property (nonatomic, assign) BOOL isSender;

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat littleDotSpeed;//小黄点的速度
@property (nonatomic, assign) CGFloat lineOffsetX;

@property (nonatomic, strong) UIButton *startOrStopButton;//点击开始或者结束的按钮
@property (nonatomic, strong) SKSShapeView *shapeView;//用于动画画线曲线的view
@property (nonatomic, strong) SKSWholeProgressView *wholeProgressView;//语音短消息播放进度动画的全屏进度模式
@property (nonatomic, strong) SKSLabelWithEdgeInsets *timeLabel;//剩余时间显示 Label

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int32_t count;

@end

@implementation SKSVoiceMessageView

- (instancetype)initWithMessage:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        _messageModel = messageModel;

        if ([_messageModel.message.messageAdditionalObject isKindOfClass:[SKSVoiceMessageObject class]]) {
            _voiceAdditionalMessage = _messageModel.message.messageAdditionalObject;
        } else {
            NSAssert(false, @"This is not SKSVoiceMessageObject");
        }

        _contentConfig = [_messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

        [self initData];
        [self setupContent];
    }
    return self;
}

- (void)initData {

    _isSender = _messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? YES: NO;
    _viewHeight = kTopPadding + kBottomPadding + kButtonSize;
    _lineWidth = _voiceAdditionalMessage.duration < kVoiceLineWidthLimitNumber ? kVoiceLineWidthWhenDurationLessThan5 : kVoiceLineWidthWhenDurationMoreThan5;
    UIImage *image = _voiceAdditionalMessage.voiceStartButtonImage;

    NSString *formatTime = [NSString formatTimeWithTime:_voiceAdditionalMessage.duration];
    CGFloat width = kLeftPadding + kButtonSize + _lineWidth + [formatTime getSizeWithFont:_contentConfig.textFont].width + kRightPadding;
    //减去 点击按钮的可点击返回的偏移量
    CGFloat offset = (kButtonSize - image.size.width ) / 2;
    _littleDotSpeed = (width - offset) / _voiceAdditionalMessage.duration;//全屏模式的进度条的每秒的速度

    _count = _voiceAdditionalMessage.duration;
    _lineOffsetX = (kButtonSize - image.size.width) / 2;

    _cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];
}

- (void)setupContent {

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];

    self.backgroundColor = _contentConfig.backgroudColor;
    _wholeProgressView = [[SKSWholeProgressView alloc] init];
    _wholeProgressView.translatesAutoresizingMaskIntoConstraints = NO;
    [_wholeProgressView setIsSender:_isSender];
    [self addSubview:_wholeProgressView];
    [_wholeProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_left);
    }];
    
    _startOrStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startOrStopButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_startOrStopButton addTarget:self action:@selector(startOrStopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_startOrStopButton setImage:_voiceAdditionalMessage.voiceStartButtonImage forState:UIControlStateNormal];
    [_startOrStopButton setImage:_voiceAdditionalMessage.voiceStopButtonImage forState:UIControlStateSelected];
    [self addSubview:_startOrStopButton];
    [_startOrStopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kButtonSize, kButtonSize));
        make.centerY.equalTo(self.mas_centerY);
        if (_isSender) {
            make.left.equalTo(self.mas_left).offset(kLeftPadding);
        } else {
            make.left.equalTo(self.mas_left).offset(kLeftPadding + _cellConfig.getBubbleViewArrowWidth);
        }
    }];

    CABasicAnimation *shareDefaultLineAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    shareDefaultLineAnimation.fromValue = @0.0;
    shareDefaultLineAnimation.toValue = @1.0;
    shareDefaultLineAnimation.removedOnCompletion = NO;
    shareDefaultLineAnimation.duration = _voiceAdditionalMessage.duration;

    CABasicAnimation *shareViewAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    shareViewAnimation.fromValue = @1.0;
    shareViewAnimation.toValue = @0.0;
    shareViewAnimation.removedOnCompletion = NO;
    shareViewAnimation.duration = _voiceAdditionalMessage.duration;

    _shapeView = [[SKSShapeView alloc] init];
    _shapeView.backgroundColor = [UIColor clearColor];//需要用透明的,有两层结构,底部的一层是默认从起点到终点的线条
    _shapeView.opaque = NO;
    [_shapeView.shapeLayer addAnimation:shareViewAnimation forKey:NSStringFromSelector(@selector(strokeEnd))];
    _shapeView.shapeLayer.speed = 0;//pause animation
    _shapeView.shapeLayer.timeOffset = 0;
    _shapeView.shapeLayer.path = [self createLineType].CGPath;
    _shapeView.shapeLayer.strokeColor = _contentConfig.lineColor.CGColor;
    _shapeView.shapeLayer.lineWidth = 1;
    _shapeView.shapeLayer.borderColor = _contentConfig.lineColor.CGColor;
    _shapeView.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeView.clipsToBounds = YES;
    _shapeView.shapeLayer.masksToBounds = YES;

    _shapeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_shapeView];
    [_shapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startOrStopButton.mas_right).offset(-_lineOffsetX);//进行一些偏移的计算, 因为 button 有点击范围的概念
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(_lineWidth);
    }];

    //time
    NSString *formatTime = [NSString formatTimeWithTime:_voiceAdditionalMessage.duration];
    CGFloat timeLabelWidth = [formatTime getSizeWithFont:_contentConfig.textFont].width;
    _timeLabel = [[SKSLabelWithEdgeInsets alloc] initWIthEdgeInsets:kTimeLabelEdgeInset];
    [_timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_timeLabel setText:formatTime];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_timeLabel setFont:_contentConfig.textFont];
    [_timeLabel setTextColor:_contentConfig.textColor];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shapeView.mas_right);

        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(timeLabelWidth, kButtonSize));
    }];

    [self bringSubviewToFront:_timeLabel];
}

- (void)restContent {
    //更新UI
    [self initData];
    [self stopTimer];
    BOOL isSender = _messageModel.message.messageSourceType == SKSMessageSourceTypeSend? YES : NO;

    [_startOrStopButton setImage:_voiceAdditionalMessage.voiceStartButtonImage forState:UIControlStateNormal];
    [_startOrStopButton setImage:_voiceAdditionalMessage.voiceStopButtonImage forState:UIControlStateSelected];


    NSString *formatTime = [NSString formatTimeWithTime:_voiceAdditionalMessage.duration];
    CGFloat timeLabelWidth = [_timeLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, kButtonSize)].width;//[formatTime getSizeWithFont:_contentConfig.textFont].width;
    [_timeLabel setText:formatTime];

    _shapeView.shapeLayer.path = [self createLineType].CGPath;
    [_shapeView layoutIfNeeded];
    [_timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shapeView.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(timeLabelWidth, kButtonSize));
    }];
    [_shapeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startOrStopButton.mas_right).offset(-_lineOffsetX);//进行一些偏移的计算, 因为 button 有点击范围的概念
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(_lineWidth);
    }];

    [_wholeProgressView setIsSender:isSender];
    [_wholeProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_left);
    }];
}

#pragma mark - Event Response
- (void)startOrStopButtonAction:(UIButton *)sender {

    sender.selected = !sender.selected;

    if ([self.delegate respondsToSelector:@selector(voiceMessageViewDidTapStartOrStopButton:)]) {
        [self.delegate voiceMessageViewDidTapStartOrStopButton:self];
    }

    //等待 easyRTC 的回调后才开启定时器
#ifdef DEBUG
    if (kIsOpenUIDebugMode) {
        [self startTimer];
    }
#endif

    if (sender.selected == YES && _timer != nil) {
        [self resumeTimer];
    } else if (sender.selected == NO && _timer != nil) {
        [self pauseTimer];
    }
}

- (void)viewDidTapAction:(UITapGestureRecognizer *)senderGesture {

    UIButton *sender = _startOrStopButton;

    sender.selected = !sender.selected;

    if ([self.delegate respondsToSelector:@selector(voiceMessageViewDidTapStartOrStopButton:)]) {
        [self.delegate voiceMessageViewDidTapStartOrStopButton:self];
    }

    if (sender.selected == YES && _timer != nil) {
        [self resumeTimer];
    } else if (sender.selected == NO && _timer != nil) {
        [self pauseTimer];
    }
}

#pragma mark - Helper Method

- (UIBezierPath *)createLineType {
    if (_voiceAdditionalMessage.duration < kVoiceLineWidthLimitNumber) {
        return [self createShortLineType];
    } else {
        return [self createLongLineType];
    }
}

- (UIBezierPath *)createLongLineType {
    //从结束点开始绘画画向开始点, 便于那个擦除操作
    UIBezierPath* aPath = [UIBezierPath bezierPath];

    CGFloat startX = _lineWidth;
    CGFloat startY = _viewHeight / 2;
    [aPath moveToPoint:CGPointMake(startX, startY)];
    [aPath addLineToPoint:CGPointMake(23, startY)];
    [aPath addLineToPoint:CGPointMake(19, startY + 7)];
    [aPath addLineToPoint:CGPointMake(15, startY - 5)];
    [aPath addLineToPoint:CGPointMake(10, startY)];
    [aPath addLineToPoint:CGPointMake(0, startY)];

    return aPath;
}

- (UIBezierPath *)createShortLineType {
    UIBezierPath* aPath = [UIBezierPath bezierPath];

    CGFloat startX = _lineWidth;
    CGFloat startY = _viewHeight / 2;
    [aPath moveToPoint:CGPointMake(startX, startY)];
    [aPath addLineToPoint:CGPointMake(23, startY)];
    [aPath addLineToPoint:CGPointMake(19, startY + 7)];
    [aPath addLineToPoint:CGPointMake(15, startY - 5)];
    [aPath addLineToPoint:CGPointMake(10, startY)];
    [aPath addLineToPoint:CGPointMake(0, startY)];

    return aPath;
}

- (void)resetWholeProgressWithPositionMs:(NSUInteger)positionMs duration:(NSUInteger)durationMs {
    CGFloat present = positionMs * 1.0 / durationMs;
    CGFloat width = self.bounds.size.width * present;
    //设置播放按钮的状态,防止 cell 重用导致播放按钮的状态出现异常情况
    if (!_startOrStopButton.selected) {
        if (_timer == nil) {
            [self startTimer];
        }
        _startOrStopButton.selected = YES;
    }

    _voiceAdditionalMessage.voicePlayState = SKSVoicePlayStatePlaying;
    _count = (int32_t)floor((durationMs - positionMs) * 1.0 / 1000);
    [self doCounter];//主动调用一次

    if (fabs(width - self.bounds.size.width) > FLT_EPSILON) {
        [_wholeProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(width);
        }];
    } else {
        [_wholeProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self.mas_right);
        }];
    }

    if (positionMs == durationMs) {
        [self resetWholeProgressOffset];
        _voiceAdditionalMessage.voicePlayState = SKSVoicePlayStateStop;
    }
}

- (void)resetWholeProgressOffset {
    [_wholeProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_left);
    }];
}

- (void)resetAll {
    _startOrStopButton.selected = NO;
    _count = _voiceAdditionalMessage.duration;
    [self resetWholeProgressOffset];
    _timeLabel.text = [NSString formatTimeWithTime:_voiceAdditionalMessage.duration];
    _voiceAdditionalMessage.isFirstTimePlay = NO;//重置数据
}

- (BOOL)canBecomeFirstResponder {//用于 UIMenuController 的显示
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

#pragma mark - Timer Helper
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[[SKSWeakProxy alloc] initWithTarget:self] selector:@selector(doCounter) userInfo:nil repeats:YES];
        _count = _voiceAdditionalMessage.duration;
    }
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        [self resetAll];
    }
}

- (void)pauseTimer {
    _voiceAdditionalMessage.voicePlayState = SKSVoicePlayStatePause;
    [_timer pauseTimer];
}

- (void)resumeTimer {
    [_timer resumeTimer];
}

- (void)doCounter {
    _timeLabel.text = [NSString formatTimeWithTime:_count];

    if (kIsOpenUIDebugMode) {
        _count--;
    }

    CGFloat timeLabelWidth = [_timeLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, kButtonSize)].width;
    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shapeView.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(timeLabelWidth, kButtonSize));
    }];

    if (_count < 0) {//播放结束了
        [self stopTimer];
    }
}

#pragma mark - Public method
+ (CGSize)voiceMessageSizeWithMessage:(SKSChatMessageModel *)messageModel {

    if (![messageModel.message.messageAdditionalObject isKindOfClass:[SKSVoiceMessageObject class]]) {
        return CGSizeZero;
    }

    SKSVoiceContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    id<SKSChatCellConfig> cellConfig = [messageModel.sessionConfig chatCellConfigWithMessage:messageModel.message];

    SKSVoiceMessageObject *voiceMessageObject = messageModel.message.messageAdditionalObject;
    CGFloat height = kTopPadding + kBottomPadding + kButtonSize;

    CGFloat lineWidth =  voiceMessageObject.duration < kVoiceLineWidthLimitNumber ? kVoiceLineWidthWhenDurationLessThan5 : kVoiceLineWidthWhenDurationMoreThan5;
    NSString *formatTime = [NSString formatTimeWithTime:voiceMessageObject.duration];
    CGFloat width = kLeftPadding + kButtonSize + lineWidth + [formatTime getSizeWithFont:contentConfig.textFont].width + kRightPadding;

    //减去 点击按钮的可点击返回的偏移量
    UIImage *image = voiceMessageObject.voiceStartButtonImage;
    CGFloat offset = (kButtonSize - image.size.width ) / 2;
    return CGSizeMake(width - offset + cellConfig.getBubbleViewArrowWidth, height);
}

- (void)stopPlayVoice {
    [self stopTimer];//关闭 定时器
    _voiceAdditionalMessage.voicePlayState = SKSVoicePlayStateStop;
    _startOrStopButton.selected = NO;
}

- (void)pausePlayVoice {
    [self pauseTimer];
    _voiceAdditionalMessage.voicePlayState = SKSVoicePlayStatePause;
}

- (void)startOrResumePlayVoice {
    if (_timer) {//继续播放语音
        [self resumeTimer];
    } else {//重新播放语音
        [self startTimer];
    }
}

- (void)playProgressWithPosition:(NSUInteger)positionMs duration:(NSUInteger)durationMs {
    [self resetWholeProgressWithPositionMs:positionMs duration:durationMs];
}

- (void)changeMessageStatus:(SKSMessageDeliveryState)messageStatus {
    _messageModel.message.messageDeliveryState = messageStatus;

    switch (messageStatus) {
        case SKSMessageDeliveryStateDelivering: {
            //显示loading 的视图出来
            _startOrStopButton.hidden = NO;
            break;
        }
        case SKSMessageDeliveryStateFail: {
            _startOrStopButton.hidden = NO;
            break;
        }
        case SKSMessageDeliveryStateSent:
        case SKSMessageDeliveryStateDelivered: {
            _startOrStopButton.hidden = NO;
            break;
        }
        case SKSMessageDeliveryStateRead: {
            break;
        }
    }
}

#pragma mark - getter/setter
- (void)setMessageModel:(SKSChatMessageModel *)messageModel {
    _messageModel = messageModel;
    [self restContent];
}


@end
