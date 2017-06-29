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

@interface SKSDefaultCellMaker : NSObject

+ (SKSMessageCell *)getCellWithTableView:(UITableView *)tableView targetMessageModel:(SKSChatMessageModel *)messageModel;

@end
