//
//  SKSEmoticonButton.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSChatMessageConstant.h"

@class SKSEmoticonMeta;

@interface SKSEmoticonButton : UIButton

@property (nonatomic, strong) SKSEmoticonMeta *emoticonMeta;

@property (nonatomic, assign) SKSEmoticonMetaType emoticonMetaType;

#pragma mark - Public method

/**
 是否显示按钮缩小的动画

 @param isSmallAnimation 是否做动画
 */
- (void)doScaleSmallAnimation:(BOOL)isSmallAnimation;

/**
 * 更新 EmoticonMeta， 并且由该类来负责资源的加载工作, 这里请尽量使用异步操作
 * */
- (void)updateEmoticonMeta:(SKSEmoticonMeta *)emoticonMeta;

@end
