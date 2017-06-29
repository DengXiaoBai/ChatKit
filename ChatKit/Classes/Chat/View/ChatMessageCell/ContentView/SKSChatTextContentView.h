//
//  SKSChatTextContentView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//


#import "SKSChatBaseContentView.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

/**
 聊天中的纯文本界面
 */
@interface SKSChatTextContentView : SKSChatBaseContentView


@property (nonatomic, strong, readonly) TTTAttributedLabel *displayTextLabel;

@end
