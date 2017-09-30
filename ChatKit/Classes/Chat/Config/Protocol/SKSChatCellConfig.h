//
// Created by iCrany on 2016/11/10.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSChatMessageModel;

/**
 * ChatCell 中 气泡视图,已读/未读视图，整个 Cell 的背景色，时间标签视图，发送失败视图的配置
 */
@protocol SKSChatCellConfig <NSObject>


#pragma mark - 聊天中普通文字控件的配置

/**
 * 聊天界面中纯文本视图最小的 Size，例如 TextCell 中 UILabel 的最小 Size
 * @return 聊天界面正常的纯文本的最小 Size
 */
- (CGSize)chatNormalTextContentViewMinSize;

#pragma mark - 聊天中气泡控件的配置

/**
 * 聊天气泡的尖角的宽度
 * @return 聊天气泡的尖角的宽度
 */
- (CGFloat)getBubbleViewArrowWidth;


#pragma mark - 已读/未读控件的配置

/**
 * 已读/未读视图的字体
 * @return 已读/未读视图的字体
 */
- (UIFont *)chatReadLabelTextFont;

/**
 * 已读/未读视图的字体颜色
 * @return 已读/未读视图的字体颜色
 */
- (UIColor *)chatReadLabelTextColor;

/**
 * 已读/未读视图的 image, 需要根据消息是否已读来进行判断，如果 `- (BOOL)chatReadControlUseImageControlView` 方法返回为 true 的话，该参数才生效
 * 默认是放在 Assets 资源文件夹内
 * @param messageModel 消息 Model
 * @return image的名称
 */
- (NSString *)chatReadImageWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 已读/未读视图是否是使用 UIImage 的形式，否则则使用 UILabel 的形式
 * @return 是否使用UIImage形式的已读/未读视图
 */
- (BOOL)chatReadControlUseImageControlView;


#pragma mark - 整个Cell的配置

/**
 * 聊天 Cell 中的背景颜色
 * @return Cell的 backgroundColor 值
 */
- (UIColor *)chatMessageCellBackgroundColor;


#pragma mark - 时间标签视图的配置

/**
 * 时间标签视图的字体
 * @return 时间标签视图的字体
 */
- (UIFont *)chatTimestampLabelFont;

/**
 * 时间标签视图的字体颜色
 * @return 时间标签视图的字体颜色
 */
- (UIColor *)chatTimestampLabelTextColor;


/**
 * 聊天中时间标签视图的背景色
 * @return 聊天中时间标签视图的背景色
 */
- (UIColor *)chatTimestampLabelBackgroundColor;


#pragma mark - 发送失败视图的配置

/**
 * 消息发送失败的 icon 名称，默认是放在 Assets 资源文件夹内
 * @return 消息发送失败的 icon 名称
 */
- (NSString *)chatSendFailImageName;

@end
