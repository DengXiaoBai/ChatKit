//
//  ChatPrivacyGiftOfferContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSBaseContentConfig.h>

@interface ChatPrivacyGiftOfferContentConfig : SKSBaseContentConfig

@property (nonatomic, assign, readonly) CGFloat cellWidth;

@property (nonatomic, strong, readonly) UIFont *bottomDescFont;
@property (nonatomic, strong, readonly) UIColor *bottomDescColor;
@property (nonatomic, assign, readonly) UIEdgeInsets bottomDescInsets;

@property (nonatomic, strong, readonly) UIFont *leftBtnFont;
@property (nonatomic, strong, readonly) UIColor *leftBtnTitleColor;
@property (nonatomic, assign, readonly) UIEdgeInsets leftBtnInsets;
@property (nonatomic, assign, readonly) CGSize leftBtnSize;

@property (nonatomic, strong, readonly) UIFont *rightBtnFont;
@property (nonatomic, strong, readonly) UIColor *rightBtnTitleColor;
@property (nonatomic, assign, readonly) UIEdgeInsets rightBtnInsets;
@property (nonatomic, assign, readonly) CGSize rightBtnSize;

@property (nonatomic, strong, readonly) UIFont *contentLabelFont;
@property (nonatomic, strong, readonly) UIColor *contentLabelColor;
@property (nonatomic, assign, readonly) UIEdgeInsets contentLabelInsets;

@property (nonatomic, strong, readonly) UIColor *lineColor;
@property (nonatomic, assign, readonly) UIEdgeInsets hLineInsets;
@property (nonatomic, assign, readonly) UIEdgeInsets vLineInsets;

@property (nonatomic, assign, readonly) CGFloat bottomViewHeight;

@property (nonatomic, strong, readonly) UIColor *backgroundColor;

@end
