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
    NSAssert(NO, @"Please override this method in subClass");
    return CGSizeZero;
}


- (NSString *)cellContentClass {
    NSAssert(NO, @"Please override this method in subClass");
    return @"";
}


- (NSString *)cellContentIdentifier {
    NSAssert(NO, @"Please override this method in subClass");
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
