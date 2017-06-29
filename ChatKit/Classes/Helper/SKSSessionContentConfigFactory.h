//
//  SKSSessionContentConfigFactory.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatContentConfig.h"
#import "SKSChatMessageModel.h"

@interface SKSSessionContentConfigFactory : NSObject

+ (instancetype)shareInstance;

- (id<SKSChatContentConfig>)getConfigWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
