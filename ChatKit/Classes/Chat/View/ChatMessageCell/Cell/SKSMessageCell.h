//
//  SKSMessageCell.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatBaseCell.h"
#import "SKSChatMessageConstant.h"

@protocol ChatMessageModel;

@class SKSChatMessage;
@class SKSChatBaseContentView;
@class SKSChatMessageModel;
@class SKSVoiceLoadingView;
@class SKSMessageCell;


@protocol SKSMessageCellDelegate <NSObject>

@optional

/**
 点击发送失败回调

 @param messageModel 消息Model
 */
- (void)messageCellDidTapFailBtnAction:(SKSChatMessageModel *)messageModel;



/**
 点击用户头像回调

 @param messageModel 消息Model
 */
- (void)messageCellDidTapAvatarBtnAction:(SKSChatMessageModel *)messageModel;



/**
 消息的长按回调
 
 @param messageModel 消息Model
 */
- (void)messageCellDidLongPressAction:(SKSChatMessageModel *)messageModel inView:(UIView *)inView;


/**
    消息被单击后的回调
  @param messageModel 消息 Model
  @param cell cell 实例
 */
- (void)messageCellDidTapAction:(SKSChatMessageModel *)messageModel cell:(SKSMessageCell *)cell;

/**
    消息单击时触发的功能事件回调
    @param messageModel 消息 model
    @param messageFunctionType 触发的功能事件类型
    @param entity 需要传递的参数
 */
- (void)messageCellDidTapFunctionAction:(SKSChatMessageModel *)messageModel messageFunctionType:(SKSMessageFunctionType)messageFunctionType entity:(id)entity;


/**
   用户点击消息菜单的回调
  @param messageModel 消息Model
  @param menuItemType 用户点击的消息菜单类型
 */
- (void)messageCellDidTapMenuItemWithMessageModel:(SKSChatMessageModel *)messageModel menuItemType:(SKSMessageMenuSelectType)menuItemType;


/**
 自定义Cell ContentView 中的点击回调

 @param messageModel 消息Model
 @param buttonIndex 用户点击的Button Index
 */
- (void)messageCellDidCustomTapAction:(SKSChatMessageModel *)messageModel buttonIndex:(NSInteger)buttonIndex;

@end

/**
 聊天中实现的默认 UITableViewCell， 由头像，时间标签栏，气泡视图，其他（加载中，发送失败，分享，已读，未读消息，新好友）四大模块组成
 */
@interface SKSMessageCell : SKSChatBaseCell

@property (nonatomic, strong, readonly) SKSChatBaseContentView *bubbleContentView;

@property (nonatomic, weak) id<SKSMessageCellDelegate> delegate;

@property (nonatomic, strong, readonly) SKSChatMessageModel *messageModel;

/**
 更新 UITableViewCell 中的 UI

 @param messageModel 消息Model
 */
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 只是更新UI的状态，例如 loading, sendFail, 已读，未读，语音播放的状态
 */
- (void)updateUIStateState:(SKSChatMessageModel *)messageModel;

@end
