//
//  SKSDateJoinedPreviewContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//



#import "SKSBaseContentConfig.h"

@interface SKSDateJoinedPreviewContentConfig : SKSBaseContentConfig

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) UIEdgeInsets coverImageInsets;
@property (nonatomic, assign) CGFloat coverImageCornerRadius;

@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) UIEdgeInsets titleInsets;

@property (nonatomic, assign) UIEdgeInsets rosesIconInsets;

@property (nonatomic, strong) UIFont *rosesDescFont;
@property (nonatomic, strong) UIColor *rosesDescColor;
@property (nonatomic, assign) UIEdgeInsets rosesDescInsets;

@property (nonatomic, assign) UIEdgeInsets countTimeLabelInsets;
@property (nonatomic, strong) UIFont *countTimeLabelFont;
@property (nonatomic, strong) UIColor *countTimeLabelColor;

@property (nonatomic, strong) UIFont *bottomDescFont;
@property (nonatomic, strong) UIColor *bottomDescColor;
@property (nonatomic, assign) UIEdgeInsets bottomDescInsets;

@end
