//
//  SKSUnReadContentConfig.h
//  ChatKit
//
//  Created by iCrany on 2017/2/17.
//
//

#import "SKSBaseContentConfig.h"

@interface SKSUnReadContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, assign) CGFloat contentHeight;//default is 24p

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *borderColor;

@end
