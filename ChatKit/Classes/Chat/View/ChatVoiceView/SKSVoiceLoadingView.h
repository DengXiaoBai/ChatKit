//
//  SKSVoiceLoadingView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//



@interface SKSVoiceLoadingView : UIView

- (instancetype)initWithBottomImage:(UIImage *)bottomImage topImage:(UIImage *)topImage;

//Public method
- (void)doAnimation:(BOOL)isAnimation;

@end
