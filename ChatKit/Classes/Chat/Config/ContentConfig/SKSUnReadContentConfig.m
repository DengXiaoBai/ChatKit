//
//  SKSUnReadContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2017/2/17.
//
//

#import "SKSUnReadContentConfig.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessageConstant.h"
#import "SKSChatMessage.h"
#import "SKSChatCellConfig.h"
#import "SKSUnReadMessageObject.h"
#import "SKSChatMessageModel.h"

@interface SKSUnReadContentConfig()

@property (nonatomic, strong) UILabel *commonLabel;

@end

@implementation SKSUnReadContentConfig


- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentHeight = 24.0f;
        self.textColor = RGB(147, 147, 147);
        self.textFont = [UIFont systemFontOfSize:12];
        self.textInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        self.backgroundColor = RGB(229, 229, 229);
        self.borderColor = RGB(211, 211, 211);
    }
    return self;
}

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    SKSUnReadMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
    self.commonLabel.text = messageObject.content;
    CGSize tipLabelSize = [self.commonLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - self.messageModel.contentViewInsets.left - self.messageModel.contentViewInsets.right, FLT_MAX)];

    CGSize contentSize = CGSizeMake(self.textInsets.left + tipLabelSize.width + self.textInsets.right, self.textInsets.top + tipLabelSize.height + self.textInsets.bottom);
    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}


- (NSString *)cellContentClass {
    return @"SKSChatUnReadTipContentView";
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"SKSChatUnReadTipContentView-%@", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceiveCenter:
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(8, 15 + [cellConfig getBubbleViewArrowWidth], 8, 15);
        }
        case SKSMessageSourceTypeSendCenter:
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(8, 15, 8, 15 + [cellConfig getBubbleViewArrowWidth]);
        }
        default: {
            return UIEdgeInsetsMake(10, 30 , 10, 30);
        }
    }
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 30, 5, 30);
}


- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;
}

#pragma mark - getter/setter
- (UILabel *)commonLabel {
    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc] init];
        _commonLabel.font = _textFont;
        _commonLabel.numberOfLines = 0;
        _commonLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commonLabel;
}

@end
