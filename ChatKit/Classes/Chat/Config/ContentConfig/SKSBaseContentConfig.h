//
//  SKSBaseContentConfig.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/15.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatContentConfig.h"

@class SKSChatMessageModel;

/**
 * 聊天 Cell 中的 ContentConfig 基类
 */
@interface SKSBaseContentConfig : NSObject <SKSChatContentConfig>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;

@end
