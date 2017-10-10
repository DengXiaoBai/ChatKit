//
//  SKSDefaultValueMaker.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SKSChatCellConfig;
@protocol SKSChatCellLayoutConfig;
@protocol SKSChatSessionConfig;
@protocol SKSChatContentConfig;
@protocol SKSChatKeyboardConfig;

/**
 * 生成默认的 ChatCellConfig / ChatCellLayoutConfig / SessionConfig / KeyboardConfig 等配置类实例
 */
@interface SKSDefaultValueMaker : NSObject


+ (instancetype)shareInstance;


- (id<SKSChatCellConfig>)getDefaultChatCellConfig;


- (id<SKSChatCellLayoutConfig>)getDefaultChatCellLayoutConfig;


- (id<SKSChatSessionConfig>)getDefaultSessionConfig;

- (id<SKSChatKeyboardConfig>)getDefaultKeyboardConfig;

@end
