//
//  ChatPrivacyActivityOfferCoverView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/22.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import "ChatPrivacyActivityOfferCoverView.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import "ChatPrivacyDateOfferContentConfig.h"

@interface ChatPrivacyActivityOfferCoverView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyDateOfferMessageObject *messageObject;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *coverDescLabel;
@property (nonatomic, strong) UILabel *cashLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *dot1View;
@property (nonatomic, strong) UIView *dot2View;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@end

@implementation ChatPrivacyActivityOfferCoverView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {

    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatPrivacyDateOfferMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatPrivacyDateOfferMessageObject class");
        return;
    }

    self.backgroundColor = UIColor.whiteColor;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.layer.cornerRadius = self.contentConfig.cellCornerRadius;
    self.layer.masksToBounds = YES;

    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentConfig.coverSize.width, self.contentConfig.coverSize.height)];
    [self addSubview:self.coverImageView];

    self.coverDescLabel = [[UILabel alloc] init];
    self.coverDescLabel.font = self.contentConfig.coverDescLabelFont;
    self.coverDescLabel.textColor = self.contentConfig.coverDescLabelTextColor;
    [self addSubview:self.coverDescLabel];


    self.cashLabel = [[UILabel alloc] init];
    self.cashLabel.font = self.contentConfig.cashLabelFont;
    self.cashLabel.textColor = self.contentConfig.cashLabelTextColor;
    [self addSubview:self.cashLabel];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = self.contentConfig.activityTitleLabelFont;
    self.titleLabel.textColor = self.contentConfig.activityTitleLabelTextColor;
    [self addSubview:self.titleLabel];

    self.dot1View = [[UIView alloc] init];
    self.dot1View.backgroundColor = self.contentConfig.bigDotColor;
    self.dot1View.layer.cornerRadius = self.contentConfig.bigDotSize.width / 2;
    self.dot1View.layer.masksToBounds = YES;
    [self addSubview:self.dot1View];

    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.font = self.contentConfig.descLabelFont;
    self.durationLabel.textColor = self.contentConfig.descLabelTextColor;
    [self addSubview:self.durationLabel];

    self.dot2View = [[UIView alloc] init];
    self.dot2View.backgroundColor = self.contentConfig.bigDotColor;
    self.dot2View.layer.cornerRadius = self.contentConfig.bigDotSize.width / 2;
    self.dot2View.layer.masksToBounds = YES;

    [self addSubview:self.dot2View];

    self.placeLabel = [[UILabel alloc] init];
    self.placeLabel.font = self.contentConfig.descLabelFont;
    self.placeLabel.textColor = self.contentConfig.descLabelTextColor;
    self.placeLabel.numberOfLines = 1;
    [self addSubview:self.placeLabel];

    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.font = self.contentConfig.descLabelFont;
    self.distanceLabel.textColor = self.contentConfig.descLabelTextColor;
    [self addSubview:self.distanceLabel];

    self.coverImageView.backgroundColor = UIColor.lightGrayColor;
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    BOOL isNeedDownloadCoverImage = NO;
    ChatPrivacyDateOfferMessageObject *newMessage = messageModel.message.messageAdditionalObject;
    if (![self.messageObject.coverUrl isEqualToString:newMessage.coverUrl] || self.coverImageView.image == nil) {
        isNeedDownloadCoverImage = YES;
    }
    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    //检测是否需要下载图片
    if (isNeedDownloadCoverImage) {
        if ([self.delegate respondsToSelector:@selector(chatPrivacyActivityOfferCoverDownloadCoverImageWithCompletion:)]) {
            [self.delegate chatPrivacyActivityOfferCoverDownloadCoverImageWithCompletion:^(UIImage *coverImage) {
                NSAssert([NSThread currentThread].isMainThread, @"Please invoke in main thread");
                self.coverImageView.image = coverImage;
            }];
        }
    }

    UIEdgeInsets coverDescLabelInsets = self.contentConfig.coverDescLabelInsets;
    self.coverDescLabel.text = self.messageObject.coverDescTitle;
    CGSize coverDescLabelSize = [self.coverDescLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
    self.coverDescLabel.frame = CGRectMake(coverDescLabelInsets.left, coverDescLabelInsets.top, coverDescLabelSize.width, coverDescLabelSize.height);

    UIEdgeInsets cashLabelInset = self.contentConfig.cashLabelInsets;
    self.cashLabel.text = self.messageObject.cashTitle;
    CGSize cashLabelSize = [self.cashLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
    CGFloat cashY = coverDescLabelInsets.top + coverDescLabelSize.height + coverDescLabelInsets.bottom + cashLabelInset.top;
    self.cashLabel.frame = CGRectMake(cashLabelInset.left, cashY, cashLabelSize.width, cashLabelSize.height);

    UIEdgeInsets titleLabelInset = self.contentConfig.activityTitleLabelInsets;
    self.titleLabel.text = self.messageObject.title;
    if (self.messageObject.privacyActivityState == SKSPrivacyActivityStateReject) {
        self.titleLabel.textColor = self.contentConfig.descLabelTextColor;
    } else {
        self.titleLabel.textColor = self.contentConfig.activityTitleLabelTextColor;
    }
    CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(self.contentConfig.coverSize.width - titleLabelInset.left - titleLabelInset.right, FLT_MAX)];
    CGFloat maxLabelWidth = self.contentConfig.coverSize.width - titleLabelInset.left - titleLabelInset.right;
    if (titleLabelSize.width > maxLabelWidth) {
        titleLabelSize.width = maxLabelWidth;
    }
    self.titleLabel.frame = CGRectMake(titleLabelInset.left, self.contentConfig.coverSize.height + titleLabelInset.top, titleLabelSize.width, titleLabelSize.height);


    UIEdgeInsets dotInsets = self.contentConfig.bigDotInsets;
    CGSize dotSize = self.contentConfig.bigDotSize;
    CGFloat dotY = self.contentConfig.coverSize.height + titleLabelInset.top + titleLabelSize.height + titleLabelInset.bottom + dotInsets.top;
    self.dot1View.frame = CGRectMake(dotInsets.left, dotY, dotSize.width, dotSize.height);

    UIEdgeInsets dot2Insets = self.contentConfig.bigDot2Insets;
    CGFloat dot2Y = dotY + dotSize.height + dotInsets.bottom + dot2Insets.top;
    self.dot2View.frame = CGRectMake(dot2Insets.left, dot2Y, dotSize.width, dotSize.height);

    UIEdgeInsets durationInsets = self.contentConfig.durationLabelInsets;
    self.durationLabel.text = self.messageObject.durationStr;
    CGFloat durationX = dotInsets.left + dotSize.width + dotInsets.right + durationInsets.left;
    CGFloat durationY = self.contentConfig.coverSize.height + titleLabelInset.top + titleLabelSize.height + titleLabelInset.bottom + durationInsets.top;
    CGSize durationLabelSize = [self.durationLabel sizeThatFits:CGSizeMake(self.contentConfig.coverSize.width - durationX - durationInsets.right, FLT_MAX)];
    self.durationLabel.frame = CGRectMake(durationX, durationY, durationLabelSize.width, durationLabelSize.height);


    UIEdgeInsets distinctInsets = self.contentConfig.distinctLabelInsets;
    self.distanceLabel.text = self.messageObject.distinctTitle;
    CGSize distinctLabelSize = [self.distanceLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];

    UIEdgeInsets placeInsets = self.contentConfig.placeLabelInsets;
    self.placeLabel.text = self.messageObject.placeTitle;
    CGFloat maxPlaceLabelWidth = self.contentConfig.coverSize.width - durationX - placeInsets.right - distinctInsets.left - distinctLabelSize.width - distinctInsets.right;
    CGSize placeLabelSize = [self.placeLabel sizeThatFits:CGSizeMake(maxPlaceLabelWidth, FLT_MAX)];
    if (placeLabelSize.width > maxPlaceLabelWidth) {
        placeLabelSize.width = maxPlaceLabelWidth;
    }
    CGFloat placeX = durationX;
    CGFloat placeY = durationY + durationLabelSize.height + durationInsets.bottom + placeInsets.top;
    self.placeLabel.frame = CGRectMake(placeX, placeY, placeLabelSize.width, placeLabelSize.height);

    //Update distinctLabel frame
    CGFloat distinctX = placeX + placeLabelSize.width + placeInsets.right + distinctInsets.left;
    CGFloat distinctY = durationY + durationLabelSize.height + durationInsets.bottom + distinctInsets.top;
    self.distanceLabel.frame = CGRectMake(distinctX, distinctY, distinctLabelSize.width, distinctLabelSize.height);
}

+ (CGSize)getSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    ChatPrivacyDateOfferContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return CGSizeMake(contentConfig.coverSize.width, 182);
}


@end
