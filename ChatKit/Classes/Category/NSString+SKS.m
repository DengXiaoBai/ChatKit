//
// Created by iCrany on 2016/12/7.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "NSString+SKS.h"


@implementation NSString (SKS)

- (CGSize)getSizeWithFont:(UIFont *)font {
    CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName: font}];
    return textSize;
}

+ (NSString *)formatTimeWithTime:(int32_t)duration {
    //格式化计时工具
    NSString *durationStr = [NSString stringWithFormat:@"%2ld:%02ld",(long)0, (long)0];//前面是占两位只是不会补0
    if (duration > 0) {
        NSInteger m = duration / 60;
        NSInteger s = duration % 60;
        durationStr = [NSString stringWithFormat:@"%2ld:%02ld", (long)m, (long)s];
    }
    return durationStr;
}

@end
