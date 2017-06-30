//
//  ChatDateJoinedPreviewView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatMessageObject.h>
#import <ChatKit/SKSWeakProxy.h>
#import "ChatDateJoinedPreviewView.h"
#import "ChatDateJoinedPreviewContentConfig.h"
#import "ChatDateJoinedPreviewMessageObject.h"

@interface ChatDateJoinedPreviewView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatDateJoinedPreviewContentConfig *contentConfig;
@property (nonatomic, strong) ChatDateJoinedPreviewMessageObject *messageObject;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rosesIconImageView;
@property (nonatomic, strong) UILabel *rosesLabel;

@property (nonatomic, strong) UILabel *bottomDescLabel;

@property (nonatomic, strong) UILabel *countDownLabel;//倒计时控件
@property (nonatomic, strong) NSTimer *countDownTimer;//倒计时计时器

@end

@implementation ChatDateJoinedPreviewView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        self.messageObject = self.messageModel.message.messageAdditionalObject;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.layer.cornerRadius = self.contentConfig.coverImageCornerRadius;
        _coverImageView.layer.masksToBounds = YES;
        [self addSubview:_coverImageView];
    }

    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.layer.cornerRadius = self.contentConfig.coverImageCornerRadius;
        _maskView.layer.masksToBounds = YES;
        _maskView.backgroundColor = self.contentConfig.maskColor;
        [self addSubview:_maskView];
    }

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }

    if (!_rosesIconImageView) {
        _rosesIconImageView = [[UIImageView alloc] init];
        [self addSubview:_rosesIconImageView];
    }

    if (!_rosesLabel) {
        _rosesLabel = [[UILabel alloc] init];
        _rosesLabel.font = self.contentConfig.rosesDescFont;
        _rosesLabel.textColor = self.contentConfig.rosesDescColor;
        [self addSubview:_rosesLabel];
    }

    if (!_bottomDescLabel) {
        _bottomDescLabel = [[UILabel alloc] init];
        _bottomDescLabel.font = self.contentConfig.bottomDescFont;
        _bottomDescLabel.textColor = self.contentConfig.bottomDescColor;
        [self addSubview:_bottomDescLabel];
    }

    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.textColor = self.contentConfig.countTimeLabelColor;
        _countDownLabel.font = self.contentConfig.countTimeLabelFont;
        [self addSubview:_countDownLabel];
    }
}

