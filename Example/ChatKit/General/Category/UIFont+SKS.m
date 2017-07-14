//
// Created by iCrany on 2017/6/20.
// Copyright (c) 2017 iCrany. All rights reserved.
//

#import "UIFont+SKS.h"


static const NSString *kPingFangSCRegular   = @"PingFangSC-Regular";
static const NSString *kPingFangSCMedium    = @"PingFangSC-Medium";
static const NSString *kPingFangSCBold      = @"PingFangSC-Semibold";

@implementation UIFont (SKS)

+ (UIFont *)defaultFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:kPingFangSCRegular size:size];
}

+ (UIFont *)mediumDefaultFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:kPingFangSCMedium size:size];
}

+ (UIFont *)boldDefaultFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:kPingFangSCBold size:size];
}

@end