//
//  SKSMessageAvatarButton.m
//  ChatKit
//
//  Created by iCrany on 2016/12/15.
//
//

#import "SKSMessageAvatarButton.h"
#import "SKSChatMessageModel.h"

@implementation SKSMessageAvatarButton

- (instancetype)initWithFrame:(CGRect)frame messageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.messageModel = messageModel;
    }
    return self;
}

- (void)downloadAvatarImageWithCompletion:(void(^)(UIImage *avatarImage))completion {
    completion([UIImage imageNamed:@""]);
}

@end
