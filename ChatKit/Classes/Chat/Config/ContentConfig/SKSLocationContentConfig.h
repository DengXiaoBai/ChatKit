//
//  SKSLocationContentConfig.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSBaseContentConfig.h"
#import "SKSChatContentConfig.h"

@interface SKSLocationContentConfig : SKSBaseContentConfig <SKSChatContentConfig>

@property (nonatomic, readonly, assign) CGSize locationImageSize;
@property (nonatomic, readonly, assign) UIEdgeInsets locationImageInsets;

@property (nonatomic, readonly, assign) UIEdgeInsets titleLabelInsets;
@property (nonatomic, readonly, assign) CGSize titleLabelSize;

@property (nonatomic, readonly, assign) UIEdgeInsets descLabelInsets;
@property (nonatomic, readonly, assign) CGSize descLabelSize;

@property (nonatomic, readonly, strong) UIFont *descLabelFont;
@property (nonatomic, readonly, strong) UIColor *descLabelColor;

@property (nonatomic, readonly, strong) UIFont *titleLabelFont;
@property (nonatomic, readonly, strong) UIColor *titleLabelColor;

@property (nonatomic, readonly, strong) UIColor *imageBackgroundColor;

@end
