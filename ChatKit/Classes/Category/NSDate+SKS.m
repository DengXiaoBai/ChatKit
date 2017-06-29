//
// Created by iCrany on 2017/3/2.
//

#import "NSDate+SKS.h"


@implementation NSDate (SKS)

+ (int64_t)getCurrentSystemMicrosecond {
    return [[[NSDate alloc] init] timeIntervalSince1970] * 1000 * 1000;
}

@end