//
// Created by iCrany on 2016/12/15.
//

#import <Foundation/Foundation.h>

@class SKSChatMessageModel;

@protocol SKSMessageAvatarProtocol <NSObject>

@property(nonatomic, strong) SKSChatMessageModel *messageModel;

- (instancetype)initWithFrame:(CGRect)frame messageModel:(SKSChatMessageModel *)messageModel;

/**
 * 下载用户头像逻辑
 * */
- (void)downloadAvatarImageWithCompletion:(void(^)(UIImage *avatarImage))completion;

@end