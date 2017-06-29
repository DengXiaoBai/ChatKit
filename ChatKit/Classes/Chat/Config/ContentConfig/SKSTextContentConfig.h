//
//  SKSTextContentConfig.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/15.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatContentConfig.h"
#import "SKSBaseContentConfig.h"

@interface SKSTextContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@end
