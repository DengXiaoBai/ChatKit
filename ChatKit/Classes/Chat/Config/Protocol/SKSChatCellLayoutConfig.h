//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSChatMessage;
@class SKSChatMessageModel;


/**
 Cell 布局的配置协议
 1. Cell 类名，Cell Identifier，ContentView Size
 2. BubbleView(气泡视图)与 Cell 之间的边距
 3. ContentView 与 BubbleView(气泡视图)之间的边距
 4. 头像视图与 Cell 之间的边距，头像视图大小
 5: 时间标签视图大小，时间标签视图与 Cell 之间的边距
 6: 已读/未读视图与 Cell 之间的边距
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
 返回 Cell 中向 UITableView 重用时注册的 Identifier
 @discussion 因为有接收方以及发送发，所以这里根据 1：接受方还是接受方 2：具体的 ContentView 的 className 来生成该 Identifier，其他情况请具体分析来设置该参数
 
 @param messageModel 消息Model
 @return 返回 Cell 的 Identifier
 */
- (NSString *)getCellIdentifierWithMessageModel:(SKSChatMessageModel *)messageModel;


/**
 获取聊天 Cell 中的 ContentView 的大小, 例如 SKSLocationContentView, SKSChatPhotoContentView 等的大小

 @param messageModel 消息Model
 @param cellWidth cell 的宽度
 @return Cell 中 ContentView 的大小
 */
- (CGSize)getContentSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth;



/**
 聊天 Cell 中气泡视图与整个 Cell 之间的间距, 需要考虑时间标签视图是否显示的影响

 @param messageModel 消息Model
 @return BubbleView（气泡视图） 与 Cell 之间的间距
 */
- (UIEdgeInsets)getBubbleViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel;


/**
 聊天 Cell 中气泡视图与整个 Cell 之间的边距，不需要考虑时间标签的情况

 @param messageModel 消息Model
 @return BubbleView（气泡视图） 与 Cell 之间的间距
 */
- (UIEdgeInsets)getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:(SKSChatMessageModel *)messageModel;



/**
 聊天 Cell 中 ContentView 与 气泡视图之间的间距

 @param messageModel 消息Model
 @return ContentView 与气泡视图之间的间距
 */
- (UIEdgeInsets)getContentViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel;



/**
 是否显示头像视图

 @param messageModel 消息Model
 @return 是否显示头像视图
 */
- (BOOL)shouldShowAvatar:(SKSChatMessageModel *)messageModel;



/**
 头像视图 与 cell 之间的间距

 @discussion 如果头像在左边， 则 top, left 参数是有用的， 如果头像在右边， 则 top, right 参数是有用的
 @param messageModel 消息Model
 @return 头像视图 与 Cell 之间的间距
 */
- (UIEdgeInsets)avatarViewInsets:(SKSChatMessageModel *)messageModel;


/**
 隐藏头像视图的时候需要的占位边距

 @param messageModel 消息Model
 @discussion 例如发送消息方，需要隐藏头像视图，这个时候就需要一定的边距
 @return 隐藏头像的时候需要的占位边距
 */
- (UIEdgeInsets)notShowAvatarViewInsets:(SKSChatMessageModel *)messageModel;


/**
 头像视图的大小
 
 @param messageModel 消息 Model
 @return 头像视图的大小
 */
- (CGSize)avatarViewSize:(SKSChatMessageModel *)messageModel;


/**
 时间标签视图与 Cell 之间的边距

 @param messageModel 消息Model
 @return 时间标签视图与 Cell 之间的边距
 */
- (UIEdgeInsets)timestampViewInsets:(SKSChatMessageModel *)messageModel;


/**
 时间标签视图的大小, 宽度是根据内容来计算的，这里只有高度是需要自定义的，宽度是无效的，不能自定义

 @param messageModel 消息 Model
 @return 时间标签视图的大小
 */
- (CGSize)timestampViewSize:(SKSChatMessageModel *)messageModel;


/**
 已读/未读标签视图 与 Cell 之间的边距， 注意边距中 right 这个参数是相对于 BubbleView(气泡视图)的，其他都是针对 Cell 之间的边距

 @param messageModel 消息Model
 @return 已读/未读标签视图 与 Cell 之间的边距
 */
- (UIEdgeInsets)readLabelViewInsets:(SKSChatMessageModel *)messageModel;

@end
