//
// Created by iCrany on 2016/12/7.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SKS)

- (CGSize)getSizeWithFont:(UIFont *)font;

+ (NSString *)formatTimeWithTime:(int32_t)duration;

@end
