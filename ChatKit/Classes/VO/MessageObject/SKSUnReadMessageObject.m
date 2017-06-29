//
//  SKSUnReadMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2017/2/17.
//
//

#import "SKSUnReadMessageObject.h"

@implementation SKSUnReadMessageObject

- (NSString *)content {
    return [NSString stringWithFormat:@"%ld条未读消息", (long)self.unReadCount];
}

@end
