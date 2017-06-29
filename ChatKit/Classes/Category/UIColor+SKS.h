//
// Created by iCrany on 2016/12/7.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (SKS)

+ (UIColor*) randomColor;

+ (NSString *)randomHexColorStr;

/**
 * 十六进制 的色值转换成 UIColor 实例
 *  @param hexString 十六进制的形式，例如: "#123456" or "123456"
 * */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
