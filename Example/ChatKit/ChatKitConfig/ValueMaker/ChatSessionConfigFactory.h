//
//  ChatSessionConfigFactory.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/14.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//



@protocol SKSChatContentConfig;
@class SKSChatMessageModel;

@interface ChatSessionConfigFactory : NSObject

+ (instancetype)shareInstance;

- (id<SKSChatContentConfig>)getConfigWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
