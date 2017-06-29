//
//  SKSUserAdditionalMessagObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/13.
//
//

#import "SKSChatMessageObject.h"
#import "SKSChatUserObject.h"

@class NSString;

@interface SKSUserAdditionalMessagObject : NSObject <SKSChatUserObject>

@property(nonatomic, weak) SKSChatUserModel *userModel;

@property (nonatomic, assign) int64_t becomeFriendsTime;

@property (nonatomic, assign) BOOL isFacebookFriend;

@property (nonatomic, strong) NSString *activityList;

@property (nonatomic, strong) NSString *photoList;

@property (nonatomic, strong) NSString *coverUrl;

@property (nonatomic, assign) NSInteger everLikes;

@property (nonatomic, assign) NSInteger userStatus;

@property (nonatomic, assign) int32_t intimacy;

@end
