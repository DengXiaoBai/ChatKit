//
//  SKSChatUserModel.h
//  Pods
//
//  Created by iCrany on 2016/12/12.
//
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageConstant.h"

@protocol SKSChatUserObject;

@interface SKSChatUserModel : NSObject

/**
 * 最近一次活跃时间戳
 * */
@property (nonatomic, assign) int64_t activeTime;

/**
 * 用户生日, 格式:19900102
 * */
@property (nonatomic, assign) int32_t birthday;

/**
 * 用于的唯一标识
 * */
@property (nonatomic, strong) NSString *userId;

/**
 * 用户名称
 * */
@property (nonatomic, strong) NSString *nickname;


/**
 *用户头像地址
 * */
@property (nonatomic, strong) NSString *avatarUrl;


/**
 *用户A于用户B的关系
 * */
@property (nonatomic, assign) SKSChatRelationshipType relationshipType;

/**
 *用户的性别
 * */
@property (nonatomic, assign) SKSChatGender gender;

/**
 *自定义额外的参数
 * */
@property (nonatomic, strong) id<SKSChatUserObject> userAdditionalObject;


- (instancetype)initWithActiveTime:(int64_t)activeTime
                          birthday:(int32_t)birthday
                            userId:(NSString *)userId
                          nickname:(NSString *)nickname
                         avatarUrl:(NSString *)avatarUrl
                  relationshipType:(SKSChatRelationshipType)relationshipType
                            gender:(SKSChatGender)gender;


@end
