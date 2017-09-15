//
//  SKSNotSupportContentConfig.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSNotSupportContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSDefaultValueMaker.h"
#import "SKSChatCellConfig.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatTextContentView.h"

@interface SKSNotSupportContentConfig ()

@property(nonatomic, strong) UILabel *commonLabel;

@end

@implementation SKSNotSupportContentConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareInitData];
    }
    return self;
}

- (void)prepareInitData {
    _textFont = [UIFont systemFontOfSize:14];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _textColor = [UIColor whiteColor];
            break;
        }
        case SKSMessageSourceTypeReceive: {
            _textColor = [UIColor blackColor];
            break;
        }
        default: {
            _textColor = [UIColor blackColor];
            break;
        }
    }
}

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    if (self.messageModel.message.text.length == 0) {
        self.messageModel.message.text = @"";
    }

    self.commonLabel.text = self.messageModel.message.text;

    CGFloat factor = 0.6;
    CGFloat maxWidth = cellWidth * factor;

    CGSize contentSize;

    @try {
        contentSize = [self.commonLabel sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];

    } @catch (NSException *exception) {
        //try again
        contentSize = [self.commonLabel sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];
    }

    CGSize contentMinSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellConfig] chatNormalTextContentViewMinSize];

    if (contentSize.height < contentMinSize.height) {
        contentSize.height = contentMinSize.height;
    }

    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatTextContentView class]);
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    id <SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(8, 15 + [cellConfig getBubbleViewArrowWidth], 8, 15);
        }
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(8, 15, 8, 15 + [cellConfig getBubbleViewArrowWidth]);
        }
        default: {
            NSAssert(NO, @"not support messageSourceType");
            return UIEdgeInsetsZero;
        }
    }
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

//TODO: timestamp not included in contentView, should be removed
- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;
    [self prepareInitData];
}

#pragma mark - getter/setter

- (UILabel *)commonLabel {
    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commonLabel.font = [UIFont systemFontOfSize:16];
        _commonLabel.numberOfLines = 0;
    }

    return _commonLabel;
}

@end
