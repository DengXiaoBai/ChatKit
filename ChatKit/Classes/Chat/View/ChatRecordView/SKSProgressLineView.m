//
//  SKSProgressLineView.m
//  ChatKit
//
//  Created by iCrany on 2017/1/3.
//
//

#import "SKSProgressLineView.h"
#import "SKSChatMessageConstant.h"

@implementation SKSProgressLineView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kProgressLineDefaultColor;
}

- (void)updateUIIsHighlight:(BOOL)isHighlight {
    if (isHighlight) {
        self.backgroundColor = kProgressLineHihgtlightColor;
    } else {
        self.backgroundColor = kProgressLineDefaultColor;
    }
}

@end
