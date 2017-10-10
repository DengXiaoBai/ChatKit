//
//  SKSMessageCell.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSMessageCell.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatBaseContentView.h"
#import "SKSChatCellLayoutConfig.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatNotSupportContentView.h"
#import "SKSChatCellConfig.h"
#import "SKSMessageAvatarButton.h"
#import "SKSMenuItemProtocol.h"
#import "SKSChatTextContentView.h"
#import "UIResponder+SKS.h"
#import "SKSInputTextView.h"
#import "SKSButtonInputView.h"
#import "SKSVoiceMessageObject.h"

@interface SKSMessageCell() <SKSChatMessageContentDelegate>

@property (nonatomic, strong) SKSMessageAvatarButton *avatarBtn;
@property (nonatomic, assign) BOOL isAvatarUrlSame;

@property (nonatomic, strong) UILabel *timestampLabel;

@property (nonatomic, strong) SKSChatMessageModel *messageModel;

@property (nonatomic, strong) UILabel *readLabel;
@property (nonatomic, strong) UIImageView *readImageView;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UIButton *failBtn;

@property (nonatomic, strong) SKSChatBaseContentView *bubbleContentView;

@property (nonatomic, strong) UIView *notPlayView;//for Voice message

@end

@implementation SKSMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel {

    //优化头像下载设置问题
    if ([self.messageModel.avatarUrl isEqualToString:messageModel.avatarUrl]) {
        self.isAvatarUrlSame = YES;
    } else {
        self.isAvatarUrlSame = NO;
    }

    self.messageModel = messageModel;

    [UIView performWithoutAnimation:^{
        [self updateUI];
    }];
}

- (void)updateUI {
    self.contentView.backgroundColor = [[self.messageModel.sessionConfig chatCellConfigWithMessage:_messageModel.message] chatMessageCellBackgroundColor];

    [self addTimestampLabelView];
    [self addAvatarView];
    [self addBubbleContentView];
    [self addReadControlView];
    [self addLoadingAndFailView];
    [self addNotPlayView];
    [self updateUIStateState:_messageModel];
}

- (void)updateUIStateState:(SKSChatMessageModel *)messageModel {

    //Update Read State
    BOOL isUseImageReadControlView = [[messageModel.sessionConfig chatCellConfigWithMessage:messageModel.message] chatReadControlUseImageControlView];
    BOOL isShouldShowReadControl = messageModel.shouldShowReadControl;

    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            if (isShouldShowReadControl) {
                switch (messageModel.message.messageDeliveryState) {
                    case SKSMessageDeliveryStateFail: {//发送失败就不要显示已读未读标签
                        _readImageView.hidden = YES;
                        _readLabel.hidden = YES;
                        break;
                    }
                    default: {
                        if (isUseImageReadControlView) {
                            _readImageView.hidden = NO;
                            _readImageView.image = [UIImage imageNamed:[[messageModel.sessionConfig chatCellConfigWithMessage:messageModel.message] chatReadImageWithMessageModel:messageModel]];
                        } else {
                            _readLabel.hidden = NO;
                            _readLabel.text = [messageModel.sessionConfig getReadLabelTextWithMessageModel:messageModel];
                        }
                        break;
                    }
                }
            } else {//控制不显示已读未读状态
                _readImageView.hidden = YES;
                _readLabel.hidden = YES;
            }
            break;
        }
        default: {
            break;
        }
    }

    //Update DeliveryState
    switch (messageModel.message.messageDeliveryState) {
        case SKSMessageDeliveryStateDelivering: {
            _loadingView.hidden = NO;
            [_loadingView startAnimating];
            _failBtn.hidden = YES;
            break;
        }
        case SKSMessageDeliveryStateFail: {
            _loadingView.hidden = YES;
            [_loadingView stopAnimating];
            _failBtn.hidden = NO;
            break;
        }
        default: {
            _loadingView.hidden = YES;
            [_loadingView stopAnimating];
            _failBtn.hidden = YES;
            break;
        }
    }

    switch (messageModel.message.messageMediaType) {
        case SKSMessageMediaTypeVoice: {
            //更新是否播放状态
            SKSVoiceMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
            self.notPlayView.hidden = !messageObject.isFirstTimePlay;
            [self.bubbleContentView updateUIWithMessageModel:self.messageModel force:YES];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)addTimestampLabelView {
    if (self.messageModel.shouldShowTimestamp) {
        if (!_timestampLabel) {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            UIEdgeInsets timeLabelViewInsets = self.messageModel.timelabelViewInsets;
            CGSize timeLabelViewSize = self.messageModel.timelabelSize;
            //为了防止标签出现漂移的动画现象, 先大概的将 label 设置在中点位置
            _timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - timeLabelViewSize.width) / 2, timeLabelViewInsets.top, timeLabelViewSize.width, timeLabelViewSize.height)];
            _timestampLabel.backgroundColor = [[self.messageModel.sessionConfig chatCellConfigWithMessage:_messageModel.message] chatTimestampLabelBackgroundColor];;
            _timestampLabel.layer.cornerRadius = 4;
            _timestampLabel.layer.masksToBounds = YES;
            _timestampLabel.textColor = [[self.messageModel.sessionConfig chatCellConfigWithMessage:_messageModel.message] chatTimestampLabelTextColor];
            _timestampLabel.textAlignment = NSTextAlignmentCenter;
            _timestampLabel.font = [[self.messageModel.sessionConfig chatCellConfigWithMessage:_messageModel.message] chatTimestampLabelFont];
            [self.contentView addSubview:self.timestampLabel];
            [self.contentView bringSubviewToFront:self.timestampLabel];
        }
    }
    
    self.timestampLabel.text = self.messageModel.message.timestampDesc;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGSize size = [_timestampLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];
    self.messageModel.timelabelSize = CGSizeMake(size.width + 10, size.height + 10);
    CGSize timeLabelSize = self.messageModel.timelabelSize;

    UIEdgeInsets timestampLabelInsets = self.messageModel.timelabelViewInsets;
    float x = (screen_width - timeLabelSize.width) / 2;
    float y = timestampLabelInsets.top;
    _timestampLabel.frame = CGRectMake(x, y, timeLabelSize.width, timeLabelSize.height);
    _timestampLabel.center = CGPointMake(screen_width / 2, (timeLabelSize.height + y) / 2);
    _timestampLabel.hidden = !self.messageModel.shouldShowTimestamp;
}

