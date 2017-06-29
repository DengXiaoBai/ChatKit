//
//  SKSKeyboardItemVO.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSKeyboardMoreItemVO.h"

@implementation SKSKeyboardMoreItemVO

- (instancetype)initWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title keyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType {
    self = [super init];
    if (self) {
        self.normalImageName = normalImageName;
        self.highlightImageName = highlightImageName;
        self.title = title;
        self.keyboardMoreType = keyboardMoreType;
    }

    return self;
}

+ (instancetype)voWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title keyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType {
    return [[self alloc] initWithNormalImageName:normalImageName highlightImageName:highlightImageName title:title keyboardMoreType:keyboardMoreType];
}

#pragma mark - getter/setter
- (SKSKeyboardMoreType)getKeyboardMoreType {
    return _keyboardMoreType;
}

@end
