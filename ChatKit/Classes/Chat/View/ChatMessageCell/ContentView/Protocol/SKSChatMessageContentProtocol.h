//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSChatMessageModel;


@protocol SKSChatMessageContentDelegate <NSObject>

@optional
/**
    聊天 Cell 中的內容的单击手势回调
 **/
- (void)chatMessageContentDidTapAction;

/**
    聊天 Cell 中的内容的长按手势回调
 * */
- (void)chatMessageContentDidLongPressAction;

/**
 * 聊天 Cell 中的内容视图里面的按钮点击回调
 * @param atIndex begin at 0
 */
- (void)chatBaseContentViewBtnActionAtIndex:(NSInteger)atIndex;

/**
 * 富文本中的链接点击事件回调, 对于非链接的点击事件，还是调用 chatMessageContentDidTapAction 方法
 * @param url 链接地址
 */
- (void)chatCoreTextDidTapAction:(NSURL *)url;

/**
 * 富文本中的链接长按事件回调, 对于非链接的长按事件，还是调用 chatMessageContentDidLongPressAction 方法
 * @param url 点击地址
 */
- (void)chatCoreTextDidLongPressAction:(NSURL *)url;

@end


/**
 聊天界面中具体的
 */
@protocol SKSChatMessageContentProtocol <NSObject>

@property (nonatomic, weak) id<SKSChatMessageContentDelegate> delegate;

/**
 消息UI中统一的初始化方法

 @param messageModel 具体的消息实例，必须是 SKSMessageModel 实例
 @return 实现了 SKSChatMessageContentProtocol 协议的 UI 实例
 */
- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * Cell ContentView 的UI 更新操作
 * @param messageModel 消息Model
 * @param force 是否强制刷新
 *
 * */
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

@end
