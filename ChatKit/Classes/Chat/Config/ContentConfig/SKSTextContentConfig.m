//
//  SKSTextContentConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/15.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSTextContentConfig.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "SKSDefaultCellConfig.h"
#import "SKSDefaultValueMaker.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatTextContentView.h"


@interface SKSTextContentConfig()

@property (nonatomic, strong) TTTAttributedLabel *label;

@end

@implementation SKSTextContentConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareInitData];
    }
    return self;
}

- (void)prepareInitData {
    _textFont = [UIFont systemFontOfSize:14];
    _textColor = [UIColor whiteColor];
}

#pragma mark - SKSChatContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    
    if (self.messageModel.message.text.length == 0) {
        self.messageModel.message.text = @"";
    }
    
    self.label.text = self.messageModel.message.text;
    
    CGFloat factor = 0.6;
    CGFloat maxWidth = cellWidth * factor;
    
    CGSize contentSize;
    
    @try {
        contentSize = [self.label sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];
        
    } @catch (NSException *exception) {
        //try again
        contentSize = [self.label sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];
    }
    
    CGSize contentMinSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellConfig] chatNormalTextContentViewMinSize];
    
    if (contentSize.height   < contentMinSize.height) {
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
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(8, 15 + [cellConfig getBubbleViewArrowWidth], 8, 15);
        }
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(8, 15, 8, 15 + [cellConfig getBubbleViewArrowWidth]);
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
    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _textColor = RGB(104, 104, 104);
            break;
        }
        case SKSMessageSourceTypeReceive: {
            _textColor = RGB(94, 94, 94);
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - getter/setter
- (TTTAttributedLabel *)label {
    if (!_label) {
        _label = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = _textFont;
        _label.enabledTextCheckingTypes = NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber;
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
