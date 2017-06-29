//
//  ChatTestViewModel.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SKSChatSessionConfig;

@interface ChatTestViewModel : NSObject

/**
 SKSChatMessageModel 类型的数组
 */
@property (nonatomic, strong) NSMutableArray *messageList;

@property (nonatomic, weak) id<SKSChatSessionConfig> sessionConfig;


@end
