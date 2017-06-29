//
//  SKSDateCallContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//



#import "SKSBaseContentConfig.h"

@interface SKSDateCallContentConfig : SKSBaseContentConfig

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) UIEdgeInsets lineEdgeInsets;
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, assign) UIEdgeInsets iconImageEdgeInsets;

@property (nonatomic, strong) UIColor *descColor;
@property (nonatomic, strong) UIFont *descFont;
@property (nonatomic, assign) UIEdgeInsets descEdgeInsets;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
