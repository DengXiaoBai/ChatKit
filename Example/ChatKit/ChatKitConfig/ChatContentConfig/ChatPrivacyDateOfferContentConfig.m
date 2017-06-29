//
//  ChatPrivacyDateOfferContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2017/6/5.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatPrivacyDateOfferContentConfig.h"
#import "ChatPrivacyDateOfferBtnView.h"
#import "ChatPrivacyActivityOfferCoverView.h"
#import "MarcosDefinition.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import "ChatPrivacyActivityContentView.h"

@interface ChatPrivacyDateOfferContentConfig()

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellCornerRadius;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) CGSize bigDotSize;
@property (nonatomic, strong) UIColor *bigDotColor;
@property (nonatomic, assign) UIEdgeInsets bigDotInsets;
@property (nonatomic, assign) UIEdgeInsets bigDot2Insets;

@property (nonatomic, strong) UIFont *btnFont;
@property (nonatomic, strong) UIColor *btnColor;
@property (nonatomic, strong) UIColor *btnDisableColor;
@property (nonatomic, strong) UIColor *btnBorderColor;
@property (nonatomic, assign) CGSize btnSize;
@property (nonatomic, assign) CGFloat btnCornerRadius;
@property (nonatomic, assign) UIEdgeInsets btnInsets;

@property (nonatomic, assign) CGSize coverSize;

@property (nonatomic, strong) UIFont *coverDescLabelFont;
@property (nonatomic, strong) UIColor *coverDescLabelTextColor;
@property (nonatomic, assign) UIEdgeInsets coverDescLabelInsets;

@property (nonatomic, strong) UIFont *cashLabelFont;
@property (nonatomic, strong) UIColor *cashLabelTextColor;
@property (nonatomic, assign) UIEdgeInsets cashLabelInsets;

@property (nonatomic, strong) UIFont *activityTitleLabelFont;
@property (nonatomic, strong) UIColor *activityTitleLabelTextColor;
@property (nonatomic, assign) UIEdgeInsets activityTitleLabelInsets;

@property (nonatomic, strong) UIFont *descLabelFont;
@property (nonatomic, strong) UIColor *descLabelTextColor;
@property (nonatomic, assign) UIEdgeInsets durationLabelInsets;
@property (nonatomic, assign) UIEdgeInsets placeLabelInsets;

@property (nonatomic, assign) UIEdgeInsets distinctLabelInsets;

@end

@implementation ChatPrivacyDateOfferContentConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareInitData];
    }
    return self;
}

- (void)prepareInitData {

    self.cellWidth = [UIScreen mainScreen].bounds.size.width - 24 - 24 - 60;
    self.cellCornerRadius = 6;

    self.backgroundColor = RGB(255, 255, 255);

    self.bigDotSize = CGSizeMake(4, 4);
    self.bigDotColor = RGB(155, 155, 155);
    self.bigDotInsets = UIEdgeInsetsMake(19, 13, 0, 0);
    self.bigDot2Insets = UIEdgeInsetsMake(19, 13, 0, 0);

    self.btnFont = FONT_DEFAULT(15);
    self.btnColor = RGB(42, 42, 42);
    self.btnDisableColor = RGB(205, 205, 205);
    self.btnSize = CGSizeMake(68, 34);
    self.btnInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    self.btnCornerRadius = 6;
    self.btnBorderColor = RGB(232, 232, 232);

    self.coverSize = CGSizeMake(255, 80);
    self.coverDescLabelFont = FONT_DEFAULT(12);
    self.coverDescLabelTextColor = UIColor.whiteColor;
    self.coverDescLabelInsets = UIEdgeInsetsMake(12, 20, 0, 0);

    self.cashLabelFont = FONT_DEFAULT_MEDIUM(22);
    self.cashLabelTextColor = UIColor.whiteColor;
    self.cashLabelInsets = UIEdgeInsetsMake(10, 20, 0, 0);

    self.activityTitleLabelFont = FONT_DEFAULT_MEDIUM(16);
    self.activityTitleLabelTextColor = RGB(42, 42, 42);
    self.activityTitleLabelInsets = UIEdgeInsetsMake(14, 12, 0, 6);

    self.descLabelFont = FONT_DEFAULT(11);
    self.descLabelTextColor = RGB(155, 155, 155);
    self.durationLabelInsets = UIEdgeInsetsMake(13, 7, 0, 6);
    self.placeLabelInsets = UIEdgeInsetsMake(7, 7, 0, 0);

    self.distinctLabelInsets = UIEdgeInsetsMake(7, 0, 0, 6);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    [super updateWithMessageModel:messageModel];

    self.messageModel = messageModel;
}


- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    //由两部分组成, 第一部分是封面部分，第二部分是底部UI部分
    CGSize topViewSize = [ChatPrivacyActivityOfferCoverView getSizeWithMessageModel:self.messageModel];
    CGSize bottomViewSize = [ChatPrivacyDateOfferBtnView getViewSizeWithMessageModel:self.messageModel maxWidth:topViewSize.width];


    CGSize contentSize;
    if (self.messageModel.message.messageSourceType != SKSMessageSourceTypeSend) {
        contentSize = CGSizeMake(topViewSize.width, topViewSize.height + bottomViewSize.height);
    } else {
        contentSize = CGSizeMake(topViewSize.width, topViewSize.height);
    }

    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}


- (NSString *)cellContentClass {
    return NSStringFromClass(ChatPrivacyActivityContentView.class);
}


- (NSString *)cellContentIdentifier {
    ChatPrivacyDateOfferMessageObject *messageObject = self.messageModel.message.messageAdditionalObject;
    return [NSString stringWithFormat:@"%@-%ld-%ld", [self cellContentClass], (long)self.messageModel.message.messageSourceType, (long)messageObject.privacyActivityState];
}


- (UIEdgeInsets)contentViewInsets {
    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend) {
        return UIEdgeInsetsMake(5, 5, 5, 0);
    } else {
        return UIEdgeInsetsMake(5, -10, 5, 0);
    }
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
}

- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

@end
