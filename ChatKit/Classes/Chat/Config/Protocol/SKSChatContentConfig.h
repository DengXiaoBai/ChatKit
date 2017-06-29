//
// Created by iCrany on 2016/11/9.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSChatMessageModel;


/**
 聊天Cell 中的 ContentView (气泡中的具体控件,例如UITextView, UIImageView 控件) 的界面配置类, 例如大小等
 */
@protocol SKSChatContentConfig <NSObject>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;

/**
 聊天Cell中具体内容的大小

 @param cellWidth 聊天Cell的宽度
 @return 聊天Cell中具体内容的大小
 */
- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth;


/**
 聊天Cell中具体内容类的 Class name

 @return 聊天Cell中具体内容类的 Class name
 */
- (NSString *)cellContentClass;


/**
 待定

 @return 待定
 */
- (NSString *)cellContentIdentifier;



/**
 聊天中具体内容于气泡之间的间距

 @return 聊天中具体内容于气泡之间的间距
 */
- (UIEdgeInsets)contentViewInsets;


/**
 聊天中气泡的边距（不考虑时间标签的影响）

 @return 气泡的边距
 */
- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation;


/**
 更新 MessageModel 实例, 以及对应的配置信息

 @param messageModel 消息 Model
 */
- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel;


@optional
/**
 时间标签的间距

 @return 时间标签的间距
 */
- (UIEdgeInsets)timestampViewInsets;


/**
 时间标签的大小

 @return 时间标签的大小
 */
- (CGSize)timestampViewSize;

@end
