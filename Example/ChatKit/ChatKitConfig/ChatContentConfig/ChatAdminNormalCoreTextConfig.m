//
//  ChatAdminNormalCoreTextConfig.m
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//


#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>

#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatCellConfig.h>
#import "ChatAdminNormalCoreTextConfig.h"

#import "ChatAdminNormalCoreTextContentView.h"
#import "ChatAdminNormalCoreTextView.h"

#import "ChatAdminNormalCoreTextMessageObject.h"
#import "MarcosDefinition.h"

@interface ChatAdminNormalCoreTextConfig()
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) UIEdgeInsets titleInsets;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) UIEdgeInsets lineInsets;

@property (nonatomic, assign) UIEdgeInsets coreTextViewInsets;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) UIEdgeInsets iconImageInsets;
@end


@implementation ChatAdminNormalCoreTextConfig


- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareInit];
    }
    return self;
}

- (void)prepareInit {
    
    self.cellWidth = [UIScreen mainScreen].bounds.size.width * 0.55;
    
    self.titleFont = FONT_DEFAULT(15);
    self.titleColor = [UIColor redColor];
    self.titleInsets = UIEdgeInsetsMake(5, 15, 0, 15);
    
    self.lineColor =  RGB(248, 248, 248);
    self.lineInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    
    self.coreTextViewInsets =  UIEdgeInsetsMake(5, 15, 0, 15);
    
    self.iconImageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
}


- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    CGSize contentSize = [ChatAdminNormalCoreTextView getViewSizeWithMessageModel:self.messageModel cellWidth:cellWidth];
    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    [super updateWithMessageModel:messageModel];
    self.messageModel = messageModel;
    
    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeReceive) {
        self.backgroundColor = UIColor.whiteColor;
    } else {
        self.backgroundColor = RGB(229, 229, 229);
    }
    
}

- (NSString *)cellContentClass {
    return NSStringFromClass([ChatAdminNormalCoreTextContentView class]);
}

- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    
    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];
    
    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return UIEdgeInsetsMake(5, 5 + [cellConfig getBubbleViewArrowWidth], 5, 5);
        }
        case SKSMessageSourceTypeSend: {
            return UIEdgeInsetsMake(5, 5, 5, 5 + [cellConfig getBubbleViewArrowWidth]);
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



@end
