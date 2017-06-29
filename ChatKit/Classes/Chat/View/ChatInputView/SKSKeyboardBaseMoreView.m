//
//  SKSKeyboardBaseMoreView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSKeyboardBaseMoreView.h"
#import "SKSKeyboardMoreViewItemProtocol.h"
#import "SKSKeyboardMoreItemButtonView.h"
#import "SKSDefaultValueMaker.h"
#import "SKSDefaultCellConfig.h"
#import "UIColor+SKS.h"
#import "SKSChatKeyboardConfig.h"

static const NSInteger kMoreItemNumberInOneRow = 4;//一行拥有的个数
static const NSInteger kMoreItemNumberInOneCol = 2;//一列拥有的个数

static const CGFloat kMoreItemDefaultWidth = 100;
static const CGFloat kMoreItemDefaultHeight = 120;

@interface SKSKeyboardBaseMoreView() <SKSKeyboardMoreItemButtonViewDelegate>

@end

@implementation SKSKeyboardBaseMoreView


- (instancetype)initWithItemList:(NSArray *)keyboardMoreItemList keyboarConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    self = [super init];
    if (self) {
        self.keyboardConfig = keyboardConfig;
        self.keyboardMoreItemList = keyboardMoreItemList;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.backgroundColor = _keyboardConfig.chatKeyboardMoreViewBackgroundColor;
    NSInteger itemCount = _keyboardMoreItemList.count;
    
    //TODO: 这里应该弄成 ScrollView
    if (itemCount > 0) {
        NSInteger i = 0;
        CGFloat gapX = ([UIScreen mainScreen].bounds.size.width - kMoreItemNumberInOneRow * kMoreItemDefaultWidth) / (kMoreItemNumberInOneRow + 1);
        CGFloat gapY = ([_keyboardConfig chatKeyboardMoreViewHeight] - kMoreItemNumberInOneCol * kMoreItemDefaultHeight) / (kMoreItemNumberInOneCol + 1);
        
        for (i = 0; i < _keyboardMoreItemList.count; i++) {
            id<SKSKeyboardMoreViewItemProtocol> itemModel = _keyboardMoreItemList[i];
            SKSKeyboardMoreItemButtonView *itemView = [[SKSKeyboardMoreItemButtonView alloc] initWithItemModel:itemModel frame:CGRectMake(0, 0, kMoreItemDefaultWidth, kMoreItemDefaultHeight)];
            itemView.delegate = self;
            [self addSubview:itemView];
            
            NSInteger row = i / kMoreItemNumberInOneRow;//第几行
            NSInteger col = i % kMoreItemNumberInOneRow;//第几列
            
            CGFloat x = col * (kMoreItemDefaultWidth + gapX) + gapX;
            CGFloat y = row * (kMoreItemDefaultHeight + gapY) + gapY;
            itemView.frame = CGRectMake(x, y, kMoreItemDefaultWidth, kMoreItemDefaultHeight);
        }
    }
}


- (void)updateKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {

}

#pragma mark - SKSKeyboardMoreItemButtonViewDelegate
- (void)SKSKeyboardMoreItemButtonViewDidTapWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>) itemModel {
    if ([self.actionDelegate respondsToSelector:@selector(SKSKeyboardMoreItemButtonViewDidTapWithItemModel:)]) {
        [self.actionDelegate SKSKeyboardMoreItemButtonViewDidTapWithItemModel:itemModel];
    }
}

@end
