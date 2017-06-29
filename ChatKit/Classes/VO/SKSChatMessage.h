//
//  SKSChatMessage.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageConstant.h"
@protocol SKSChatMessageObject;
@protocol SKSMenuItemProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface SKSChatMessage : NSObject


/**
 消息的唯一标识
 */
@property (nonatomic, assign) int64_t messageId;


/**
 消息的信息内容, 仅限 文本 以及 Yo , 富文本 , Tip 四种纯文本类型，其他类型该值都是为 nil
 */
@property (nonatomic, nullable, strong) NSString *text;


/**
 发送及接受消息两者之间的关系
 @discussion 例如关系可以有管理员，好友，陌生人等
 */
@property (nonatomic, assign) SKSChatRelationshipType relationshipType;


/**
 消息的来源
 @discussion 发送消息，还是属于接收的消息, 暂且只有这两种类型
 */
@property (nonatomic, assign) SKSMessageSourceType messageSourceType;


/**
 消息发送者的唯一标识
 */
@property (nonatomic, strong) NSString *fromId;


/**
 消息接收者的唯一标识
 */
@property (nonatomic, strong) NSString *toId;


/**
 客户端本地消息是否已读, 本地客户端的已读未读功能，不涉及接收方中的已读未读
 */
@property (nonatomic, assign) BOOL isRead;


/**
 消息的类型
 */
@property (nonatomic, assign) SKSMessageMediaType messageMediaType;


/**
 * 消息的发送状态
 * @discussion 发送成功或者发送中或者发送失败
 */
@property (nonatomic, assign) SKSMessageDeliveryState messageDeliveryState;



/**
 发送消息的 Unix 时间戳
 @discussion 一开始为本地手机的时间戳，在接受到服务器的返回消息后会自动修正为服务器的时间戳，可能存在误差
 */
@property (nonatomic, assign) NSTimeInterval timestamp;

/**
 格式化后的 时间戳标识
 * */
@property (nonatomic, strong) NSString *timestampDesc;


/**
 该参数用于防止用户多次收到同一条消息，出于网络复杂情况，有可能出现客户端认为该消息发送失败，但是服务器实际上已经发送成功了,
 计算方法:
 NSString *str = [NSString stringWithFormat:@"%@%@%@%lld", fromId, toId, content, createTime];
 NSString *digestStr = [NSData sha256ReturnStrWithStr:str];//SHA-256 算法计算 hash 值
 */
@property (nonatomic, nullable, strong) NSString *digest;


/**
 * 该消息的接收方是否支持已读未读功能
 */
@property (nonatomic, assign) BOOL supportReadUnReadFunction;

/**
 * 该消息接收方接受到该消息的 msgId
 */
@property (nonatomic, assign) int64_t toMsgId;

/**
 * 是否成功标记该条为已读的状态
 */
@property (nonatomic, assign) BOOL isMarkAsReadSuccess;


/**
 消息的附加内容
 @discussion 例如具体的图片消息，表情消息，语音消息等, 这些消息都需实现 SKSChatMessageObject 协议, 例如 SKSPhotoMessageObject，SKSEmoticonMessageObject等
 */
@property (nonatomic, strong, nullable) id<SKSChatMessageObject> messageAdditionalObject;

/**
 * 消息长按后显示的菜单选项显示,0 在菜单的最左边
 */
@property (nullable, nonatomic, strong) NSArray<id<SKSMenuItemProtocol>> *menuItemList;

@end

NS_ASSUME_NONNULL_END
