//
// Created by iCrany on 2016/12/7.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "UIColor+SKS.h"


@implementation UIColor (SKS)

+ (UIColor*) randomColor {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (NSString *)randomHexColorStr {
    NSInteger baseInt = arc4random() % 16777216;
    NSString *hex = [NSString stringWithFormat:@"%06X", baseInt];
    return hex;
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([hexString hasPrefix:@"#"]) {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}



@end
