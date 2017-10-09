//
//  SKSChatMessageViewController.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//


@class SKSChatMessage;
@class SKSChatMessageModel;
@protocol SKSChatCellLayoutConfig;
@protocol SKSChatSessionConfig;
@class SKSKeyboardView;

#import "SKSChatMessageConstant.h"

/**
 聊天界面子类可以实现的自定义功能回调方法
 */
@protocol SKSChatMessageViewControllerDelegate <NSObject>


@optional
/**
 聊天界面发送消息回调, 只有在实现了自定义Keyboard界面控件的子类才需要实现该方法

 @param message 发送的消息实例
 */
- (void)didSendMessage:(SKSChatMessage *)message;


/**
 自定义 Cell 中的高度回调

 @param tableView Cell 所在的 tableView
 @param indexPath Cell 所在的 tableView
 @param messageModel Cell 当前的消息Model
 @return 自定义Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath targetMessageModel:(SKSChatMessageModel *)messageModel;


/**
 键盘中的更多按钮选项的回调, 使用默认键盘的子类必须实现该方法

 @param keyboardMoreType 键盘中更多选项中的点击按钮的类型
 */
- (void)onTapKeyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType;

/**
 初始化键盘控件的回调, 自定义键盘可实现该方法
 */
- (void)didInitKeyboardView;


/**
 初始化加载历史聊天记录控件的回调
 */
- (void)didInitLoadMoreMessageView;

@end


/**
 聊天界面子类可以实现的自定义数据源
 */
@protocol SKSChatMessageViewControllerDataSource <NSObject>

@required

/**
 数据源中的消息Model 的实例

 @param indexPath 消息的IndexPath
 @return 消息Model 的实例
 */
- (SKSChatMessageModel *)messageForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 子类自定义 UITableViewCell 的回调方法， 类似与 UITableViewDataSource 中的 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 方法

 @param tableView Cell 所在的 tableView
 @param indexPath Cell 所在的 indexPath
 @param messageModel Cell 所持有的 messageModel
 @return 自定义的 Cell 实例
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath targetMessageModel:(SKSChatMessageModel *)messageModel;


@end


@interface SKSChatMessageViewController : UIViewController

@property (nonatomic, weak) id<SKSChatMessageViewControllerDelegate> sksDelegate;
@property (nonatomic, weak) id<SKSChatMessageViewControllerDataSource> sksDataSource;

/**
 整个聊天的配置
 */
@property (nonatomic, strong) id<SKSChatSessionConfig> sessionConfig;

/**
 * 聊天 UITableView
 * */
@property (nonatomic, strong, readonly) UITableView *tableView;

/**
 * 整个聊天键盘视图
 * */
@property (nonatomic, strong, readonly) SKSKeyboardView *keyboardView;


/**
 是否滚动到最后一行

 @param isAnimated 是否做动画
 */
- (void)tableViewScrollToBottomWithIsAnimated:(BOOL)isAnimated;



/**
 初始化 MessageModel 里面的参数, 并且计算 Cell 的高度

 @param messageModel 消息Model
 */
- (void)prepareWithMessageModel:(SKSChatMessageModel *)messageModel;


@end
