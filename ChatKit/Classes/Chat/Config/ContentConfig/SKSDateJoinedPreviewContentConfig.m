//
//  SKSDateJoinedPreviewContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import "SKSDateJoinedPreviewContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSDateJoinedPreviewView.h"
#import "SKSDateJoinedPreviewMessageObject.h"

@implementation SKSDateJoinedPreviewContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    CGSize contentViewSize = [SKSDateJoinedPreviewView getSizeWithMessageModel:self.messageModel];
    self.messageModel.contentViewSize = contentViewSize;
    return contentViewSize;
}

- (NSString *)cellContentClass {
    return @"SKSChatDateJoinedPreviewContentView";
}

- (NSString *)cellContentIdentifier {
    //需要判断是是否有玫瑰
    SKSDateJoinedPreviewMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
    BOOL isHaveGift = messageObject.roses > 0 ? YES : NO;//Cell 重用相关

    //判断是否有倒计时
    BOOL isHaveCountDown = messageObject.state == SKSActivityState_PUBLISHED ? YES: NO;//Cell 重用相关

    return [NSString stringWithFormat:@"SKSChatDateJoinedPreviewContentView-%@-%d-%d", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive", isHaveGift, isHaveCountDown];
}

- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;

    self.cellWidth = [UIScreen mainScreen].bounds.size.width - 24 - 24;
    self.coverImageInsets = UIEdgeInsetsZero;
    self.coverImageCornerRadius = 6;

    self.maskColor = RGBA(0, 0, 0, 0.1);

    self.titleFont = [UIFont systemFontOfSize:18];
    self.titleColor = [UIColor whiteColor];
    self.titleInsets = UIEdgeInsetsMake(20, 10, 0, 10);

    self.rosesIconInsets = UIEdgeInsetsMake(15, 10, 0, 0);

    self.rosesDescFont = [UIFont systemFontOfSize:12];
    self.rosesDescColor = [UIColor whiteColor];
    self.rosesDescInsets = UIEdgeInsetsMake(15, 10, 0, 0);

    self.countTimeLabelInsets = UIEdgeInsetsMake(15, 10, 0, 0);
    self.countTimeLabelFont = [UIFont systemFontOfSize:12];
    self.countTimeLabelColor = [UIColor whiteColor];

    self.bottomDescFont = [UIFont systemFontOfSize:11];
    self.bottomDescColor = RGB(187, 187, 187);
    self.bottomDescInsets = UIEdgeInsetsMake(10, 11, 5, 11);
}

@end
