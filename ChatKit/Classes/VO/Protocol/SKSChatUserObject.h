//
// Created by iCrany on 2016/12/13.
//

#import <Foundation/Foundation.h>

@class SKSChatUserModel;

@protocol SKSChatUserObject <NSObject>

@property(nonatomic, weak) SKSChatUserModel *userModel;

- (instancetype)initWithUserModel:(SKSChatUserModel *)userModel;


@end