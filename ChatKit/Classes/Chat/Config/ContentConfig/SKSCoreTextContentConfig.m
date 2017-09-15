//
//  SKSCoreTextContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/15.
//
//

#import "SKSCoreTextContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "DTAttributedTextContentView.h"
#import "SKSCoreTextMessageObject.h"
#import "DTCoreText.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatCellConfig.h"
#import "SKSChatCoreTextContentView.h"

@implementation SKSCoreTextContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    SKSCoreTextMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
    NSString *html = messageObject.htmlText;

    static DTAttributedTextContentView *attributedTextContentView;
    if (!attributedTextContentView) {
        attributedTextContentView = [[DTAttributedTextContentView alloc] initWithFrame:CGRectZero];
        attributedTextContentView.shouldDrawImages = YES;
        attributedTextContentView.shouldDrawLinks = YES;
    }

    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.5;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];

    attributedTextContentView.attributedString = attributedString;
    [attributedTextContentView relayoutMask];
    [attributedTextContentView relayoutText];
    CGSize contentViewSize = [attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:maxWidth];

    self.messageModel.contentViewSize = contentViewSize;

    return contentViewSize;
}

- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatCoreTextContentView class]);
}

- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}

- (UIEdgeInsets)contentViewInsets {
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(10, 15 + [cellConfig getBubbleViewArrowWidth], 10, 15);
        }
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(10, 15, 10, 15 + [cellConfig getBubbleViewArrowWidth]);
        }
        default: {
            NSAssert(NO, @"not support messageSourceType");
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
}

@end