- (void)startTimer {
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:[[SKSWeakProxy alloc] initWithTarget:self] selector:@selector(countTimerDoAction:) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer {
    if (!_countDownTimer) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        self.countDownLabel.hidden = YES;//隐藏
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateWithMessageModel:self.messageModel force:YES];
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    BOOL isCoverUrlSame = NO;
    ChatDateJoinedPreviewMessageObject *newMessageObject = messageModel.message.messageAdditionalObject;
    if ([newMessageObject.coverUrl isEqualToString:self.messageObject.coverUrl]) {
        isCoverUrlSame = YES;
    }

    self.messageModel = messageModel;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    //需要再判断约会的当前状态
    if ([self isShowCountTimerLabel]) {
        [self startTimer];//防止Cell 重用的关系, 正在进行中的约会的Cell重用了已经结束了的Cell, 倒计时标签需要重新展示以及对应的计时器要重新打开
        self.countDownLabel.hidden = NO;
    } else {
        [self stopTimer];
        self.countDownLabel.hidden = YES;
    }

    UIEdgeInsets coverImageInsets = self.contentConfig.coverImageInsets;
    CGFloat coverWidth = self.contentConfig.cellWidth - coverImageInsets.left - coverImageInsets.right;
    CGFloat coverHeight = coverWidth / 3;
    _coverImageView.frame = CGRectMake(coverImageInsets.left, coverImageInsets.top, coverWidth, coverHeight);

    if (!isCoverUrlSame || self.coverImageView.image == nil) {
        if ([self.delegate respondsToSelector:@selector(dateJoinedPreviewViewDownloadCoverImageWithCompletion:)]) {
            [self.delegate dateJoinedPreviewViewDownloadCoverImageWithCompletion:^(UIImage *coverImage) {
                self.coverImageView.image = coverImage;
            }];
        }
    }

    _maskView.frame = _coverImageView.frame;

    UIEdgeInsets titleInsets = self.contentConfig.titleInsets;
    _titleLabel.text = self.messageObject.title;
    _titleLabel.textColor = self.contentConfig.titleColor;
    _titleLabel.font = self.contentConfig.titleFont;
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(coverWidth - titleInsets.left - titleInsets.right, FLT_MAX)];
    _titleLabel.frame = CGRectMake(coverImageInsets.left + titleInsets.left, coverImageInsets.top + titleInsets.top, coverWidth - titleInsets.left - titleInsets.right, titleSize.height);


    UIEdgeInsets roseIconInsets = self.contentConfig.rosesIconInsets;
    _rosesIconImageView.image = [UIImage imageNamed:self.messageObject.rosesIconImageName];
    CGSize roseSie = _rosesIconImageView.image.size;
    CGFloat roseIconY = titleInsets.top + titleSize.height + titleInsets.bottom + roseIconInsets.top;
    _rosesIconImageView.frame = CGRectMake(roseIconInsets.left, roseIconY, roseSie.width, roseSie.height);

    UIEdgeInsets roseDescLabelInsets = self.contentConfig.rosesDescInsets;

    _rosesLabel.text = self.messageObject.roseDesc;
    CGSize rosesLabelSize = [_rosesLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
    CGFloat rosesLabelX = roseIconInsets.left + roseSie.width + roseIconInsets.right + roseDescLabelInsets.left;
    CGFloat rosesLabelY = titleInsets.top + titleSize.height + titleInsets.bottom + roseDescLabelInsets.top;
    _rosesLabel.frame = CGRectMake(rosesLabelX, rosesLabelY, rosesLabelSize.width, rosesLabelSize.height);


    if ([self.delegate respondsToSelector:@selector(dateJoinedPreviewViewGetTimeRemainDescWithCompletion:)]) {
        [self.delegate dateJoinedPreviewViewGetTimeRemainDescWithCompletion:^(NSString *content) {
            self.countDownLabel.text = content;//获取内容,计算大小
        }];
    }
    CGSize countDownLabelSize = [_countDownLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
    if (_messageObject.roses == 0) {
        _rosesIconImageView.hidden = YES;
        _rosesLabel.hidden = YES;
        _countDownLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, roseIconY, countDownLabelSize.width, countDownLabelSize.height);
    } else {
        _rosesIconImageView.hidden = NO;
        _rosesLabel.hidden = NO;
        CGFloat countDownLabelX = _rosesLabel.frame.origin.x + _rosesLabel.frame.size.width + self.contentConfig.countTimeLabelInsets.left;
        _countDownLabel.frame = CGRectMake(countDownLabelX, roseIconY, countDownLabelSize.width, countDownLabelSize.height);
    }

    UIEdgeInsets bottomDescInsets = self.contentConfig.bottomDescInsets;
    _bottomDescLabel.text = self.messageObject.bottomDesc;
    CGSize bottomSize = [_bottomDescLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth - bottomDescInsets.left - bottomDescInsets.right, FLT_MAX)];
    CGFloat bottomY = coverImageInsets.top + coverHeight + coverImageInsets.bottom + bottomDescInsets.top;
    _bottomDescLabel.frame = CGRectMake(bottomDescInsets.left, bottomY, bottomSize.width, bottomSize.height);
}

+ (CGSize)getSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    ChatDateJoinedPreviewContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    ChatDateJoinedPreviewMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    static UILabel *descLabel;
    if (!descLabel) {
        descLabel = [[UILabel alloc] init];
        descLabel.font = contentConfig.bottomDescFont;
    }

    UIEdgeInsets coverImageInsets = contentConfig.coverImageInsets;
    CGFloat coverWidth = contentConfig.cellWidth - coverImageInsets.left - coverImageInsets.right;
    CGFloat coverHeight = coverWidth / 3;


    descLabel.text = messageObject.bottomDesc;
    CGSize descSize = [descLabel sizeThatFits:CGSizeMake(contentConfig.cellWidth, FLT_MAX)];
    UIEdgeInsets descInsets = contentConfig.bottomDescInsets;

    CGFloat width = contentConfig.cellWidth;
    CGFloat height = coverImageInsets.top + coverHeight + coverImageInsets.bottom + descInsets.top + descSize.height + descInsets.bottom;
    return CGSizeMake(width, height);
}

#pragma mark - Helper method
- (BOOL)isShowCountTimerLabel {
    BOOL isShowCountLabel;
    switch (self.messageObject.state) {
        case SKSActivityState_PUBLISHED: {
            isShowCountLabel = YES;
            break;
        }
        default: {
            isShowCountLabel = NO;
            break;
        }
    }
    return isShowCountLabel;
}

#pragma mark - Event Response
- (void)countTimerDoAction:(id)sender {
    //定时器的生命周期的交给外部控制
    if ([self.delegate respondsToSelector:@selector(dateJoinedPreviewViewGetTimeRemainDescWithCompletion:)]) {
        [self.delegate dateJoinedPreviewViewGetTimeRemainDescWithCompletion:^(NSString *content) {
            self.countDownLabel.text = content;
            CGSize newSize = [self.countDownLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
            self.countDownLabel.frame = CGRectMake(self.countDownLabel.frame.origin.x, self.countDownLabel.frame.origin.y, newSize.width, newSize.height);
        }];
    }
}


@end
