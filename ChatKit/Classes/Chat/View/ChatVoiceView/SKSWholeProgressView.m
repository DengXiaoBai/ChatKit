//
//  SKSWholeProgressView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSWholeProgressView.h"
#import "UIColor+SKS.h"
#import "SKSChatMessageConstant.h"

@implementation SKSWholeProgressView

- (void)setIsSender:(BOOL)isSender {
    if (isSender) {
        self.backgroundColor = RGB(255, 255, 255);
    } else {
        self.backgroundColor = RGB(229, 229, 229);
    }
}

@end
