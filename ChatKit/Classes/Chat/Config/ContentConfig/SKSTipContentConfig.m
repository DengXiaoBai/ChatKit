//
//  SKSTipContentConfig.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSTipContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatCellConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatTipContentView.h"

@interface SKSTipContentConfig()

@property (nonatomic, strong) UILabel *commonLabel;

@end

@implementation SKSTipContentConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _tipFont = [UIFont systemFontOfSize:11];
        _tipColor = RGB(99, 99, 99);
    }
    return self;
}

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    self.commonLabel.text = self.messageModel.message.text;
    CGSize tipLabelSize = [self.commonLabel sizeThatFits:CGSizeMake(cellWidth - self.messageModel.contentViewInsets.left - self.messageModel.contentViewInsets.right, FLT_MAX)];
    self.messageModel.contentViewSize = tipLabelSize;
    return tipLabelSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatTipContentView class]);
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(8, 15 + [cellConfig getBubbleViewArrowWidth], 8, 15);
        }
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
        _commonLabel.font = _tipFont;
        _commonLabel.numberOfLines = 0;
        _commonLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commonLabel;
}


@end
