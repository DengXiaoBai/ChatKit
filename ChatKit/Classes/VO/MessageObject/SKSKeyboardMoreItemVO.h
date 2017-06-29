//
//  SKSKeyboardItemVO.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSKeyboardMoreViewItemProtocol.h"

@interface SKSKeyboardMoreItemVO : NSObject <SKSKeyboardMoreViewItemProtocol>

@property (nonatomic, strong) NSString *normalImageName;

@property (nonatomic, strong) NSString *highlightImageName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) SKSKeyboardMoreType keyboardMoreType;

- (instancetype)initWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title keyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType;

+ (instancetype)voWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title keyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType;

- (SKSKeyboardMoreType)getKeyboardMoreType;

@end
