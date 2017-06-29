//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSChatMessageModel;
@class SKSChatMessage;

@protocol SKSChatManagerProtocol <NSObject>

@required

/**
 将要发生网络请求的回调, 包括数据库的读写操作都需在该方法里面实现

 @param messageModel 消息实例
 */
- (void)willSendMessage:(nonnull SKSChatMessageModel *)messageModel;



/**
 发送网络请求成功或者失败后的回调

 @param messageModel 消息实例
 @param error 失败原因, 成功则 error 参数为 nil
 */
- (void)didSendMessage:(nonnull SKSChatMessageModel *)messageModel error:(nullable NSError *)error;

@end



/**
 聊天消息网络请求代理
 */
@protocol SKSChatManagerDelegate <NSObject>



@end
