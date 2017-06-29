//
//  SKSDateJoinedPreviewMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import "SKSDateJoinedPreviewMessageObject.h"

@implementation SKSDateJoinedPreviewMessageObject

- (NSString *)bottomDesc {
    return @"来自你参与的约会";
}

- (NSString *)roseDesc {
    return [NSString stringWithFormat:@"送%ld玫瑰", (long)self.roses];
}

- (NSString *)rosesIconImageName {
    return @"date-rose-icon";
}
@end
