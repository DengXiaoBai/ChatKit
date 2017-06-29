//
//  SKSKeyboardBaseMoreView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSKeyboardMoreViewProtocol.h"

@protocol SKSKeyboardMoreViewItemProtocol;

@interface SKSKeyboardBaseMoreView : UIView <SKSKeyboardMoreViewProtocol>

@property (nonatomic, strong) NSArray *keyboardMoreItemList;
@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;

@property (nonatomic, weak) id<SKSKeyboardMoreViewActionDelegate> actionDelegate;

- (void)updateKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

@end
