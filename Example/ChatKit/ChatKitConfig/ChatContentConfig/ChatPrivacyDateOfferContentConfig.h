//
//  ChatPrivacyDateOfferContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2017/6/5.
//
//


#import <ChatKit/SKSBaseContentConfig.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 私人邀约 UI 配置文件
 */
@interface ChatPrivacyDateOfferContentConfig : SKSBaseContentConfig

@property (nonatomic, assign, readonly) CGFloat cellWidth;
@property (nonatomic, assign, readonly) CGFloat cellCornerRadius;

@property (nonatomic, strong, readonly) UIColor *backgroundColor;

@property (nonatomic, assign, readonly) CGSize bigDotSize;
@property (nonatomic, strong, readonly) UIColor *bigDotColor;
@property (nonatomic, assign, readonly) UIEdgeInsets bigDotInsets;
@property (nonatomic, assign, readonly) UIEdgeInsets bigDot2Insets;

@property (nonatomic, strong, readonly) UIFont *btnFont;
@property (nonatomic, strong, readonly) UIColor *btnColor;
@property (nonatomic, strong, readonly) UIColor *btnDisableColor;
@property (nonatomic, assign, readonly) CGSize btnSize;
@property (nonatomic, assign, readonly) UIEdgeInsets btnInsets;
@property (nonatomic, assign, readonly) CGFloat btnCornerRadius;
@property (nonatomic, strong, readonly) UIColor *btnBorderColor;

@property (nonatomic, assign, readonly) CGSize coverSize;

@property (nonatomic, strong, readonly) UIFont *coverDescLabelFont;
@property (nonatomic, strong, readonly) UIColor *coverDescLabelTextColor;
@property (nonatomic, assign, readonly) UIEdgeInsets coverDescLabelInsets;

@property (nonatomic, strong, readonly) UIFont *cashLabelFont;
@property (nonatomic, strong, readonly) UIColor *cashLabelTextColor;
@property (nonatomic, assign, readonly) UIEdgeInsets cashLabelInsets;

@property (nonatomic, strong, readonly) UIFont *activityTitleLabelFont;
@property (nonatomic, strong, readonly) UIColor *activityTitleLabelTextColor;
@property (nonatomic, assign, readonly) UIEdgeInsets activityTitleLabelInsets;

@property (nonatomic, strong, readonly) UIFont *descLabelFont;
@property (nonatomic, strong, readonly) UIColor *descLabelTextColor;
@property (nonatomic, assign, readonly) UIEdgeInsets durationLabelInsets;
@property (nonatomic, assign, readonly) UIEdgeInsets placeLabelInsets;

@property (nonatomic, assign, readonly) UIEdgeInsets distinctLabelInsets;

@end

NS_ASSUME_NONNULL_END