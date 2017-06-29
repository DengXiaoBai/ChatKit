//
//  ChatDefaultValueMaker.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/16.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSDefaultCellConfig.h>
#import <ChatKit/SKSDefaultCellLayoutConfig.h>
#import <ChatKit/SKSDefaultKeyboardConfig.h>
#import "ChatDefaultValueMaker.h"
#import "ChatSessionConfig.h"

@interface ChatDefaultValueMaker()

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, strong) id<SKSChatCellConfig> cellConfig;
@property (nonatomic, strong) id<SKSChatCellLayoutConfig> chatCellLayoutConfig;
@property (nonatomic, strong) id<SKSChatSessionConfig> defaultChatSessionConfig;

@end

@implementation ChatDefaultValueMaker

+ (ChatDefaultValueMaker *)shareInstance {
    static ChatDefaultValueMaker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ChatDefaultValueMaker alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _keyboardConfig = [[SKSDefaultKeyboardConfig alloc] init];
        self.cellConfig = [[SKSDefaultCellConfig alloc] init];
        self.chatCellLayoutConfig = [[SKSDefaultCellLayoutConfig alloc] init];
        self.defaultChatSessionConfig = [[ChatSessionConfig alloc] init];
    }
    return self;
}

- (id<SKSChatKeyboardConfig>)getChatKeyboardConfig {
    return _keyboardConfig;
}

- (id<SKSChatCellConfig>)getDefaultChatCellConfig {
    return _cellConfig;
}

- (id<SKSChatCellLayoutConfig>)getDefaultChatCellLayoutConfig {
    return _chatCellLayoutConfig;
}

- (id<SKSChatSessionConfig>)getDefaultSessionConfig {
    return self.defaultChatSessionConfig;
}


@end
