//
//  SKSRealTimeVideoOrVoiceContentConfig.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright (c) 2016 iCrany. All rights reserved.
//

#import "SKSBaseContentConfig.h"
#import "SKSChatContentConfig.h"

@interface SKSRealTimeVideoOrVoiceContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, readonly, assign) UIEdgeInsets descLabelInsets;
@property (nonatomic, readonly, assign) UIEdgeInsets iconImageInsets;

@property (nonatomic, readonly, strong) UIFont *descLabelFont;
@property (nonatomic, readonly, strong) UIColor *descLabelColor;

@end
