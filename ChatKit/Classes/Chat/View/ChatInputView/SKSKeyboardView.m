//
//  SKSInputView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <UITextView_Placeholder/UITextView+Placeholder.h>
#import "SKSKeyboardView.h"
#import "SKSInputTextView.h"
#import "SKSButtonInputView.h"
#import "SKSKeyboardViewActionProtocol.h"
#import "SKSKeyboardBaseMoreView.h"
#import "SKSKeyboardMoreViewItemProtocol.h"
#import "SKSChatKeyboardConfig.h"
#import "SKSEmoticonContainerView.h"
#import "SKSEmoticonMeta.h"
#import "UIImage+SKS.h"
#import "SKSWeakProxy.h"


static NSString *kINPUT_TEXT_VIEW_TEXT_KVO           = @"text";
static NSString *kINPUT_TEXT_VIEW_CONTENT_SIZE_KVO   = @"contentSize";
static NSUInteger MAX_USER_INPUT = 32 * 1024 / 4 ;

static CGFloat kKeyboardBtnSize = 40.0f;

static NSInteger kTextRowMaxLimit = 4;

@interface SKSKeyboardView() <UITextViewDelegate, SKSEmoticonContainerViewDelegate, SKSKeyboardMoreViewActionDelegate>

@property (nonatomic, strong) id<SKSChatSessionConfig> sessionConfig;
@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, strong) SKSKeyboardBaseMoreView *moreView;
@property (nonatomic, strong) SKSEmoticonContainerView *emoticonContainerView;

@property (nonatomic, strong) UIView *disableKeyboardMaskView;//键盘至灰UI

/**
 缓存记录输入文字控件的高度，用于在语音按钮之间做切换的时候使用
 */
@property (nonatomic, assign) CGFloat inputTextViewHeightCache;

//for voice record
@property (nonatomic, assign) BOOL isVoiceRecordEnded;//default is no;
@property (nonatomic, strong) NSTimer *recordTimer;//录音的定时器
@property (nonatomic, assign) NSInteger doCount;//倒计时计数
@property (nonatomic, assign) SKSVoiceRecordState voiceRecordState;//当前的录音状态, 主要用于定时器判断手是否在在录音按钮的范围之内

@property (nonatomic, assign) CGFloat moreThanLimitRowHeight;

@end

@implementation SKSKeyboardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        [self registerNotification];
    }
    return self;
}

- (instancetype)initWithSessionConfig:(id<SKSChatSessionConfig>)sessionConfig {
    self = [super init];
    if (self) {
        self.sessionConfig = sessionConfig;
        self.keyboardConfig = [self.sessionConfig chatKeyboardConfig];
        self.isVoiceRecordEnded = NO;
        [self setupUI];
        [self registerNotification];
    }
    return self;
}

