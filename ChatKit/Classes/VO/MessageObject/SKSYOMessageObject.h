//
//  SKSYOMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSYOMessageObject : NSObject<SKSChatMessageObject>

/**
 Yo文本内容
 */
@property (nonatomic, nullable, strong) NSString *text;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;


/**
 YO 的字体
 */
@property (nonatomic, strong) UIFont *yoFont;


/**
 YO 的颜色
 */
@property (nonatomic, strong) UIColor *yoColor;


/**
 Yo文本实例构造方法
 
 @param text 纯文本
 @return 纯文本实例
 */
- (instancetype)initWithText:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
