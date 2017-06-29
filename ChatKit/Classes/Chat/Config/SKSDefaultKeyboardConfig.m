//
//  SKSDefaultKeyboardConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/16.
//
//

#import "SKSDefaultKeyboardConfig.h"
#import "SKSKeyboardMoreItemVO.h"
#import "UIColor+SKS.h"

@implementation SKSDefaultKeyboardConfig

- (NSInteger)maxInputLength {
    return 100;
}

- (UIColor *)keyboardBorderColor {
    return RGB(230, 230, 230);
}


- (NSString *)inputViewPlaceholder {
    return @"请输入信息";
}

- (UIColor *)inputViewBackgroundColor {
    return [UIColor whiteColor];
}

- (UIColor *)inputViewSelectedBackgroundColor {
    return [UIColor whiteColor];
}

- (UIColor *)inputViewTextColor {
    return [UIColor blackColor];
}

- (UIColor *)inputViewBorderColor {
    return RGB(230, 230, 230);
}

- (UIColor *)inputViewTintColor {
    return RGB(62, 62, 62);
}

- (NSArray *)getKeyboardMoreViewItemList {

    SKSKeyboardMoreItemVO *alumbsItemVO = [SKSKeyboardMoreItemVO voWithNormalImageName:@"chat-session-more-photo-icon" highlightImageName:@"" title:@"照片" keyboardMoreType:SKSKeyboardMoreTypeAlumbs];
    SKSKeyboardMoreItemVO *takePhotoItemVO = [SKSKeyboardMoreItemVO voWithNormalImageName:@"chat-session-more-camera-icon" highlightImageName:@"" title:@"拍照" keyboardMoreType:SKSKeyboardMoreTypeTakePhoto];
    SKSKeyboardMoreItemVO *locationItemVO = [SKSKeyboardMoreItemVO voWithNormalImageName:@"chat-session-more-location-icon" highlightImageName:@"" title:@"位置" keyboardMoreType:SKSKeyboardMoreTypeLocation];
    return [NSArray arrayWithObjects:alumbsItemVO, takePhotoItemVO, locationItemVO, nil];
}

- (UIEdgeInsets)chatKeyboardViewInsets {
    //这里左右边距必须是一样
    return UIEdgeInsetsMake(8, 5, 8, 5);
}


- (UIEdgeInsets)chatKeyboardViewTextContainerInsets {
    return UIEdgeInsetsMake(8, 10, 8, 10);
}


- (CGFloat)chatKeyboardViewDefaultHeight {
    CGFloat inputTextViewHeight = [self chatInputTextViewInKeyboardViewDefaultHeight];
    UIEdgeInsets keyboardViewInsets = [self chatKeyboardViewInsets];
    return inputTextViewHeight + keyboardViewInsets.top + keyboardViewInsets.bottom;
}


- (CGFloat)chatInputTextViewInKeyboardViewDefaultHeight {
    UIEdgeInsets inputTextContainerInsets = [self chatKeyboardViewTextContainerInsets];
    return [self chatInputTextViewFont].lineHeight + inputTextContainerInsets.top + inputTextContainerInsets.bottom;
}

- (UIFont *)chatInputTextViewFont {
    return [UIFont systemFontOfSize:17];
}

- (CGFloat)chatKeyboardMoreViewHeight {
    return 250.0f;
}

- (CGFloat)chatKeyboardEmoticonToolViewHeight {
    return 44.0f;
}

- (NSString *)chatKeyboardMoreViewClassName {
    return @"SKSKeyboardBaseMoreView";
}

- (NSString *)chatKeyboardEmoticonContainerViewClassName {
    return @"SKSEmoticonContainerView";
}

- (NSString *)chatKeyboardEmoticonShopImageName {
    return @"icon_emoticon_shop";
}

- (UIColor *)chatKeyboardEmoticonShopBackgroundColor {
    return RGB(245, 245, 245);
}

- (BOOL)chatKeyboardShowEmoticonShopButton {
    return NO;
}

- (UIColor *)chatKeyboardEmoticonContainerViewBackgroundColor {
    return RGB(249, 249, 249);
}

- (NSString *)chatKeyboardEmoticonButtonClassName {
    return @"SKSEmoticonButton";
}

- (NSString *)chatKeyboardEmoticonDeleteButtonImageName {
    return @"emoji_del_normal";
}

- (NSString *)chatKeyboardEmoticonSendButtonText {
    return @"发送";
}

- (UIFont *)chatKeyboardEmoticonSendButtonTextFont {
    return [UIFont systemFontOfSize:14];
}