- (void)dealloc {

    [_inputTextView removeObserver:self forKeyPath: kINPUT_TEXT_VIEW_TEXT_KVO];

    @try {
        [_inputTextView removeObserver:self forKeyPath: kINPUT_TEXT_VIEW_CONTENT_SIZE_KVO];//make sure removed

    } @catch (NSException *exception) {
        // Do nothing
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


- (void)setupUI {
    
    self.backgroundColor = _keyboardConfig.inputViewBackgroundColor;

    UIEdgeInsets keyboardViewInsets = [_keyboardConfig chatKeyboardViewInsets];

    
    _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceBtn setImage:[UIImage imageNamed:@"keyboard-input-voice-btn"] forState:UIControlStateNormal];
    [_voiceBtn setImage:[UIImage imageNamed:@"keyboard-input-voice-btn-selected"] forState:UIControlStateSelected];
    [_voiceBtn addTarget:self action:@selector(voiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _voiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_voiceBtn];
    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-keyboardViewInsets.bottom);
        make.size.mas_equalTo(CGSizeMake(kKeyboardBtnSize, kKeyboardBtnSize));
        make.left.equalTo(self.mas_left).offset(keyboardViewInsets.left);
    }];
    
    _moreBtn = [[SKSButtonInputView alloc] init];
    [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImage:[UIImage imageNamed:@"keyboard-input-more-btn"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"keyboard-input-more-btn-selected"] forState:UIControlStateSelected];
    [self addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-keyboardViewInsets.right);
        make.bottom.equalTo(self.mas_bottom).offset(-keyboardViewInsets.bottom);
        make.size.mas_equalTo(CGSizeMake(kKeyboardBtnSize, kKeyboardBtnSize));
    }];
    
    _emoticonBtn = [[SKSButtonInputView alloc] init];
    [_emoticonBtn addTarget:self action:@selector(emoticonBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_emoticonBtn setImage:[UIImage imageNamed:@"keyboard-input-emoticon-btn"] forState:UIControlStateNormal];
    [_emoticonBtn setImage:[UIImage imageNamed:@"keyboard-input-voice-btn-selected"] forState:UIControlStateSelected];
    [self addSubview:_emoticonBtn];
    [_emoticonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_moreBtn.mas_left).offset(-keyboardViewInsets.left);
        make.bottom.equalTo(self.mas_bottom).offset(-keyboardViewInsets.bottom);
        make.size.mas_equalTo(CGSizeMake(kKeyboardBtnSize, kKeyboardBtnSize));
    }];
    
    _inputTextView = [[SKSInputTextView alloc] init];
    _inputTextView.font = [_keyboardConfig chatInputTextViewFont];
    _inputTextView.editable = YES;
    _inputTextView.selectable = YES;
    _inputTextView.userInteractionEnabled = YES;
    _inputTextView.delegate = self;
    _inputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _inputTextView.backgroundColor = [_keyboardConfig inputViewBackgroundColor];
    _inputTextView.textColor = [_keyboardConfig inputViewTextColor];
    _inputTextView.placeholder = [_keyboardConfig inputViewPlaceholder];
    _inputTextView.tintColor = [_keyboardConfig inputViewTextColor];
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.textAlignment = NSTextAlignmentLeft;
    _inputTextView.textContainerInset = [_keyboardConfig chatKeyboardViewTextContainerInsets];
    _inputTextView.layer.cornerRadius = _keyboardConfig.chatInputTextViewInKeyboardViewDefaultHeight / 2;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderWidth = 0.8;
    _inputTextView.layer.borderColor = [[_keyboardConfig inputViewBorderColor] CGColor];
    [self addSubview:_inputTextView];
    
    [_inputTextView addObserver:self
                     forKeyPath:kINPUT_TEXT_VIEW_TEXT_KVO
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    [_inputTextView addObserver:self
                     forKeyPath:kINPUT_TEXT_VIEW_CONTENT_SIZE_KVO
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    

    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_voiceBtn.mas_right).offset(keyboardViewInsets.left);
        make.bottom.equalTo(self.mas_bottom).offset(-keyboardViewInsets.bottom);
        make.right.equalTo(_emoticonBtn.mas_left).offset(-keyboardViewInsets.right);
        make.top.equalTo(self.mas_top).offset(keyboardViewInsets.top).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(_keyboardConfig.chatInputTextViewInKeyboardViewDefaultHeight);
    }];
    

    _holdToTalkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _holdToTalkBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_holdToTalkBtn setTitle:[_keyboardConfig voiceBtnHoldToTalkPlaceholder:SKSVoiceRecordStateEnd] forState:UIControlStateNormal];
    [_holdToTalkBtn addTarget:self action:@selector(holdToTalkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_holdToTalkBtn setTitleColor:_keyboardConfig.chatKeyboardHoldToTalkTextColor forState:UIControlStateNormal];
    [_holdToTalkBtn setBackgroundImage:[UIImage imageWithColor:[_keyboardConfig chatKeyboardHoldToTalkNormalBackgroundColor]] forState:UIControlStateNormal];
    [_holdToTalkBtn setBackgroundImage:[UIImage imageWithColor:[_keyboardConfig chatKeyboardHoldToTalkNormalBackgroundColor]] forState:UIControlStateSelected];
    _holdToTalkBtn.layer.cornerRadius = _keyboardConfig.chatInputTextViewInKeyboardViewDefaultHeight / 2;
    _holdToTalkBtn.layer.masksToBounds = YES;
    _holdToTalkBtn.layer.borderWidth = 0.8;
    _holdToTalkBtn.layer.borderColor = [[_keyboardConfig inputViewBorderColor] CGColor];

    UILongPressGestureRecognizer *holdToTalkBtnLongGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdToTalkBtnLongPressAction:)];
    holdToTalkBtnLongGesture.minimumPressDuration = 0.3;
    [_holdToTalkBtn addGestureRecognizer:holdToTalkBtnLongGesture];

    _holdToTalkBtn.hidden = YES;
    [self addSubview:_holdToTalkBtn];
    [_holdToTalkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_voiceBtn.mas_right).offset(keyboardViewInsets.left);
        make.right.equalTo(_emoticonBtn.mas_left).offset(-keyboardViewInsets.right);
        make.bottom.equalTo(self.mas_bottom).offset(-keyboardViewInsets.bottom);
        make.height.mas_equalTo(_keyboardConfig.chatInputTextViewInKeyboardViewDefaultHeight);
    }];


    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = _keyboardConfig.keyboardBorderColor;
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];

    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = _keyboardConfig.keyboardBorderColor;
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];

}

