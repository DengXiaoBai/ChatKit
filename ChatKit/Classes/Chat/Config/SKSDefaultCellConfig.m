//
//  SKSDefaultCellConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSDefaultCellConfig.h"
#import "SKSChatMessageConstant.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"

@implementation SKSDefaultCellConfig

#pragma mark - SKSChatUIConfig Protocol

- (CGSize)chatNormalTextContentViewMinSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 24);
}

- (CGFloat)getBubbleViewArrowWidth {
    return 10;
}

- (UIFont *)chatReadLabelTextFont {
    return [UIFont systemFontOfSize:11];
}

- (UIColor *)chatReadLabelTextColor {
    return RGB(187, 187, 187);
}

- (NSString *)chatReadImageWithMessageModel:(SKSChatMessageModel *)messageModel {
    switch (messageModel.message.messageDeliveryState) {
        case SKSMessageDeliveryStateRead: {
            return @"chat-session-message-remote-read";
        }
        default: {
            return @"chat-session-message-remote-unread";
        }
    }
}

- (BOOL)chatReadControlUseImageControlView {
    return NO;//控制使用 Text or Image 的控件
}

- (UIColor *)chatMessageCellBackgroundColor {
    return RGB(249, 249, 249);
}

- (UIFont *)chatTimestampLabelFont {
    return [UIFont systemFontOfSize:11];
}


- (UIColor *)chatTimestampLabelTextColor {
    return RGB(186, 186, 186);
}


- (UIColor *)chatTimestampLabelBackgroundColor {
    return RGB(249, 249, 249);
}

- (NSString *)chatSendFailImageName {
    return @"message-fail";
}

@end
