//
//  SKSTypingMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSTypingMessageObject : NSObject<SKSChatMessageObject>

- (instancetype)initWithAnimationImageNameList:(NSArray<NSString *> *)animationImageNameList;

/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;

@property (nonatomic, strong) NSArray<NSString *> *animationImageNameList;

@end

NS_ASSUME_NONNULL_END
