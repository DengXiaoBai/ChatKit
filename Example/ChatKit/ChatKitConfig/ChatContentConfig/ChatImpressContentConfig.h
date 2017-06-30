//
//  ChatImpressContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//


#import <ChatKit/SKSBaseContentConfig.h>

@interface ChatImpressContentConfig : SKSBaseContentConfig

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat bottomDescHeight;//底部默认的高度

@property (nonatomic, strong) UIFont *topDescFont;
@property (nonatomic, strong) UIColor *topDescColor;
@property (nonatomic, assign) UIEdgeInsets topDescInsets;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) UIEdgeInsets lineInsets;

@property (nonatomic, strong) UIFont *bottomDescFont;
@property (nonatomic, strong) UIColor *bottomDescColor;
@property (nonatomic, assign) UIEdgeInsets bottomDescInsets;


@property (nonatomic, strong) UIFont *goToImpressFont;
@property (nonatomic, strong) UIColor *goToImpressColor;
@property (nonatomic, assign) UIEdgeInsets goToImpressInsets;

@end
