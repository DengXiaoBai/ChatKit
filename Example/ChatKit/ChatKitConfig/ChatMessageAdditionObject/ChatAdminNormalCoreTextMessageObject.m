//
//  ChatAdminNormalCoreTextMessageObject.m
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//

#import "ChatAdminNormalCoreTextMessageObject.h"

@implementation ChatAdminNormalCoreTextMessageObject

- (instancetype)initWithHtmlText:(NSString *)htmlText title:(NSString*)title{
    self = [super initWithHtmlText:htmlText];
    if (self) {
        self.title = title;
    }
    
    return self;
}

- (NSString *)iconImageName {
    return @"chat-session-select-date";
}

@end
