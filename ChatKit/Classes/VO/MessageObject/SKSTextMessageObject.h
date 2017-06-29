//
//  SKSTextMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSTextMessageObject : NSObject <SKSChatMessageObject>


/**
 纯文本内容
 */
@property (nonatomic, nullable, strong) NSString *text;


/**
 该参数用于防止用户多次收到同一条消息，出于网络复杂情况，有可能出现客户端认为该消息发送失败，但是服务器实际上已经发送成功了,
 计算方法: 
 NSString *str = [NSString stringWithFormat:@"%@%@%@%lld", fromId, toId, content, createTime];
 NSString *digestStr = [NSData sha256ReturnStrWithStr:str];//SHA-256 算法计算 hash 值
 */
@property (nonatomic, nullable, strong) NSString *digest;



/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;


/**
 纯文本实例构造方法

 @param text 纯文本
 @param digest 消息 hash 值
 @return 纯文本实例
 */
- (instancetype)initWithText:(NSString *)text digest:(NSString *)digest;

@end

NS_ASSUME_NONNULL_END
