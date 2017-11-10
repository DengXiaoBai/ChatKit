//
//  ChatAdminNormalCoreTextMessageObject.h
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//

 #import "SKSCoreTextMessageObject.h"

@interface ChatAdminNormalCoreTextMessageObject : SKSCoreTextMessageObject
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *title;
- (NSString *)iconImageName;
- (instancetype)initWithHtmlText:(NSString *)htmlText title:(NSString*)title activityId:(NSString*)aid;


@end
