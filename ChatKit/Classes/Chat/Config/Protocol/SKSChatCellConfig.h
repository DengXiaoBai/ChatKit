//
// Created by iCrany on 2016/11/10.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSChatMessageModel;

/**
 聊天以及用户列表的 UI 配置
 */
@protocol SKSChatCellConfig <NSObject>


#pragma mark - 聊天中普通文字控件的配置

/**
 聊天界面正常的纯文本的最小大小, 只是文字控件的消息，不包括气泡的大小

 @return 聊天界面正常的纯文本的最小大小
 */
- (CGSize)chatNormalTextContentViewMinSize;

#pragma mark - 聊天中气泡控件的配置

/**
 聊天气泡的尖角的宽度，一个大概值, 作为微调

 @return 气泡尖角的宽度
 */
- (CGFloat)getBubbleViewArrowWidth;


/**
 聊天 Cell 中已读标签的字体

 @return 已读标签的字体
 */
- (UIFont *)chatReadLabelTextFont;


/**
 聊天 Cell 中已读标签的字体颜色

 @return 已读标签的字体颜色
 */
- (UIColor *)chatReadLabelTextColor;

/**
 *获取聊天中的已读标签的 image, 需要根据消息是否已读来进行判断
 * */
- (NSString *)chatReadImageWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
    消息聊天中的已读控件是否是使用 image 的形式，否则则使用文字的形式
 * */
- (BOOL)chatReadControlUseImageControlView;


/**
 * 聊天 Cell 中的背景颜色
 * */
- (UIColor *)chatMessageCellBackgroundColor;

/**
 * 聊天中时间标签的字体
 * */
- (UIFont *)chatTimestampLabelFont;

/**
 * 聊天中时间标签的字体颜色
 * */
- (UIColor *)chatTimestampLabelTextColor;

/**
 * 聊天中时间标签的背景色
 * */
- (UIColor *)chatTimestampLabelBackgroundColor;

/**
 * 消息发送失败的 icon 名称
 * */
- (NSString *)chatSendFailImageName;

@end