- (void)addAvatarView {
    CGRect avatarButtonFrame = CGRectZero;
    CGSize avatarViewSize = self.messageModel.avatarViewSize;

    UIEdgeInsets avatarInsets = self.messageModel.avatarViewInsets;
    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            //TODO: 发送者头像的配置功能
            break;
        }
        case SKSMessageSourceTypeReceive: {
            
            if (self.messageModel.shouldAvatarOnBottom) {
                avatarButtonFrame = CGRectMake(avatarInsets.left, self.messageModel.bubbleViewInsets.top + self.messageModel.contentViewSize.height + self.messageModel.contentViewInsets.top - avatarViewSize.height, avatarViewSize.width, avatarViewSize.height);
            } else {
                avatarButtonFrame = CGRectMake(avatarInsets.left,
                                               avatarInsets.top + self.messageModel.bubbleViewInsets.top,
                                               avatarViewSize.width,
                                               avatarViewSize.height);
            }
            break;
        }
        default:
            break;
    }
    
    if (_avatarBtn == nil) {
        NSString *avatarBtnViewClassName = [self.messageModel.sessionConfig getAvatarButtonClassNameWithMessageModel:_messageModel];

        Class clazz = NSClassFromString(avatarBtnViewClassName);
        if (clazz != nil) {
            if ([clazz conformsToProtocol:@protocol(SKSMessageAvatarProtocol)]) {
                _avatarBtn = [[clazz alloc] initWithFrame:avatarButtonFrame messageModel:_messageModel];
            } else {
                _avatarBtn = [[SKSMessageAvatarButton alloc] initWithFrame:avatarButtonFrame messageModel:_messageModel];
                DLog(@"[Error]: %@ class not implement SKSMessageAvatarProtocol, use SKSMessageAvatarButton instead", avatarBtnViewClassName);
            }

        } else {
            _avatarBtn = [[SKSMessageAvatarButton alloc] initWithFrame:avatarButtonFrame messageModel:_messageModel];
            DLog(@"Not find the %@ class, use SKSMessageAvatarButton instead", avatarBtnViewClassName);
        }

        [_avatarBtn addTarget:self action:@selector(avatarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_avatarBtn];
    }
    
    _avatarBtn.hidden = !self.messageModel.shouldShowAvatar;
    _avatarBtn.frame = avatarButtonFrame;
    _avatarBtn.layer.cornerRadius = self.messageModel.avatarViewSize.width / 2;
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.clipsToBounds = YES;

    __weak typeof(self) wSelf = self;
    if (!self.isAvatarUrlSame || [self.avatarBtn imageForState:UIControlStateNormal] == nil) {//优化：有限制的下载头像
        [_avatarBtn downloadAvatarImageWithCompletion:^(UIImage *avatarImage) {
            if (avatarImage) {
                [wSelf.avatarBtn setImage:avatarImage forState:UIControlStateNormal];
            } else {
                [wSelf.avatarBtn setImage:[wSelf.messageModel.sessionConfig defaultAvatar] forState:UIControlStateNormal];
            }
        }];
    }
}

