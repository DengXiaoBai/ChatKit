//
//  SKSChatMessageModel.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//


@class SKSChatMessage;
@protocol SKSChatCellConfig;
@protocol SKSChatCellLayoutConfig;
@protocol SKSChatSessionConfig;

@interface SKSChatMessageModel : NSObject

@property (nonatomic, strong) SKSChatMessage *message;


/**
 对应的 UI 配置类，自定义 UI 则实现 SKSChatUIConfig 协议
 */
@property (nonatomic, strong) id<SKSChatCellConfig> chatUIConfig;


/**
 聊天中具体的 ContentView，头像，已读标签， 布局配置类
 */
@property (nonatomic, strong) id<SKSChatCellLayoutConfig> layoutConfig;



/**
 聊天的功能配置
 */
@property (nonatomic, strong) id<SKSChatSessionConfig> sessionConfig;

/**
 * 聊天气泡的图片名称, 资源文件在 MainBundle 中
 * */
@property (nonatomic, strong) NSString *bubbleImageName;

/**
 * 消息的用户头像地址
 * */
@property (nonatomic, strong) NSString *avatarUrl;


//缓存该 message 对应的一些布局，大小, 以及是否需要显示时间标签的一些配置
@property (nonatomic, assign) CGSize contentViewSize;
@property (nonatomic, assign) UIEdgeInsets contentViewInsets;

@property (nonatomic, assign) UIEdgeInsets bubbleViewInsets;//该距离已经考虑时间标签的高度，不需要额外添加

@property (nonatomic, assign) BOOL shouldShowAvatar;
@property (nonatomic, assign) UIEdgeInsets avatarViewInsets;
@property (nonatomic, assign) CGSize avatarViewSize;

@property (nonatomic, assign) UIEdgeInsets readLabelViewInsets;//相对于 BubbleView 的边距


/**
 头像在气泡的顶部还是底部， 在底部则为 YES, 否则为 NO
 */
@property (nonatomic, assign) BOOL shouldAvatarOnBottom;

@property (nonatomic, assign) BOOL shouldShowTimestamp;//是否显示时间标签

@property (nonatomic, assign) BOOL shouldShowReadControl;//是否显示已读控件

@property (nonatomic, assign) CGSize timelabelSize;

@property (nonatomic, assign) UIEdgeInsets timelabelViewInsets;

@property (nonatomic, assign) UIEdgeInsets noTimestampBubbleViewInsets;


/**
 构造方法

 @param message 消息实例
 @return 消息Model 实例
 */
- (instancetype)initWithMessage:(SKSChatMessage *)message;



/**
 计算内容大小

 @param width Cell宽度
 @param force 是否需要强制计算
 */
- (void)calculateContent:(CGFloat)width force:(BOOL)force;


/**
 默认头像

 @return 默认头像
 */
- (UIImage *)defaultAvatarImage;


@end
