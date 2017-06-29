//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKSKeyboardMoreViewItemProtocol;
@protocol SKSChatCellLayoutConfig;
@protocol SKSChatCellConfig;
@class SKSChatMessage;
@class SKSChatMessageModel;
@protocol SKSChatContentConfig;
@protocol SKSChatKeyboardConfig;


/**
 用于配置整个聊天的可配置类的设置
 @discussion 由于会话中可能跟 好友，陌生人，消息通知，管理员等不同类型进行聊天所以可能会有不同的一些配置信息
 */
@protocol SKSChatSessionConfig <NSObject>

#pragma mark - 聊天中的默认头像配置

/**
 聊天中的默认头像

 @return 默认头像
 */
- (UIImage *)defaultAvatar;

#pragma mark - 时间标签中的配置


/**
 两条消息相隔多久才显示时间标签出来

 @return 时间标签显示的时间间隔，单位为 秒
 */
- (NSTimeInterval)showTimestampInterval;


#pragma mark - 聊天中的录音的配置

/**
 最大的录音时长

 @return 录音时长，单位为 秒
 */
- (NSTimeInterval)maxRecordDuration;

#pragma mark - 聊天中气泡的配置

/**
 气泡尖角偏移量

 @return 气泡尖角的偏移量
 */
- (CGFloat)getBubbleViewArrowWidth;

#pragma mark - 聊天中消息的排版配置


/**
 消息的排版配置
 @discussion 可以实现 SKSChatCellLayoutConfig 协议来实现自定义配置类, 每次新的消息（未计算Cell高度或强制刷新的都算新消息）的都会调用一次该接口
 获取到相对应的排版配置信息，nil 则使用 SKSDefaultChatCellLayoutConfig 配置类
 @param message 需排版的消息实例
 @return 对应的排版配置
 */
- (id<SKSChatCellLayoutConfig>)layoutConfigWithMessage:(SKSChatMessage *)message;


/**
 消息的UI配置

 @param message 需要获取UI配置的实例
 @return 消息的UI配置实例
 */
- (id<SKSChatCellConfig>)chatCellConfigWithMessage:(SKSChatMessage *)message;

/**
 * 获取具体的聊天Cell中的内容配置的实例
 * @param messageModel 需要获取Cell内容配置的消息Model实例
 * @return Cell中的内容配置实例
 */
- (id<SKSChatContentConfig>)chatContentConfigWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 获取聊天中的键盘配置实例
 * @return 键盘配置实例
 */
- (id<SKSChatKeyboardConfig>)chatKeyboardConfig;


#pragma mark - 聊天中气泡的名称
- (NSString *)bubbleImageNameWithSKSMessageModel:(SKSChatMessageModel *)messageModel;


/**
 * 用于已读标签的文案,便于国际化
 * */
- (NSString *)getReadLabelTextWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 获取MessageCell 中的头像的实现View 的类名称
 * */
- (NSString *)getAvatarButtonClassNameWithMessageModel:(SKSChatMessageModel *)messageModel;


@end
