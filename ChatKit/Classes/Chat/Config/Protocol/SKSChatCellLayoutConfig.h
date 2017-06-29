//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSChatMessage;
@class SKSChatMessageModel;


/**
 具体计算气泡的大小的 UI 配置
 @discussion 至于应该距离多少的配置都在实现 SKSChatUIConfig 协议的类中实现
 */
@protocol SKSChatCellLayoutConfig <NSObject>

@optional


/**
 返回Cell中 ContentView 的 Class 名称
 
 @param messageModel 消息Model
 @return 返回Cell中 ContentView 的 Class 名称
 */
- (NSString *)getCellContentViewClassNameWithMessageModel:(SKSChatMessageModel *)messageModel;


/**
 返回 Cell 中向 UITableView 重用注册的 Identifier
 @discussion 因为有接收方以及发送发，所以这里根据 1：接受还是注册 2：具体的 ContentView 的 className 来生成该 Identifier
 
 @param messageModel 消息Model
 @return 返回对应消息的 Identifier
 */
- (NSString *)getCellIdentifierWithMessageModel:(SKSChatMessageModel *)messageModel;


/**
 获取聊天 Cell 中的具体的内容控件的大小

 @param messageModel 消息Model
 @param cellWidth cell 的宽度
 @return Cell 中内容控件的大小
 */
- (CGSize)getContentSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth;



/**
 聊天 Cell 中BubbleView与整个Cell的之间的间距, 需要考虑时间标签是否显示的影响

 @param messageModel 消息Model
 @return BubbleView距离Cell的间距
 */
- (UIEdgeInsets)getBubbleViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel;


/**
 聊天 Cell 中 BubbleView 的边距(不是到整个 Cell 之间的边距)， 不需要考虑时间标签的情况

 @param messageModel 消息Model
 @return BubbleView 的边距
 */
- (UIEdgeInsets)getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:(SKSChatMessageModel *)messageModel;



/**
 聊天 Cell 中 ContentView 于 气泡的之间的间距

 @param messageModel 消息Model
 @return ContentView距离 气泡之间的间距
 */
- (UIEdgeInsets)getContentViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel;



/**
 是否显示头像

 @param messageModel 消息Model
 @return 是否显示头像
 */
- (BOOL)shouldShowAvatar:(SKSChatMessageModel *)messageModel;



/**
 头像距离 cell 的边距

 @discussion 如果头像在左边， 则 top, left 参数是有用的， 如果头像在右边， 则 top, right 参数是有用的
 @param messageModel 消息Model
 @return 头像距离 Cell 的边距
 */
- (UIEdgeInsets)avatarViewInsets:(SKSChatMessageModel *)messageModel;


/**
 隐藏头像的时候需要的占位边距

 @param messageModel 消息Model
 @discussion 例如发送消息的时候可能不需要隐藏头像，这个时候可能需要一定的边距
 @return 隐藏头像的时候需要的占位边距
 */
- (UIEdgeInsets)notShowAvatarViewInsets:(SKSChatMessageModel *)messageModel;


/**
 获取头像的大小
 
 @param messageModel 消息 Model
 @return 头像的大小
 */
- (CGSize)avatarViewSize:(SKSChatMessageModel *)messageModel;



/**
 是否显示时间标签

 @param messageModel 消息Model
 @return 是否显示时间标签
 */
- (BOOL)shouldShowTimestamp:(SKSChatMessageModel *)messageModel;


/**
 时间标签的边距

 @param messageModel 消息Model
 @return 时间标签的边距
 */
- (UIEdgeInsets)timestampViewInsets:(SKSChatMessageModel *)messageModel;


/**
 时间标签的大小, 宽度是不使用的，这里只有高度是设置的

 @param messageModel 消息 Model
 @return 时间标签的大小
 */
- (CGSize)timestampViewSize:(SKSChatMessageModel *)messageModel;


/**
 是否已读标签的边距

 @param messageModel 消息Model
 @return 是否已读标签的边距
 */
- (UIEdgeInsets)readLabelViewInsets:(SKSChatMessageModel *)messageModel;

@end
