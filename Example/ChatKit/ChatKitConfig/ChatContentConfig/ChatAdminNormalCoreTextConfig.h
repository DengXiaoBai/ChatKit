//
//  ChatAdminNormalCoreTextConfig.h
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//

#import <ChatKit/SKSBaseContentConfig.h>

@interface ChatAdminNormalCoreTextConfig : SKSBaseContentConfig

@property (nonatomic, assign, readonly) CGFloat cellWidth;

@property (nonatomic, strong,readonly) UIFont *titleFont;
@property (nonatomic, strong,readonly) UIColor *titleColor;
@property (nonatomic, assign,readonly) UIEdgeInsets titleInsets;

@property (nonatomic, strong, readonly) UIColor *lineColor;
@property (nonatomic, assign, readonly) UIEdgeInsets lineInsets;

@property (nonatomic, assign, readonly) UIEdgeInsets coreTextViewInsets;

@property (nonatomic, strong,readonly) UIColor *backgroundColor;

@property (nonatomic, assign,readonly) UIEdgeInsets iconImageInsets;

@end
