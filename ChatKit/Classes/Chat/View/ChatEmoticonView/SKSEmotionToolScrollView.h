//
//  EmotionToolScrollView.h
//  AtFirstSight
//
//  Created by iCrany on 15/12/24.
//  Copyright (c) 2015 Sachsen. All rights reserved.
//


#import "SKSChatMessageConstant.h"

@class SKSEmoticonCatalog;
@protocol SKSChatKeyboardConfig;


@protocol SKSEmotionToolScrollViewDelegate <NSObject>

- (void)emotionToolScrollViewDidSelectButtonAtIndex:(NSInteger)index;//单击选中了 index 的按钮

- (void)emoticonToolScrollViewDidSendAction;//点击了发送按钮

@end

/**
 * 聊天键盘中表情底部的菜单栏控件
 */
@interface SKSEmotionToolScrollView : UIView

@property (nonatomic, weak) id<SKSEmotionToolScrollViewDelegate> delegate;

/**
 * 创建表情底部菜单栏控件实例方法
 * @param emoticonCatalogList 所有的表情包目录列表
 * @param keyboardConfig 键盘的配置实例
 * @return 表情菜单栏控件实例
 */
- (instancetype)initWithDataSourceList:(NSArray<SKSEmoticonCatalog *> *)emoticonCatalogList
                        keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

/**
 * 设置选中的菜单栏位置，从 0 开始计数
 * @param selectIndex 选中的表情包位置
 */
- (void)setSelectIndex:(NSInteger)selectIndex;

/**
 * 设置选中的菜单栏位置，从 0 开始计数，并且表情是否滑动到该套表情的起始位置
 * @param selectIndex 选中的表情包位置
 * @param isScrollToPosition 是否滑动到选中的表情包的起始位置
 */
- (void)setSelectIndex:(NSInteger)selectIndex isScrollToPosition:(BOOL)isScrollToPosition;

/**
 * 表情发送按钮的状态
 * @param buttonState 发送按钮的状态，更多详情查看 `SKSKeyboardEmoticonSendButtonState`
 */
- (void)emoticonToolSendBtnState:(SKSKeyboardEmoticonSendButtonState)buttonState;

@end