#pragma mark - Private method
- (void)resetAllSelect {
    _voiceBtn.selected = NO;
    _moreBtn.selected = NO;
    _emoticonBtn.selected = NO;
}

- (void)updateTheHoldToTalkBtnUIWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState {
    [_holdToTalkBtn setTitle:[_keyboardConfig voiceBtnHoldToTalkPlaceholder:voiceRecordState] forState:UIControlStateNormal];

    switch (voiceRecordState) {
        case SKSVoiceRecordStateTooShort:
        case SKSVoiceRecordStateOverLimit:
        case SKSVoiceRecordStateEnd:
        case SKSVoiceRecordStateCanceled: {
            [_holdToTalkBtn setBackgroundImage:[UIImage imageWithColor:[_keyboardConfig chatKeyboardHoldToTalkNormalBackgroundColor]] forState:UIControlStateNormal];
            break;
        }
        default: {
            [_holdToTalkBtn setBackgroundImage:[UIImage imageWithColor:[_keyboardConfig chatKeyboardHoldToTalkSelectedBackgroundColor]] forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark - Event Response
- (void)voiceBtnAction:(id)sender {
    CGFloat keyboardViewDefaultHeight = [_keyboardConfig chatKeyboardViewDefaultHeight];

    _moreBtn.selected = NO;
    _emoticonBtn.selected = NO;
    [self resetOverrideFirstResponder];
    
    if (!_voiceBtn.selected) {
        _inputTextView.hidden = YES;
        _holdToTalkBtn.hidden = NO;
        _voiceBtn.selected = YES;
        _inputTextViewHeightCache = _customInputViewHeight;
        _customInputViewHeight = keyboardViewDefaultHeight;
        _systemKeyboardViewHeight = 0;//reset system keyboard height

        [_inputTextView resignFirstResponder];
        [_emoticonBtn resignFirstResponder];
        [_moreBtn resignFirstResponder];

        [sender becomeFirstResponder];
    } else {
        _inputTextView.hidden = NO;
        _holdToTalkBtn.hidden = YES;
        _voiceBtn.selected = NO;
        _customInputViewHeight = _inputTextViewHeightCache;
        
        [_inputTextView becomeFirstResponder];
    }
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewHeightDidChange:)]) {
        [self.delegate inputTextViewHeightDidChange:self];
    }
}

- (void)emoticonBtnAction:(id)sender {
    [self resetOverrideFirstResponder];
    _voiceBtn.selected = NO;
    _moreBtn.selected = NO;
    [self hideVoiceBtnUI];
    [self emoticonContainerView];

    if (_emoticonBtn.selected) {//需要显示表情键盘出来
        _emoticonBtn.selected = NO;
        [_inputTextView becomeFirstResponder];

    } else {
        _emoticonBtn.selected = YES;
        [sender becomeFirstResponder];
    }
}

- (void)moreBtnAction:(id)sender {
    [self resetOverrideFirstResponder];
    [self resetAllSelect];
    [self hideVoiceBtnUI];
    
    [self moreView];
    _moreBtn.selected = YES;
    [sender becomeFirstResponder];
}

- (void)holdToTalkBtnAction:(id)sender {
    [self tooShortAction];
}

- (void)tooShortAction {
    if ([self.actionDelegate respondsToSelector:@selector(onRecordingProgressWithRecordVoiceState:countDown:)]) {
        [self.actionDelegate onRecordingProgressWithRecordVoiceState:SKSVoiceRecordStateTooShort countDown:0];
    }
    [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateTooShort];
}

- (void)holdToTalkBtnLongPressAction:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self];
    NSInteger maxLimitsCount = [_keyboardConfig chatKeyboardRecordMaxLimitCount];
    NSInteger criticalPoint = [_keyboardConfig chatKeyboardRecordCountDownCriticalPoint];

    //需要判断是否是倒计时的状态
    if (maxLimitsCount - _doCount <= criticalPoint) {
        _voiceRecordState = SKSVoiceRecordStateCountDownStateInside;
        if (!CGRectContainsPoint(_holdToTalkBtn.frame, point)) {
            _voiceRecordState = SKSVoiceRecordStateCountDownStateOutside;
        }
    } else {
        _voiceRecordState = SKSVoiceRecordStateRecordingInSide;
        if (!CGRectContainsPoint(_holdToTalkBtn.frame, point)) {
            _voiceRecordState = SKSVoiceRecordStateRecordingOutside;
        }
    }

    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            _isVoiceRecordEnded = NO;//reset
            if ([self.actionDelegate respondsToSelector:@selector(onStartRecording)]) {
                [self.actionDelegate onStartRecording];
            }
            [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateStart];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if ([self.actionDelegate respondsToSelector:@selector(onRecordingProgressWithRecordVoiceState:countDown:)]) {
                [self.actionDelegate onRecordingProgressWithRecordVoiceState:_voiceRecordState countDown:_doCount];
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (!_isVoiceRecordEnded) {//判断是否录音操作因为定时器检测到录音时间过长而提前关闭了

                [self stopRecordTimer];//关闭录音计时定时器

                switch (_voiceRecordState) {
                    case SKSVoiceRecordStateCountDownStateInside:
                    case SKSVoiceRecordStateRecordingInSide: {
                        [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateEnd];
                        if (_doCount > 1) {
                            [self didEndVoiceRecordAction];
                        } else {
                            [self tooShortAction];//小于一秒需要做延时展示动画
                            [self performSelector:@selector(didCancelVoiceRecordAction) withObject:nil afterDelay:1];
                        }
                        break;
                    }
                    case SKSVoiceRecordStateCountDownStateOutside:
                    case SKSVoiceRecordStateRecordingOutside: {
                        [self didCancelVoiceRecordAction];
                        [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateCanceled];
                        break;
                    }
                    default: {
                        break;
                    }
                }
            } else {
                [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateEnd];
            }
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            if (!_isVoiceRecordEnded) {
                [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateCanceled];

                [self stopRecordTimer];//关闭录音计时定时器
                [self didCancelVoiceRecordAction];
            } else {
                [self updateTheHoldToTalkBtnUIWithVoiceRecordState:SKSVoiceRecordStateCanceled];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - Voice Record method
- (void)startRecordTimer {
    [self stopRecordTimer];

    _doCount = 0;
    _voiceRecordState = SKSVoiceRecordStateStart;//录音开始
    _isVoiceRecordEnded = NO;//reset
    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:[[SKSWeakProxy alloc] initWithTarget:self] selector:@selector(doCounter) userInfo:nil repeats:YES];
    [_recordTimer fire];
}

- (void)stopRecordTimer {
    if (_recordTimer) {
        [_recordTimer invalidate];
        _recordTimer = nil;
    }
}

- (void)doCounter {
    //定时的回调 SKSChatRecordView 进行 UI 更新
    _doCount++;
    NSInteger maxLimitsCount = [_keyboardConfig chatKeyboardRecordMaxLimitCount];
    NSInteger criticalPoint = [_keyboardConfig chatKeyboardRecordCountDownCriticalPoint];

    if (_doCount >= maxLimitsCount) {
        //超过时长了就发送语音
        [self stopRecordTimer];
        _isVoiceRecordEnded = YES;//标记录音定时器已经结束了录音动作

        if ([_actionDelegate respondsToSelector:@selector(onRecordingProgressWithRecordVoiceState:countDown:)]) {
            [_actionDelegate onRecordingProgressWithRecordVoiceState:SKSVoiceRecordStateOverLimit countDown:_doCount];
        }

        switch (_voiceRecordState) {
            case SKSVoiceRecordStateCountDownStateOutside:
            case SKSVoiceRecordStateRecordingOutside: {
                [self performSelector:@selector(didCancelVoiceRecordAction) withObject:nil afterDelay:1];
                break;
            }

            case SKSVoiceRecordStateCountDownStateInside:
            case SKSVoiceRecordStateRecordingInSide: {
                [self performSelector:@selector(didEndVoiceRecordAction) withObject:nil afterDelay:1];
                break;
            }
            default: {
                break;
            }
        }

    } else if (maxLimitsCount - _doCount <= criticalPoint) {
        switch (_voiceRecordState) {
            case SKSVoiceRecordStateRecordingInSide:
            case SKSVoiceRecordStateCountDownStateInside: {
                _voiceRecordState = SKSVoiceRecordStateCountDownStateInside;
                break;
            }
            case SKSVoiceRecordStateRecordingOutside:
            case SKSVoiceRecordStateCountDownStateOutside: {
                _voiceRecordState = SKSVoiceRecordStateCountDownStateOutside;
                break;
            }
            default: {
                //ignore
                break;
            }
        }
        if ([_actionDelegate respondsToSelector:@selector(onRecordingProgressWithRecordVoiceState:countDown:)]) {
            [_actionDelegate onRecordingProgressWithRecordVoiceState:_voiceRecordState countDown:_doCount];
        }
    }
}

//语音手动结束或者因为录音时间过长被动结束
- (void)didEndVoiceRecordAction {
    if ([_actionDelegate respondsToSelector:@selector(onStopRecording)]) {
        [_actionDelegate onStopRecording];
    }
}

- (void)didCancelVoiceRecordAction {
    if ([_actionDelegate respondsToSelector:@selector(onCancelRecording)]) {
        [_actionDelegate onCancelRecording];
    }
}



#pragma mark - Public method
- (void)updateSessionConfig:(id<SKSChatSessionConfig>)config {
    self.sessionConfig = config;
    self.keyboardConfig = self.sessionConfig.chatKeyboardConfig;
    [self.moreView updateKeyboardConfig:self.keyboardConfig];
}

- (void)resetAllButtonState {
    [self resetOverrideFirstResponder];
    _moreBtn.selected = NO;
    _emoticonBtn.selected = NO;
}

- (void)didRTCStartRecording {
    [self startRecordTimer];//开启定时器
}

- (void)clearResource {
    [self stopRecordTimer];
}

- (void)disableKeyboardView:(BOOL)disable {
    self.disableKeyboardMaskView.hidden = !disable;
}


#pragma mark - Helper method
- (void)hideVoiceBtnUI {
    _voiceBtn.selected = NO;
    _holdToTalkBtn.hidden = YES;
    _inputTextView.hidden = NO;
}

- (void)resetOverrideFirstResponder {
    _moreBtn.overrideNextResponder = nil;
    _emoticonBtn.overrideNextResponder = nil;
    _inputTextView.overrideNextResponder = nil;
}

- (void)resetKeyboardHeight {
    
    UIEdgeInsets keyboardViewInsets = [_keyboardConfig chatKeyboardViewInsets];
    UIEdgeInsets keyboardTextContainerInsets = [_keyboardConfig chatKeyboardViewTextContainerInsets];
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    
    float lineHeight = _inputTextView.font.lineHeight;
    
    // 这个 UITextView 的 contentSize 需要自己重新计算, 在联想输入法的模式中该值的高度是有偏差的
    CGSize textViewSize ;
    
    CGFloat inputTextViewWidth = screen_width - keyboardViewInsets.left * 5 - 3 * kKeyboardBtnSize;
    textViewSize = [_inputTextView sizeThatFits:CGSizeMake(inputTextViewWidth, FLT_MAX)];
    
    int row = (int)((textViewSize.height - keyboardTextContainerInsets.top + keyboardTextContainerInsets.bottom) / lineHeight);//记得额外加 kInputTextViewInsetGap 的间隔
    
    
    CGFloat height;//默认的键盘的高度

    //更新键盘的高度的约束
    if (row <= kTextRowMaxLimit) {
        height = keyboardViewInsets.top + textViewSize.height + keyboardViewInsets.bottom;

        if (row == kTextRowMaxLimit) {
            _moreThanLimitRowHeight = height;
        }
    } else {
        CGFloat keyboardViewDefaultHeight = [_keyboardConfig chatKeyboardViewDefaultHeight];
        CGFloat inputTextViewDefaultHeight = [_keyboardConfig chatInputTextViewInKeyboardViewDefaultHeight];

        if (_moreThanLimitRowHeight > FLT_MIN) {
            height = _moreThanLimitRowHeight;//防止一次性 copy 的时候的case
        } else {
            height = (kTextRowMaxLimit + 1) * lineHeight + keyboardViewDefaultHeight - inputTextViewDefaultHeight;
        }
    }
    _customInputViewHeight = height;
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewHeightDidChange:)]) {
        [self.delegate inputTextViewHeightDidChange:self];
    }
    
    [_inputTextView layoutIfNeeded];
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyBoardBeginRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!(fabs(keyBoardBeginRect.size.height - _systemKeyboardViewHeight) < FLT_EPSILON)) {
        _systemKeyboardViewHeight = keyBoardBeginRect.size.height;
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                [self resetKeyboardHeight];
                [self.superview layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self resetKeyboardHeight];
                [self.superview layoutIfNeeded];
            }];
        });
    }

}

