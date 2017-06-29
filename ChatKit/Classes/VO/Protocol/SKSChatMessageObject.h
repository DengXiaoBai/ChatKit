//
// Created by iCrany on 2016/11/10.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageConstant.h"

@class SKSChatMessage;
@protocol SKSMenuItemProtocol;

@protocol SKSChatMessageObject <NSObject>

@property (nullable, nonatomic, weak) SKSChatMessage *message;



@optional
/**
 消息内容类型

 @return 消息内容类型
 */
- (SKSMessageMediaType)messageMediaType;


@end
