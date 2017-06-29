//
//  SKSBaseContentConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/15.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSBaseContentConfig.h"

@implementation SKSBaseContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    return CGSizeZero;
}


- (NSString *)cellContentClass {
    return @"";
}


- (NSString *)cellContentIdentifier {
    return @"";
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsZero;
}


- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {

}

@end