- (void)keyboardWillHide:(NSNotification *)notification {
    _systemKeyboardViewHeight = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            if (!_voiceBtn.selected) {
                [self resetKeyboardHeight];
                [self.superview layoutIfNeeded];
            }
        } completion:^(BOOL finished) {
            if (!_voiceBtn.selected) {
                [self resetKeyboardHeight];
                [self.superview layoutIfNeeded];
            }
        }];
    });
}

- (void)keyboardDidHide:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_inputTextView endEditing:YES];
        [_inputTextView resignFirstResponder];
        [self becomeFirstResponder];//让当前的第一响应者不要是 _inputTextView 即可，用户消息的Cell 中的系统菜单的展现
    });
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kINPUT_TEXT_VIEW_CONTENT_SIZE_KVO]) {
        [self resetKeyboardHeight];//只用于初始化的第一次 contentSize 监听
        [_inputTextView removeObserver:self forKeyPath:kINPUT_TEXT_VIEW_CONTENT_SIZE_KVO];
    } else {
        [self resetKeyboardHeight];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    //iOS7/iOS8 bug : http://stackoverflow.com/a/19277383/2825613
//    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0 && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_4) {
        CGRect line = [textView caretRectForPosition:
                       textView.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height
        - (textView.contentOffset.y + textView.bounds.size.height
           - textView.contentInset.bottom - textView.contentInset.top);
        if (overflow - 0 > FLT_MIN) {
            // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
            // Scroll caret to visible area
            CGPoint offset = textView.contentOffset;
            if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
                offset.y += overflow + 7; // leave 7 pixels margin in iOS7
            } else {
                offset.y += overflow; // leave 0 pixels margin in iOS8
            }
            
            // Cannot animate with setContentOffset:animated: or caret will not appear
            if (NSFoundationVersionNumber != NSFoundationVersionNumber_iOS_8_1) {//iOS8.1.2 不需要这个微调,否则会产生抖动现象
                [UIView animateWithDuration:.2 animations:^{
                    [textView setContentOffset:offset];
                }];
            }
        }
//    }
    //end
    
    [self resetKeyboardHeight];
    
    NSRange range = textView.selectedRange;
    [textView scrollRangeToVisible:NSMakeRange(range.location + range.length, 1)];//滚动到光标的下一个字母的位置
    
    if ([self.actionDelegate respondsToSelector:@selector(onInputTextViewTextDidChange:)]) {
        [self.actionDelegate onInputTextViewTextDidChange:textView.text];
    }

    //通知表情控件键盘的文字有更改变动
    [self.emoticonContainerView keyboardViewTextDidChange:self.inputTextView.text];

    //通知 VC 字数变化
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:isSend:)]) {
        [self.delegate inputTextViewDidChange:self.inputTextView.text isSend:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // NSLog(@">>>>>>>>>>>>>>>>>>textView.text : %@, range: [%d,%d], text:%@",textView.text, range.location,range.length, text);
    if ([text isEqualToString:@"\n"]) {
        if ([self.actionDelegate respondsToSelector:@selector(onSendText:)]) {
            [self.actionDelegate onSendText:textView.text];
        }

        textView.text = @"";
        //通知表情控件键盘的文字有更改变动
        [self.emoticonContainerView keyboardViewTextDidChange:self.inputTextView.text];
        
        //通知 VC 字数变化
        if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:isSend:)]) {
            [self.delegate inputTextViewDidChange:self.inputTextView.text isSend:YES];
        }
        return NO;
    }else{
        NSUInteger totalLenght = textView.text.length + (text.length - range.length);
        if (totalLenght <=  MAX_USER_INPUT){
            return YES;
        }else{
            textView.text = [[textView.text stringByAppendingString:text] substringWithRange:NSMakeRange(0, MAX_USER_INPUT)];
            return  NO;
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _moreBtn.selected = NO;
    _emoticonBtn.selected = NO;
}

#pragma mark - SKSEmoticonContainerViewDelegate
- (void)emotionButtonActionWithEmotionMeta:(SKSEmoticonMeta *)emotionMeta {
    if (emotionMeta.isEmoji) {
        _inputTextView.text = [_inputTextView.text stringByAppendingFormat:@"%@", emotionMeta.emoticonId];
    } else {
        if ([self.actionDelegate respondsToSelector:@selector(onSendEmoticon:)]) {
            [self.actionDelegate onSendEmoticon:emotionMeta];
        }
    }

    [self.emoticonContainerView keyboardViewTextDidChange:_inputTextView.text];

    //通知 VC 字数变化
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:isSend:)]) {
        [self.delegate inputTextViewDidChange:self.inputTextView.text isSend:NO];
    }
}


