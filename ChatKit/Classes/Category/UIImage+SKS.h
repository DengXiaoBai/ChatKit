//
// Created by iCrany on 2016/12/12.
//

#import <Foundation/Foundation.h>

@interface UIImage (SKS)

#pragma mark - Color
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - Alpha
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;


#pragma mark - Scale
+ (UIImage *)getSubImage:(CGRect)rect
                   image:(UIImage *)image;

+ (UIImage *)reSizeImage:(UIImage *)image
                  toSize:(CGSize)size;

- (UIImage *)resizeImage:(CGSize)newSize
    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizeImageWithContentMode:(UIViewContentMode)contentMode
                                 bounds:(CGSize)bounds
                   interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizeImage:(CGSize)newSize
               transform:(CGAffineTransform)transform
          drawTransposed:(BOOL)transpose
    interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

+ (CGSize)calcScaledSize:(CGSize)origin bound:(CGSize)size;

@end
