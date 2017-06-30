//
//  ChatDateOfferContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSBaseContentConfig.h>

@interface ChatDateOfferContentConfig : SKSBaseContentConfig

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) UIEdgeInsets titleInsets;

@property (nonatomic, strong) UIFont *descFont;
@property (nonatomic, strong) UIColor *descColor;
@property (nonatomic, assign) UIEdgeInsets descInsets;

@property (nonatomic, assign) UIEdgeInsets iconImageInsets;

@property (nonatomic, strong) UIFont *rejectBtnFont;
@property (nonatomic, strong) UIColor *rejectBtnColor;

@property (nonatomic, strong) UIFont *acceptBtnFont;
@property (nonatomic, strong) UIColor *acceptBtnColor;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) UIEdgeInsets lineInsets;

@property (nonatomic, strong) UIFont *bottomTitleFont;
@property (nonatomic, strong) UIColor *bottomTitleColor;
@property (nonatomic, assign) UIEdgeInsets bottomTitleInsets;

@end
