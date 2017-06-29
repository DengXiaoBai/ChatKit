//
// Created by iCrany on 2016/11/12.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageConstant.h"

@protocol SKSKeyboardMoreViewItemProtocol <NSObject>

@property (nonatomic, strong) NSString *normalImageName;

@property (nonatomic, strong) NSString *highlightImageName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) SKSKeyboardMoreType keyboardMoreType;

@end
