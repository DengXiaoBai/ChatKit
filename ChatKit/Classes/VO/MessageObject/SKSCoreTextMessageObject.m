//
//  SKSAdministratorAuditCoreTextMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSCoreTextMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSCoreTextMessageObject

- (instancetype)initWithHtmlText:(NSString *)htmlText{
    self = [super init];
    if (self) {
        self.htmlText = htmlText;
    }

    return self;
}


#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeCoreText;
}

@end
