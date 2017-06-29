//
//  SKSEmoticonMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSEmoticonMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSEmoticonMessageObject

- (instancetype)initWithEmoticonMetaDictionary:(NSDictionary *)emoticonMetaDictionary {
    self = [super init];
    if (self) {
        self.emoticonMetaDictionary = emoticonMetaDictionary;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeEmoticon;
}

@end
