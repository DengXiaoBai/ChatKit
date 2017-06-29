//
//  SKSVoiceContentConfig.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSBaseContentConfig.h"
#import "SKSChatContentConfig.h"

@interface SKSVoiceContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) UIColor *firstPlayLineColor;
@property (nonatomic, strong) UIColor *firstPlayTextColor;

@property (nonatomic, strong) UIColor *backgroudColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *progressColor;

@end