- (void)emotionButtonLongPressActionWithEmotionMeta:(SKSEmoticonMeta *)emotionMeta isBegin:(BOOL)isBegin {
    if ([self.actionDelegate respondsToSelector:@selector(onPreviewWithEmoticonMeta:)]) {
        [self.actionDelegate onPreviewWithEmoticonMeta:emotionMeta];
    }
}

- (void)emotionButtonTapEmoticonShopButtonAction {
    if ([self.actionDelegate respondsToSelector:@selector(onOpenEmoticonShop)]) {
        [self.actionDelegate onOpenEmoticonShop];
    }
}

- (void)emoticonDeleteButtonAction {
    //处理删除按钮事件
    if (_inputTextView.text.length >= 1) {
        [_inputTextView deleteBackward];
    }

    [self.emoticonContainerView keyboardViewTextDidChange:_inputTextView.text];

    //通知 VC 字数变化
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:isSend:)]) {
        [self.delegate inputTextViewDidChange:self.inputTextView.text isSend:NO];
    }
}

- (void)emoticonDidTapSendAction {
    if ([self.actionDelegate respondsToSelector:@selector(onSendText:)]) {
        [self.actionDelegate onSendText:_inputTextView.text];
    }
    _inputTextView.text = @"";//reset

    [self.emoticonContainerView keyboardViewTextDidChange:_inputTextView.text];

    //通知 VC 字数变化
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:isSend:)]) {
        [self.delegate inputTextViewDidChange:self.inputTextView.text isSend:YES];
    }
}

