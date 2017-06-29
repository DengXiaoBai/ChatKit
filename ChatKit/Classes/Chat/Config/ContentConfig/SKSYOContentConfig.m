//
//  SKSYOContentConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSYOContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSChatMessageModel.h"

@implementation SKSYOContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    self.messageModel.contentViewSize = CGSizeMake(58, 58);
    
    return self.messageModel.contentViewSize;
}


- (NSString *)cellContentClass {
    return @"SKSChatYOContentView";
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"SKSChatYOContentView-%@", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
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
