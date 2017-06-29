//
//  SKSTextMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSTextMessageObject.h"
#import "SKSChatMessageConstant.h"
#import "SKSChatMessage.h"

@implementation SKSTextMessageObject

- (instancetype)initWithText:(NSString *)text digest:(NSString *)digest {
    self = [super init];
    if (self) {
        self.text = text;
        self.digest = digest;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    
    return SKSMessageMediaTypeText;
}

@end
