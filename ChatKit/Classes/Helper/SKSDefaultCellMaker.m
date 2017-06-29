//
//  SKSDefaultCellMaker.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSDefaultCellMaker.h"
#import "SKSMessageCell.h"
#import "SKSChatMessageModel.h"
#import "SKSChatCellLayoutConfig.h"
#import "SKSDefaultValueMaker.h"

@implementation SKSDefaultCellMaker

+ (SKSMessageCell *)getCellWithTableView:(UITableView *)tableView targetMessageModel:(SKSChatMessageModel *)messageModel {
    id <SKSChatCellLayoutConfig> layoutConfig = messageModel.layoutConfig;
    
    if (!layoutConfig) {
        layoutConfig = [[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig];
        messageModel.layoutConfig = layoutConfig;
    }
    
    NSString *identifier = [layoutConfig getCellIdentifierWithMessageModel:messageModel];
//    NSString *contentViewClassName = [layoutConfig getCellContentViewClassNameWithMessageModel:messageModel];
    
    SKSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerClass:NSClassFromString(@"SKSMessageCell") forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    [cell updateUIWithMessageModel:messageModel];
    return cell;
}

@end
