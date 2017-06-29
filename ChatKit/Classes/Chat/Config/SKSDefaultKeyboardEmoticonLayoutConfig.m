//
//  SKSDefaultKeyboardEmoticonLayoutConfig.m
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//

#import "SKSDefaultKeyboardEmoticonLayoutConfig.h"

@implementation SKSDefaultKeyboardEmoticonLayoutConfig

- (instancetype)initForEmoji {
    self = [super init];
    if (self) {
        self.emoticonInsets = UIEdgeInsetsMake(10, 25, 15, 25);
        self.rows = 3;
        self.colums = 8;
        self.itemCountInOnePage = self.rows * self.colums - 1;//有一个空位留给删除按钮
        self.btnSize = CGSizeMake(40, 40);
        self.isEmoji = YES;
        self.emojiFont = [UIFont systemFontOfSize:28];
    }
    return self;
}

- (instancetype)initForEmoticon {
    self = [super init];
    if (self) {
        self.emoticonInsets = UIEdgeInsetsZero;
        self.rows = 3;
        self.colums = 4;
        self.itemCountInOnePage = self.rows * self.colums;
        self.btnSize = CGSizeMake(55, 55);
        self.isEmoji = NO;
    }
    return self;
}

@end
