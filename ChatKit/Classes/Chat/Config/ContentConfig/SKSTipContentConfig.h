//
//  SKSTipContentConfig.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSBaseContentConfig.h"
#import "SKSChatContentConfig.h"

@interface SKSTipContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, strong) UIFont *tipFont;
@property (nonatomic, strong) UIColor *tipColor;

@end
