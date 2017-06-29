//
//  SKSDateCallContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//

#import "SKSDateCallContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSDateCallView.h"
#import "SKSDateCallMessageObject.h"

@implementation SKSDateCallContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    CGSize contentViewSize = [SKSDateCallView dateCallSizeWithMessageModel:self.messageModel];
    self.messageModel.contentViewSize = contentViewSize;
    return contentViewSize;
}

- (NSString *)cellContentClass {
    return @"SKSChatDateCallContentView";
}

- (NSString *)cellContentIdentifier {
    SKSDateCallMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
    SKSMessageSourceType sourceType = self.messageModel.message.messageSourceType;
    BOOL isTheActivityAuthorUserId = [self.messageModel.message.toId isEqualToString:messageObject.activityAuthorId] && self.messageModel.message.toId.length > 0 && sourceType == SKSMessageSourceTypeReceive;
    BOOL isNeedShowTwoRow = !isTheActivityAuthorUserId && messageObject.callState != SKSMessageCallStateAccept;
    return [NSString stringWithFormat:@"SKSChatDateCallContentView-%@-isNeedShowTwoRow:%d", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive", isNeedShowTwoRow];
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
    SKSDateCallMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    _lineHeight = 1;
    _borderColor = RGB(210, 210, 210);
    BOOL isTheActivityAuthorUserId = [self.messageModel.message.fromId isEqualToString:messageObject.activityAuthorId] && self.messageModel.message.fromId.length > 0;
    BOOL isNeedShowTwoRow = !isTheActivityAuthorUserId && (messageObject.callState != SKSMessageCallStateAccept);

    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _titleColor = RGB(106, 106, 106);
            _titleFont = [UIFont systemFontOfSize:15];
            _titleEdgeInsets = UIEdgeInsetsMake(10, 21, 10, 21);

            _lineColor = RGB(207, 207, 207);
            _lineEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 21);

            _iconImageEdgeInsets = UIEdgeInsetsMake(5, 21, 5, 0);

            _descColor = RGB(207, 207, 207);
            _descFont = [UIFont systemFontOfSize:15];
            _descEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
            _backgroundColor = RGB(229, 229, 229);
            break;
        };
        default: {

            _titleColor = RGB(106, 106, 106);
            _titleFont = [UIFont systemFontOfSize:15];

            if (isNeedShowTwoRow) {
                _titleEdgeInsets = UIEdgeInsetsMake(7, 21 , 7, 21);
            } else {
                _titleEdgeInsets = UIEdgeInsetsMake(10, 21, 10, 21);
            }

            _lineColor = RGB(207, 207, 207);
            _lineEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 21);

            _iconImageEdgeInsets = UIEdgeInsetsMake(5, 21, 5, 0);

            _descColor = RGB(207, 207, 207);
            _descFont = [UIFont systemFontOfSize:15];
            _descEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 5);
            _backgroundColor = [UIColor whiteColor];
            break;
        }
    }
}

@end
