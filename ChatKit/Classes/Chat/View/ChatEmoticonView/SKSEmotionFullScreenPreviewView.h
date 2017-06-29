//
//  EmotionFullScreenPreviewView.h
//  AtFirstSight
//
//  Created by iCrany on 15/12/24.
//  Copyright (c) 2015 Sachsen. All rights reserved.
//

@class SKSEmotionFullScreenPreviewView;

@interface SKSEmotionFullScreenPreviewView : UIView

- (instancetype)initWithEmotionDict:(NSDictionary *)emotionDict;

//Helper Method
- (void)resetEmotionDict:(NSDictionary *)emotionDict;

//public method
- (void)showEmotionFullScreenPreviewView:(BOOL)isShow;

@end
