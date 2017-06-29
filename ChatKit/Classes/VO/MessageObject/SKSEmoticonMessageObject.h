//
//  SKSEmoticonMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSEmoticonMessageObject : NSObject<SKSChatMessageObject>


/**
 表情的元数据
 */
@property(nonatomic, strong) NSDictionary *emoticonMetaDictionary;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property(nonatomic, nullable, weak) SKSChatMessage *message;


/**
 表情的实例构造方法

 @param emoticonMetaDictionary 表情的元数据
 @return 表情的实例对象
 */
- (instancetype)initWithEmoticonMetaDictionary:(NSDictionary *)emoticonMetaDictionary;

@end

NS_ASSUME_NONNULL_END