- (void)addBubbleContentView {
    if (!_bubbleContentView) {
        id <SKSChatCellLayoutConfig> layoutConfig = self.messageModel.layoutConfig;
        
        NSString *contentViewClassName = [layoutConfig getCellContentViewClassNameWithMessageModel:self.messageModel];
        SKSChatBaseContentView *bubbleContentView;
        
        if (contentViewClassName.length > 0) {
            Class clazz = NSClassFromString(contentViewClassName);
            if (clazz != nil) {
                bubbleContentView = [[clazz alloc] initWithSKSMessageModel:self.messageModel];
            } else {
                bubbleContentView = [[SKSChatNotSupportContentView alloc] initWithSKSMessageModel:self.messageModel];
            }
        } else {
            bubbleContentView = [[SKSChatNotSupportContentView alloc] initWithSKSMessageModel:self.messageModel];
        }
        
        _bubbleContentView = bubbleContentView;
        _bubbleContentView.delegate = self;
        [self.contentView addSubview:_bubbleContentView];
        
        //Add Long Press Gesture
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
        [_bubbleContentView addGestureRecognizer:longPressGesture];

        //Add Tap Gesture
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [_bubbleContentView addGestureRecognizer:tapGestureRecognizer];
    }

    [_bubbleContentView updateUIWithMessageModel:self.messageModel force:YES];
    _bubbleContentView.frame = CGRectMake(self.messageModel.bubbleViewInsets.left,
                                          self.messageModel.bubbleViewInsets.top,
                                          self.messageModel.contentViewSize.width + self.messageModel.contentViewInsets.left + self.messageModel.contentViewInsets.right,
                                          self.messageModel.contentViewInsets.top + self.messageModel.contentViewSize.height + self.messageModel.contentViewInsets.bottom);
}

- (void)addReadControlView {
    if ([[self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message] chatReadControlUseImageControlView]) {
        [self addReadImageView];
    } else {
        [self addReadLabelView];
    }
}

- (void)addReadLabelView {
    
    if (!(self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend)) {
        return;
    }
    
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _readLabel.textAlignment = NSTextAlignmentCenter;
        _readLabel.font = [[self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message] chatReadLabelTextFont];
        _readLabel.textColor = [[self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message] chatReadLabelTextColor];
        [self.contentView addSubview:_readLabel];
    }
    
    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
    UIEdgeInsets readLabelViewInsets = self.messageModel.readLabelViewInsets;
    UIEdgeInsets bubbleViewInsets = self.messageModel.bubbleViewInsets;
    CGSize readLabelSize = [_readLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];

    _readLabel.frame = CGRectMake(bubbleViewInsets.left - readLabelViewInsets.right - readLabelSize.width, self.messageModel.bubbleViewInsets.top + readLabelViewInsets.top, readLabelSize.width, readLabelSize.height);
    _readLabel.hidden = !self.messageModel.shouldShowReadControl;
}

- (void)addReadImageView {
    if (!(self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend)) {
        return;
    }

    if (!_readImageView) {
        _readImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message] chatReadImageWithMessageModel:self.messageModel]]];
        [self.contentView addSubview:_readImageView];
    }

    UIEdgeInsets readLabelViewInsets = self.messageModel.readLabelViewInsets;
    UIEdgeInsets bubbleViewInsets = self.messageModel.bubbleViewInsets;
    CGSize readControlSize = _readImageView.image.size;

    _readImageView.frame = CGRectMake(bubbleViewInsets.left - readLabelViewInsets.right - readControlSize.width, self.messageModel.bubbleViewInsets.top + readLabelViewInsets.top, readControlSize.width, readControlSize.height);
    _readImageView.hidden = !self.messageModel.shouldShowReadControl;
}

