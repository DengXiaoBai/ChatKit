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

@interface SKSEmotionToolScrollView : UIView

@property (nonatomic, weak) id<SKSEmotionToolScrollViewDelegate> delegate;

- (instancetype)initWithDataSourceList:(NSArray<SKSEmoticonCatalog *> *)emoticonCatalogList
                        keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

- (void)setSelectIndex:(NSInteger)selectIndex;
- (void)setSelectIndex:(NSInteger)selectIndex isScrollToPosition:(BOOL)isScrollToPosition;

- (void)emoticonToolSendBtnState:(SKSKeyboardEmoticonSendButtonState)buttonState;

@end
