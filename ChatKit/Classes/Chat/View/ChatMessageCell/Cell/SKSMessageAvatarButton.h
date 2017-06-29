//
//  SKSMessageAvatarButton.h
//  ChatKit
//
//  Created by iCrany on 2016/12/15.
//
//

#import "SKSMessageAvatarProtocol.h"

@class SKSChatMessageModel;

@interface SKSMessageAvatarButton : UIButton <SKSMessageAvatarProtocol>

@property(nonatomic, strong) SKSChatMessageModel *messageModel;

@end
