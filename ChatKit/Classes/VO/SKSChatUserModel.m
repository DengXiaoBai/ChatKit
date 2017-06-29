//
//  SKSChatUserModel.m
//  Pods
//
//  Created by iCrany on 2016/12/12.
//
//

#import "SKSChatUserModel.h"
#import "SKSChatUserObject.h"

@implementation SKSChatUserModel

- (instancetype)initWithActiveTime:(int64_t)activeTime
                          birthday:(int32_t)birthday
                            userId:(NSString *)userId
                          nickname:(NSString *)nickname
                         avatarUrl:(NSString *)avatarUrl
                  relationshipType:(SKSChatRelationshipType)relationshipType
                            gender:(SKSChatGender)gender {
    self = [super init];
    if (self) {
        self.activeTime = activeTime;
        self.birthday = birthday;
        self.userId = userId;
        self.nickname = nickname;
        self.avatarUrl = avatarUrl;
        self.relationshipType = relationshipType;
        self.gender = gender;
    }
    return self;
}


@end
