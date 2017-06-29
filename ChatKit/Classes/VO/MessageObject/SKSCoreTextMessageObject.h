//
//  SKSAdministratorAuditCoreTextMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSCoreTextMessageObject : NSObject <SKSChatMessageObject>

/**
 * 消息内容, html 格式
 */
@property (nonatomic, strong) NSString *htmlText;

/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;

/**
 * 消息长按后显示的惨淡选项
 * */
@property (nonatomic, nullable, strong) NSArray<SKSMenuItemProtocol> *menuItemList;


- (instancetype)initWithHtmlText:(NSString *)htmlText;

@end

NS_ASSUME_NONNULL_END
