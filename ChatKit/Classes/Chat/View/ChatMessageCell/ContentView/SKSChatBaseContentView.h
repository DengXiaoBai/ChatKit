//
//  ChatBaseContentView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "SKSChatMessageContentProtocol.h"

@class SKSChatMessageModel;
@class SKSImageView;

@interface SKSChatBaseContentView : UIControl <SKSChatMessageContentProtocol>


@property (nonatomic, weak) id<SKSChatMessageContentDelegate> delegate;

/**
 消息Model
 */
@property (nonatomic, strong) SKSChatMessageModel *messageModel;

@property (nonatomic, strong) SKSImageView *bubbleImageView;

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel;

@end
