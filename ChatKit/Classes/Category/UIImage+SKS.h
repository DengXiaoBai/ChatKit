//
// Created by iCrany on 2016/12/12.
//

#import <Foundation/Foundation.h>

@interface UIImage (SKS)

#pragma mark - Color
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - Alpha
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

@end
