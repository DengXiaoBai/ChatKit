//
//  SKSDefaultCellMaker.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSMessageCell;
@class SKSChatMessageModel;

/**
 * 构建聊天中 UITableViewCell 的工具类，主要负责生成 UITableViewCell，以及填充 LayoutConfig 对象实例
 */
@interface SKSDefaultCellMaker : NSObject

+ (SKSMessageCell *)getCellWithTableView:(UITableView *)tableView targetMessageModel:(SKSChatMessageModel *)messageModel;

@end
