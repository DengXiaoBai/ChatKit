//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSChatMessageModel;


/**
 1. 聊天 Cell 中的 ContentView (气泡视图中的具体控件,例如 TextCell 中的 UILabel, 以及 PhotoCell 中 UIImageView 等控件) 的界面配置类, 例如大小，与气泡视图(BubbleView)的边距
 2. 聊天 Cell 中的 BubbleView 与 Cell 之间的边距，BubbleView 的大小由 (ContentView.size 与 ContentView 与 BubbleView 的边距两个参数来确定)
 */
@protocol SKSChatContentConfig <NSObject>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;

/**
 * 聊天Cell中具体内容的大小，例如 TextCell 中，UILabel 的宽度,不包括聊天气泡的大小
 * @param cellWidth 聊天Cell的宽度
 * @return 聊天Cell中具体内容的大小
 */
- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth;

/**
 * 聊天Cell中具体内容类的 Class name，这里规定返回实现了 SKSChatMessageContentProtocol 协议的类
 * @return 聊天Cell中具体内容类的 Class name
 */
- (NSString *)cellContentClass;

/**
 * 唯一标识符，主要用于 UITableView 的重用标志
 * @return 该配置类的唯一标识符
 */
- (NSString *)cellContentIdentifier;

/**
 * 聊天中具体内容于气泡视图之间的间距，例如 TextCell 中, BubbleImageView(气泡视图)与 UILabel 控件之间的间距
 * @return 聊天中具体内容与气泡之间的间距
 */
- (UIEdgeInsets)contentViewInsets;

/**
 * 聊天中气泡视图与 Cell 之间的边距（不考虑时间标签的情况）
 * 默认是居中，所有左右边距忽略, 下边距由时间标签下面的控件来控制，只有上边距设置才起效果
 * @return 气泡视图与 Cell 之间的边距
 */
- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation;

/**
 * 更新 MessageModel 实例, 以及对应的配置信息
 * @param messageModel 消息 Model
 */
- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel;


@optional

/**
 * 时间标签视图与 Cell 之间的边距
 * @return 时间标签视图与 Cell 之间的边距
 */
- (UIEdgeInsets)timestampViewInsets;

/**
 * 时间标签视图的大小
 * @return 时间标签视图的大小
 */
- (CGSize)timestampViewSize;

@end
