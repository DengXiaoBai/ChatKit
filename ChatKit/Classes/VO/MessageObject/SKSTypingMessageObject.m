//
//  SKSTypingMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSTypingMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSTypingMessageObject

- (instancetype)initWithAnimationImageNameList:(NSArray<NSString *> *)animationImageNameList {
    self = [super init];
    if (self) {
        self.animationImageNameList = animationImageNameList;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    
    return SKSMessageMediaTypeTyping;
}

@end
