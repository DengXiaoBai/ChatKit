//
//  SKSRealTimeVideoOrVoiceContentConfig.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright (c) 2016 iCrany. All rights reserved.
//

#import "SKSRealTimeVideoOrVoiceContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSRealTimeVideoOrVoiceView.h"
#import "SKSChatMessageModel.h"
#import "SKSBaseContentConfig.h"
#import "SKSChatRealTimeVideoOrVoiceContentView.h"

@implementation SKSRealTimeVideoOrVoiceContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    self.messageModel.contentViewSize = [SKSRealTimeVideoOrVoiceView realTimeVideoOrVoiceSizeWithMessageModel:self.messageModel];
    return self.messageModel.contentViewSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatRealTimeVideoOrVoiceContentView class]);
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;

    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _descLabelInsets = UIEdgeInsetsMake(10, 10, 10, 0);
            _iconImageInsets = UIEdgeInsetsMake(10, 8, 10, 18);
            _descLabelFont = [UIFont systemFontOfSize:15];
            _descLabelColor = RGB(94, 94, 94);
            break;
        }
        default: {
            _descLabelInsets = UIEdgeInsetsMake(10, 0, 10, 10);
            _iconImageInsets = UIEdgeInsetsMake(10, 18, 10, 8);
            _descLabelFont = [UIFont systemFontOfSize:15];
            _descLabelColor = RGB(94, 94, 94);
            break;
        }
    }

}


@end