- (void)addLoadingAndFailView {
    if (!(self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend)) {
        return;
    }

    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_loadingView startAnimating];
        [self.contentView addSubview:_loadingView];
    }

    CGSize loadingSize = CGSizeMake(20, 20);
    UIEdgeInsets bubbleViewInsets = self.messageModel.bubbleViewInsets;
    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
    CGFloat xCenter = screen_width - bubbleViewInsets.right / 2;
    CGFloat yCenter = bubbleViewInsets.top + loadingSize.height / 2;
    _loadingView.frame = CGRectMake(0, 0, loadingSize.width, loadingSize.height);
    _loadingView.center = CGPointMake(xCenter, yCenter);

    CGSize failBtnSize = CGSizeMake(44, 44);
    NSString *failBtnImageName = [[self.messageModel.sessionConfig chatCellConfigWithMessage:_messageModel.message] chatSendFailImageName];
    UIImage *failBtnImage = [UIImage imageNamed:failBtnImageName];
    if (!_failBtn) {
        _failBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_failBtn setImage:failBtnImage forState:UIControlStateNormal];
        [_failBtn addTarget:self action:@selector(failBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_failBtn];
    }

    yCenter = bubbleViewInsets.top + failBtnImage.size.height / 2;
    _failBtn.frame = CGRectMake(0, 0, failBtnSize.width, failBtnSize.height);
    _failBtn.center = CGPointMake(xCenter, yCenter);

    _failBtn.hidden = YES;
    _loadingView.hidden = YES;
}

- (void)addNotPlayView {
    //Voice Message will not in center
    if (self.messageModel.message.messageMediaType != SKSMessageMediaTypeVoice || self.messageModel.message.messageSourceType != SKSMessageSourceTypeReceive) {
        return;
    }

    CGSize notPlayViewSize = CGSizeMake(8, 8);
    if (!_notPlayView) {
        _notPlayView = [[UIView alloc] init];
        _notPlayView.backgroundColor = RGB(244, 81, 97);
        _notPlayView.layer.cornerRadius = notPlayViewSize.width / 2;
        [self.contentView addSubview:_notPlayView];
    }

    SKSVoiceMessageObject *voiceMessageObject = self.messageModel.message.messageAdditionalObject;
    //判断是否需要显示
    _notPlayView.frame = CGRectMake(self.messageModel.bubbleViewInsets.left + self.messageModel.contentViewSize.width, self.messageModel.bubbleViewInsets.top, notPlayViewSize.width, notPlayViewSize.height);
    _notPlayView.hidden = !voiceMessageObject.isFirstTimePlay;
}

#pragma mark - SKSChatMessageContentDelegate
- (void)chatMessageContentDidTapAction {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapAction:cell:)]) {
        [self.delegate messageCellDidTapAction:self.messageModel cell:self];
    }
}

- (void)chatMessageContentDidLongPressAction {
    if ([self.delegate respondsToSelector:@selector(messageCellDidLongPressAction:inView:)]) {
        [self.delegate messageCellDidLongPressAction:self.messageModel inView:self.bubbleContentView];
    }
}

- (void)chatBaseContentViewBtnActionAtIndex:(NSInteger)atIndex {
    if ([self.delegate respondsToSelector:@selector(messageCellDidCustomTapAction:buttonIndex:)]) {
        [self.delegate messageCellDidCustomTapAction:self.messageModel buttonIndex:atIndex];
    }
}


- (void)chatCoreTextDidTapAction:(NSURL *)url {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapCoreTextLinkAction:url:)]) {
        [self.delegate messageCellDidTapCoreTextLinkAction:self.messageModel url:url];
    }
}

- (void)chatCoreTextDidLongPressAction:(NSURL *)url {
    if ([self.delegate respondsToSelector:@selector(messageCellDidLongPressCoreTextLinkAction:url:)]) {
        [self.delegate messageCellDidLongPressCoreTextLinkAction:self.messageModel url:url];
    }
}

#pragma mark - Event Response
- (void)avatarButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapAvatarBtnAction:)]) {
        [self.delegate messageCellDidTapAvatarBtnAction:self.messageModel];
    }
}

- (void)failBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapFailBtnAction:)]) {
        [self.delegate messageCellDidTapFailBtnAction:self.messageModel];
    }
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            //回调通知
            if ([self.delegate respondsToSelector:@selector(messageCellDidLongPressAction:inView:)]) {
                [self.delegate messageCellDidLongPressAction:self.messageModel inView:self.bubbleContentView];
            }
            //菜单显示
            [self handleLongPressMenuItemUI];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender {

    switch (_messageModel.message.messageMediaType) {
        case SKSMessageMediaTypeText: {
            SKSChatTextContentView *chatTextContentView = (SKSChatTextContentView *)self.bubbleContentView;
            CGPoint point = [sender locationInView:chatTextContentView.displayTextLabel];

            if ([chatTextContentView.displayTextLabel containslinkAtPoint:point]) {
                //响应点击链接的事件
                TTTAttributedLabelLink *attributedLabelLink = [chatTextContentView.displayTextLabel linkAtPoint:[sender locationInView:chatTextContentView.displayTextLabel]];
                NSTextCheckingResult *result = attributedLabelLink.result;
                switch (result.resultType) {
                    case NSTextCheckingTypeLink: {
                        if ([self.delegate respondsToSelector:@selector(messageCellDidTapFunctionAction:messageFunctionType:entity:)]) {
                            [self.delegate messageCellDidTapFunctionAction:_messageModel messageFunctionType:SKSMessageFunctionTypeUrl entity:result.URL];
                        }
                        return;
                    }
                    case NSTextCheckingTypePhoneNumber: {
                        if ([self.delegate respondsToSelector:@selector(messageCellDidTapFunctionAction:messageFunctionType:entity:)]) {
                            [self.delegate messageCellDidTapFunctionAction:_messageModel messageFunctionType:SKSMessageFunctionTypePhone entity:result.phoneNumber];
                        }
                        return;
                    }
                    default: {
                        break;
                    }
                }
            }
            break;
        }
        default: {
            break;
        }
    }

    if ([self.delegate respondsToSelector:@selector(messageCellDidTapAction:cell:)]) {
        [self.delegate messageCellDidTapAction:self.messageModel cell:self];
    }

}

