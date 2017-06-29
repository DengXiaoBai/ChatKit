//
//  ChatDefaultValueMaker.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/16.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatMessageConstant.h>

@protocol SKSChatKeyboardConfig;
@protocol SKSChatSessionConfig;

@interface ChatDefaultValueMaker : NSObject

+ (ChatDefaultValueMaker *)shareInstance;

- (id<SKSChatKeyboardConfig>)getChatKeyboardConfig;
- (id<SKSChatSessionConfig>)getDefaultSessionConfig;
- (id<SKSChatCellConfig>)getDefaultChatCellConfig;
- (id<SKSChatCellLayoutConfig>)getDefaultChatCellLayoutConfig;

@end