#pragma mark - SKSKeyboardMoreViewActionDelegate
- (void)SKSKeyboardMoreItemButtonViewDidTapWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>) itemModel {
    if ([self.actionDelegate respondsToSelector:@selector(onTapKeyboardMoreType:)]) {
        [self.actionDelegate onTapKeyboardMoreType:itemModel.keyboardMoreType];
    }
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - getter/setter
- (SKSKeyboardBaseMoreView *)moreView {
    if (!_moreView) {
        NSString *className = [_keyboardConfig chatKeyboardMoreViewClassName];
        Class clazz = NSClassFromString(className);
        if (clazz) {
            _moreView = [[clazz alloc] initWithItemList:[_keyboardConfig getKeyboardMoreViewItemList] keyboarConfig:_keyboardConfig];
        } else {
            _moreView = [[SKSKeyboardBaseMoreView alloc] initWithItemList:[_keyboardConfig getKeyboardMoreViewItemList] keyboarConfig:_keyboardConfig];
        }

        _moreView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _keyboardConfig.chatKeyboardCustomInputViewHeight);
        _moreView.clipsToBounds = YES;
        _moreView.actionDelegate = self;
        [_moreBtn setButtonInputView:_moreView];
    }
    return _moreView;
}

- (SKSEmoticonContainerView *)emoticonContainerView {
    if (!_emoticonContainerView) {
        NSString *className = [_keyboardConfig chatKeyboardEmoticonContainerViewClassName];
        Class clazz = NSClassFromString(className);
        if (clazz) {
            _emoticonContainerView = [[clazz alloc] initWithUserModel:nil sessionConfig:self.sessionConfig];
        } else {
            _emoticonContainerView = [[SKSEmoticonContainerView alloc] initWithUserModel:nil sessionConfig:self.sessionConfig];
        }
        _emoticonContainerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _keyboardConfig.chatKeyboardCustomInputViewHeight);
        _emoticonContainerView.clipsToBounds = YES;
        _emoticonContainerView.delegate = self;
        [_emoticonBtn setButtonInputView:_emoticonContainerView];
    }
    return _emoticonContainerView;
}

- (UIView *)disableKeyboardMaskView {
    if (!_disableKeyboardMaskView) {
        _disableKeyboardMaskView = [[UIView alloc] init];
        _disableKeyboardMaskView.translatesAutoresizingMaskIntoConstraints = NO;
        _disableKeyboardMaskView.userInteractionEnabled = YES;
        _disableKeyboardMaskView.backgroundColor = UIColor.whiteColor;
        _disableKeyboardMaskView.alpha = 0.7049;
        [self addSubview:_disableKeyboardMaskView];
        [_disableKeyboardMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _disableKeyboardMaskView;
}

@end
