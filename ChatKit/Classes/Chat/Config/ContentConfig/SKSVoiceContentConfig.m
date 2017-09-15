//
//  SKSVoiceContentConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSVoiceContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSVoiceMessageView.h"
#import "SKSVoiceMessageObject.h"
#import "SKSChatVoiceContentView.h"

@implementation SKSVoiceContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    self.messageModel.contentViewSize = [SKSVoiceMessageView voiceMessageSizeWithMessage:self.messageModel];    
    return self.messageModel.contentViewSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatVoiceContentView class]);
}


- (NSString *)cellContentIdentifier {

    SKSVoiceMessageObject *voiceMessageObject = self.messageModel.message.messageAdditionalObject;
    int32_t duration = voiceMessageObject.duration;

    NSString *identifier = [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
    identifier = [identifier stringByAppendingFormat:@"-%ld", (long)duration];
    return identifier;
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;

    _textFont = [UIFont systemFontOfSize:16];
    _firstPlayLineColor = RGB(95, 95, 95);
    _firstPlayTextColor = RGB(95, 95, 95);

    switch(self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _lineColor = RGB(95, 95, 95);
            _textColor = RGB(95, 95, 95);
            _backgroudColor = RGB(229, 229, 229);
            _progressColor = RGB(255, 255, 255);

            break;
        }
        default: {
            _lineColor = RGB(95, 95, 95);
            _textColor = RGB(95, 95, 95);
            _progressColor = RGB(229, 229, 229);
            _backgroudColor = RGB(255, 255, 255);
            break;
        }
    }
}

@end
