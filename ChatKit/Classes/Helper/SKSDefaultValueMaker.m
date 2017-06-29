//
//  SKSDefaultValueMaker.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSDefaultValueMaker.h"
#import "SKSDefaultCellConfig.h"
#import "SKSDefaultChatSessionConfig.h"
#import "SKSDefaultCellLayoutConfig.h"
#import "SKSDefaultChatContentConfig.h"
#import "SKSDefaultKeyboardConfig.h"
#import "SKSChatKeyboardConfig.h"

@interface SKSDefaultValueMaker()

@property (nonatomic, strong) id<SKSChatCellConfig> defaultChatCellConfig;

@property (nonatomic, strong) id<SKSChatSessionConfig> defaultChatSessionConfig;

@property (nonatomic, strong) id<SKSChatCellLayoutConfig> defaultChatCellLayoutConfig;

@property (nonatomic, strong) id<SKSChatKeyboardConfig> defaultChatKeyboardConfig;

@end

@implementation SKSDefaultValueMaker

+ (instancetype)shareInstance {
    static SKSDefaultValueMaker *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SKSDefaultValueMaker alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.defaultChatCellConfig = [[SKSDefaultCellConfig alloc] init];
        self.defaultChatSessionConfig = [[SKSDefaultChatSessionConfig alloc] init];
        self.defaultChatCellLayoutConfig = [[SKSDefaultCellLayoutConfig alloc] init];
        self.defaultChatKeyboardConfig = [[SKSDefaultKeyboardConfig alloc] init];
    }
    return self;
}

- (id<SKSChatCellConfig>)getDefaultChatCellConfig {
    return self.defaultChatCellConfig;
}


- (id<SKSChatCellLayoutConfig>)getDefaultChatCellLayoutConfig {
    return self.defaultChatCellLayoutConfig;
}


- (id<SKSChatSessionConfig>)getDefaultSessionConfig {
    return self.defaultChatSessionConfig;
}

- (id<SKSChatKeyboardConfig>)getDefaultKeyboardConfig {
    return self.defaultChatKeyboardConfig;
}

@end
