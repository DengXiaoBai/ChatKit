//
//  ChatDateOfferContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatCellConfig.h>
#import "ChatDateOfferContentConfig.h"
#import "ChatDateOfferTopView.h"
#import "ChatDateOfferBtnBottomView.h"
#import "ChatDateOfferDescBottomView.h"
#import "ChatDateOfferMessageObject.h"

@implementation ChatDateOfferContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    CGSize topContentSize = [ChatDateOfferTopView getViewSizeWithMessageModel:self.messageModel];
    CGSize bottomContentSize = CGSizeZero;

    ChatDateOfferMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            bottomContentSize = [ChatDateOfferDescBottomView getViewSizeWithMessageModel:self.messageModel];
            break;
        }
        case SKSMessageSourceTypeReceive: {
            if (messageObject.dateOfferState == SKSDateOfferStateNotProcessed) {
                bottomContentSize = [ChatDateOfferBtnBottomView getViewSizeWithMessageModel:self.messageModel];
            } else {
                bottomContentSize = [ChatDateOfferDescBottomView getViewSizeWithMessageModel:self.messageModel];
            }
            break;
        }
        default: {
            DLog(@"Not support messageSourceType: %ld", (long)self.messageModel.message.messageSourceType);
        }
    }

    CGFloat max_width = MAX(topContentSize.width, bottomContentSize.width);
    CGSize contentViewSize = CGSizeMake(max_width, topContentSize.height + bottomContentSize.height);

    return contentViewSize;
}

- (NSString *)cellContentClass {
    return @"ChatDateOfferContentView";
}

- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"ChatDateOfferContentView-%@", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}

- (UIEdgeInsets)contentViewInsets {
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(5, 15 + [cellConfig getBubbleViewArrowWidth], 5, 15);
        }
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(5, 15, 5 , 15 + [cellConfig getBubbleViewArrowWidth]);
        }
        default: {
            NSAssert(NO, @"Not support messageSourceType");
        }
    }
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

    self.titleFont = [UIFont systemFontOfSize:14];
    self.titleColor = RGB(226, 84, 84);
    self.titleInsets = UIEdgeInsetsMake(5, 5, 0, 5);

    self.descFont = [UIFont systemFontOfSize:14];
    self.descColor = RGB(106, 106, 106);
    self.descInsets = UIEdgeInsetsMake(5, 5, 0, 5);

    self.lineColor = RGB(207, 207, 207);
    self.lineInsets = UIEdgeInsetsMake(5, 2, 0, 0);
    self.lineHeight = 0.5;

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            self.bottomTitleColor = RGB(109, 109, 109);
            break;
        }
        default: {
            self.bottomTitleColor = RGB(189, 189, 189);
            break;
        }
    }

    self.bottomTitleFont = [UIFont systemFontOfSize:14];
    self.bottomTitleInsets = UIEdgeInsetsMake(5, 5, 5, 0);

    self.iconImageInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    self.rejectBtnColor = RGB(106, 106, 106);
    self.rejectBtnFont = [UIFont systemFontOfSize:13];

    self.acceptBtnFont = self.rejectBtnFont;
    self.acceptBtnColor = RGB(44, 44, 44);
}

@end
