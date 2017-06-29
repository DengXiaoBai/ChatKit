//
//  SKSUserAdditionalMessagObject.m
//  ChatKit
//
//  Created by iCrany on 2016/12/13.
//
//

#import <Foundation/Foundation.h>
#import "SKSUserAdditionalMessagObject.h"
#import "SKSChatUserModel.h"

@implementation SKSUserAdditionalMessagObject

- (instancetype)initWithUserModel:(SKSChatUserModel *)userModel {
    self = [super init];
    if (self) {
        self.userModel = userModel;
    }
    return self;
}

@end
