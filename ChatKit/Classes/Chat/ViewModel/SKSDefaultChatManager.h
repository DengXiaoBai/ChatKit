//
//  SKSDefaultChatManager.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//


#import "SKSChatManagerProtocol.h"

/**
 实现聊天中网络请求相关操作,例如发送文字，语音，图片等网络请求，中途会有 willSendMessage: didSendMessage: 的过程回调
 */
@interface SKSDefaultChatManager : NSObject <SKSChatManagerProtocol>

@end