#pragma mark - Helper method

- (void)handleLongPressMenuItemUI {

    if (self.messageModel.message.menuItemList.count > 0) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        NSMutableArray *menuItemArray = [[NSMutableArray alloc] init];
        for (id <SKSMenuItemProtocol> item in self.messageModel.message.menuItemList) {
            UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:item.menuItemName action:item.selector];
            [menuItemArray addObject:menuItem];
        }

        menuController.menuItems = menuItemArray;
        SKSChatBaseContentView *inView = self.bubbleContentView;

        //获取当前的第一响应者
        id currentResponse = [UIResponder currentFirstResponder];
        if ([currentResponse isKindOfClass:[SKSInputTextView class]]) {
            SKSInputTextView *inputTextView = (SKSInputTextView *)currentResponse;
            inputTextView.overrideNextResponder = self.bubbleContentView;

        } else if ([currentResponse isKindOfClass:[SKSButtonInputView class]]) {
            SKSButtonInputView *buttonInputView = (SKSButtonInputView *)currentResponse;
            buttonInputView.overrideNextResponder = self.bubbleContentView;

        } else {
            [self.bubbleContentView becomeFirstResponder];
        }

        if (self.messageModel.shouldShowTimestamp) {
            CGFloat timeLabelOffset = self.messageModel.timelabelViewInsets.top + self.messageModel.timelabelSize.height + self.messageModel.timelabelViewInsets.bottom;
            CGRect newFrame = CGRectMake(0, inView.frame.origin.y - timeLabelOffset, inView.frame.size.width, inView.frame.size.height);
            [menuController setTargetRect:newFrame inView:inView];
        } else {
            CGRect newFrame = CGRectMake(0, inView.frame.origin.y, inView.frame.size.width, inView.frame.size.height);
            [menuController setTargetRect:newFrame inView:inView];
        }

        if (!menuController.isMenuVisible) {
            [menuController setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - Menu Item Action
- (void)deleteMenuItem:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapMenuItemWithMessageModel:menuItemType:)]) {
        [self.delegate messageCellDidTapMenuItemWithMessageModel:self.messageModel menuItemType:SKSMessageMenuSelectTypeDelete];
    }
}

- (void)copyMenuItem:(id)sender {
    if (self.messageModel.message.text.length > 0) {
        [[UIPasteboard generalPasteboard] setString:self.messageModel.message.text];//进行数据的拷贝操作
    } else {
        [[UIPasteboard generalPasteboard] setString:@""];
    }
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapMenuItemWithMessageModel:menuItemType:)]) {
        [self.delegate messageCellDidTapMenuItemWithMessageModel:self.messageModel menuItemType:SKSMessageMenuSelectTypeTextCopy];
    }
}

- (void)speakerMenuItem:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapMenuItemWithMessageModel:menuItemType:)]) {
        [self.delegate messageCellDidTapMenuItemWithMessageModel:self.messageModel menuItemType:SKSMessageMenuSelectTypeSpeakerVoiceMessage];
    }
}

- (void)earpieceMenuItem:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageCellDidTapMenuItemWithMessageModel:menuItemType:)]) {
        [self.delegate messageCellDidTapMenuItemWithMessageModel:self.messageModel menuItemType:SKSMessageMenuSelectTypeEarpieceMessage];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSArray<id<SKSMenuItemProtocol>> *menuItemList = self.messageModel.message.menuItemList;
    for (id<SKSMenuItemProtocol> itemProtocol in menuItemList) {
        if (action == itemProtocol.selector) {
            return YES;
        }
    }
    return [super canPerformAction:action withSender:sender];
}

@end
