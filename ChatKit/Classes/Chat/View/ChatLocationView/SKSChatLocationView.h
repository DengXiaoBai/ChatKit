//
//  SKSChatLocationView.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKSChatMessageModel;

@protocol SKSChatLocationViewDelegate <NSObject>


/**
 获取本地缓存的地理位置截图信息

 @param messageModel 消息 Model
 @param success 成功的回调
 */
- (void)SKSChatLocationViewDidGetImageWithMessageModel:(SKSChatMessageModel *)messageModel success:(void(^)(UIImage *image))success;


/**
 地图SDK 重新截图

 @param messageModel 消息 Model
 */
- (void)SKSChatLocationViewDidGetSnapshotImageWithMessageModel:(SKSChatMessageModel *)messageModel;

@end

@interface SKSChatLocationView : UIView

@property (nonatomic, weak) id<SKSChatLocationViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

@end
