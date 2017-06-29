//
//  NSData+SKS.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SKS)

+ (NSString *)md5:(NSString *)str;

+ (NSString *)md5WithData:(NSData *)data;

@end