- (UIColor *)chatKeyboardEmoticonSendButtonTextColor {
    return RGB(158, 158, 158);
}

- (UIColor *)chatKeyboardEmoticonSendButtonEnableTextColor {
    return RGB(236, 236, 236);
}

- (UIColor *)chatKeyboardEmoticonSendButtonBackgroundColor {
    return [UIColor whiteColor];
}

- (UIColor *)chatKeyboardEmoticonSendButtonEnableBackgroundColor {
    return RGB(68, 66, 66);
}

- (UIColor *)chatKeyboardEmoticonToolBackgroundColor {
    return [UIColor whiteColor];
}

- (UIColor *)chatKeyboardEmoticonToolTopLineColor {
    return [UIColor whiteColor];
}

- (UIColor *)chatKeyboardEmoticonToolBtnSelectedBackgroundColor {
    return RGB(249, 249, 249);
}

- (UIColor *)chatKeyboardEmoticonToolBtnNormalBackgroundColor {
    return [UIColor whiteColor];
}

- (UIColor *)chatKeyboardEmoticonPageIndicatorTintColor {
    return RGB(230, 230, 230);
}

- (UIColor *)chatKeyboardEmoticonCurrentPageIndicatorTintColor {
    return RGB(169, 169, 169);
}


#pragma mark - Keyboard More View

- (UIColor *)chatKeyboardMoreViewBackgroundColor {
    return RGB(249, 249, 249);
}

- (UIColor *)chatKeyboardMoreViewDescTextColor {
    return RGB(158, 158, 158);
}

- (UIFont *)chatKeyboardMoreViewDescTextFont {
    return [UIFont systemFontOfSize:13];
}

#pragma mark - Record Voice View

- (UIColor *)chatKeyboardHoldToTalkSelectedBackgroundColor {
    return RGB(243, 243, 243);
}


- (UIColor *)chatKeyboardHoldToTalkNormalBackgroundColor {
    return RGB(255, 255, 255);
}


- (UIColor *)chatKeyboardHoldToTalkTextColor {
    return RGB(94, 94, 94);
}

/**
 * 获取不同录音状态的icon
 * */
- (NSString *)chatKeyboardRecordImageNameWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState {
    switch (voiceRecordState) {
        case SKSVoiceRecordStateStart:
        case SKSVoiceRecordStateRecordingInSide: {
            return @"chat-session-record-voice";
        }
        case SKSVoiceRecordStateRecordingOutside: {
            return @"chat-session-record-voice-back";
        }
        case SKSVoiceRecordStateTooShort:
        case SKSVoiceRecordStateOverLimit: {
            return @"chat-session-record-voice-tip";
        }
        default: {
            return @"";
        }
    }
}

/**
 * 获取不同录音状态下的底部文案
 * */
- (NSString *)chatKeyboardRecordBottomTextWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState {
    switch (voiceRecordState) {
        case SKSVoiceRecordStateStart:
        case SKSVoiceRecordStateCountDownStateInside:
        case SKSVoiceRecordStateRecordingInSide: {
            return @"手指上滑，取消发送";
        }
        case SKSVoiceRecordStateCountDownStateOutside:
        case SKSVoiceRecordStateRecordingOutside: {
            return @"松开手指，取消发送";
        }
        case SKSVoiceRecordStateOverLimit: {
            return @"说话时间超长";
        }
        case SKSVoiceRecordStateTooShort: {
            return @"说话时间太短";
        }
        default: {
            return @"";
        }
    }
}

- (NSString *)voiceBtnHoldToTalkPlaceholder:(SKSVoiceRecordState)voiceRecordState {
    switch (voiceRecordState) {
        case SKSVoiceRecordStateStart: {
            return @"松开结束";
        }
        case SKSVoiceRecordStateTooShort:
        case SKSVoiceRecordStateOverLimit:
        case SKSVoiceRecordStateCanceled:
        case SKSVoiceRecordStateEnd: {
            return @"按住说话";
        }
        default: {
            return @"松开结束";
        }
    }
}

- (UIFont *)chatKeyboardRecordCountTipTextFont {
    return [UIFont systemFontOfSize:72];
}

- (NSInteger)chatKeyboardRecordMaxLimitCount {
#ifdef DEBUG
    return 10;
#else
    return 60;
#endif
}

- (NSInteger)chatKeyboardRecordCountDownCriticalPoint {

#ifdef DEBUG
    return 5;
#else
    return 10;
#endif
}

@end
