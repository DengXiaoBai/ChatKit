//
// Created by iCrany on 2016/12/30.
//

#import <Foundation/Foundation.h>

@protocol SKSChatSessionConfig;
@class SKSChatUserModel;

@protocol SKSEmoticonContainerViewProtocol <NSObject>

- (instancetype)initWithUserModel:(SKSChatUserModel *)userModel
                    sessionConfig:(id<SKSChatSessionConfig>)sessionConfig;

@end