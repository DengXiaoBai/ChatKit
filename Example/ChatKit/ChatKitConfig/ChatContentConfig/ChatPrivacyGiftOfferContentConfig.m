//
//  ChatPrivacyGiftOfferContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatPrivacyGiftOfferView.h"
#import "ChatPrivacyGiftOfferContentConfig.h"
#import "ChatPrivacyGiftOfferContentView.h"
#import "MarcosDefinition.h"

@interface ChatPrivacyGiftOfferContentConfig()

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, strong) UIFont *bottomDescFont;
@property (nonatomic, strong) UIColor *bottomDescColor;
@property (nonatomic, assign) UIEdgeInsets bottomDescInsets;

@property (nonatomic, strong) UIFont *leftBtnFont;
@property (nonatomic, strong) UIColor *leftBtnTitleColor;
@property (nonatomic, assign) UIEdgeInsets leftBtnInsets;
@property (nonatomic, assign) CGSize leftBtnSize;

@property (nonatomic, strong) UIFont *rightBtnFont;
@property (nonatomic, strong) UIColor *rightBtnTitleColor;
@property (nonatomic, assign) UIEdgeInsets rightBtnInsets;
@property (nonatomic, assign) CGSize rightBtnSize;

@property (nonatomic, strong) UIFont *contentLabelFont;
@property (nonatomic, strong) UIColor *contentLabelColor;
@property (nonatomic, assign) UIEdgeInsets contentLabelInsets;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) UIEdgeInsets hLineInsets;
@property (nonatomic, assign) UIEdgeInsets vLineInsets;

@property (nonatomic, assign) CGFloat bottomViewHeight;//跟 ChatPrivacyGiftOfferDescView 的高度一致, 要大于 inset.top + height + inset.bottom 的值

@end

@implementation ChatPrivacyGiftOfferContentConfig


- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareInit];
    }
    return self;
}

- (void)prepareInit {

    self.cellWidth = [UIScreen mainScreen].bounds.size.width * 0.55;
    self.bottomDescFont = FONT_DEFAULT(14);
    self.bottomDescColor = RGB(106, 106, 106);
    self.bottomDescInsets = UIEdgeInsetsMake(5, 5, 10, 0);

    self.leftBtnFont = FONT_DEFAULT_MEDIUM(14);
    self.leftBtnTitleColor = RGB(44, 44, 44);
    self.leftBtnInsets = UIEdgeInsetsMake(5, 0, 5, 37);
    self.leftBtnSize = CGSizeMake(0, 44);

    self.rightBtnFont = FONT_DEFAULT_MEDIUM(14);
    self.rightBtnTitleColor = RGB(44, 44, 44);
    self.rightBtnInsets = UIEdgeInsetsMake(5, 37, 5, 0);
    self.rightBtnSize = CGSizeMake(0, 44);

    self.contentLabelFont = FONT_DEFAULT(15);
    self.contentLabelColor = [UIColor blackColor];
    self.contentLabelInsets = UIEdgeInsetsMake(5, 15, 0, 15);

    self.lineColor = RGB(207, 207, 207);
    self.hLineInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    self.vLineInsets = UIEdgeInsetsMake(6, 0, 8, 0);

    self.bottomViewHeight = 50.0f;
}


- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    [super updateWithMessageModel:messageModel];
    self.messageModel = messageModel;
}


- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    CGSize contentSize = [ChatPrivacyGiftOfferView getViewSizeWithMessageModel:self.messageModel cellWidth:cellWidth];

    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass([ChatPrivacyGiftOfferContentView class]);
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%ld", [self cellContentClass], (long)self.messageModel.message.messageSourceType];
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

@end
