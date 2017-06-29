//
//  SKSUnReadYellowContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2017/2/22.
//
//



#import "SKSBaseContentConfig.h"

@interface SKSUnReadYellowContentConfig : SKSBaseContentConfig

@property (nonatomic, assign) CGFloat contentHeight;//default is 29p

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@property (nonatomic, strong) UIColor *backgroundColor;

@end
