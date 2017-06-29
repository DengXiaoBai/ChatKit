//
//  SKSShapeProgressView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//


@interface SKSShapeProgressView : UIView

- (instancetype)initWithLineColor:(UIColor *)lineColor backgroundColor:(UIColor *)backgroundColor;

- (void)littleDotHidden:(BOOL)hidden;
- (void)setLineColor:(UIColor *)lineColor;

@end
