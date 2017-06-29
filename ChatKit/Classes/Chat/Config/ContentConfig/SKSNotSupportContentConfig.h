//
//  SKSNotSupportContentConfig.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSBaseContentConfig.h"
#import "SKSChatContentConfig.h"


/**
 所有不支持的类型统一使用该 contentView
 */
@interface SKSNotSupportContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@end
