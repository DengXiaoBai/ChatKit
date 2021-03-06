//
//  ChatImpressContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessageConstant.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatImpressContentConfig.h"
#import "ChatImpressView.h"
#import "ChatImpressContentView.h"

@implementation ChatImpressContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    self.messageModel.contentViewSize = CGSizeMake(100, 100);

    self.cellWidth = 200.0;

    self.topDescFont = [UIFont systemFontOfSize:15];
    self.topDescColor = RGB(94, 94, 94);
    self.topDescInsets = UIEdgeInsetsMake(10, 25, 0, 15);

    self.lineColor = RGB(207, 207, 207);
    self.lineHeight = 1.0;
    self.lineInsets = UIEdgeInsetsMake(5, 0, 0, 15);

    self.bottomDescColor = RGB(189, 189, 189);
    self.bottomDescFont = [UIFont systemFontOfSize:14];
    self.bottomDescInsets = UIEdgeInsetsMake(0, 25, 0, 15);

    self.goToImpressColor = RGB(77, 155, 255);
    self.goToImpressFont = [UIFont systemFontOfSize:15];
    self.goToImpressInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    self.bottomDescHeight = 42.0f;

    CGSize contentViewSize = [ChatImpressView getViewSizeWithMessageModel:self.messageModel];
    self.messageModel.contentViewSize = contentViewSize;
    return contentViewSize;
}

- (NSString *)cellContentClass {
    return NSStringFromClass(ChatImpressContentView.class);
}

- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}

- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;
}

@end
