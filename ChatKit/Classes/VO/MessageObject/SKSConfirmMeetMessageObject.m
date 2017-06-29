//
//  SKSConfirmMeetMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2017/2/8.
//
//

#import "SKSConfirmMeetMessageObject.h"

@implementation SKSConfirmMeetMessageObject

- (NSString *)topDesc {
    return [NSString stringWithFormat:@"是否已与%@完成线下见面?", self.nickname];
}

- (NSString *)acceptBtnTitle {
    return @"是";
}

- (NSString *)rejectBtnTitle {
    return @"否";
}

- (NSString *)bottomDesc {
    return @"已经完成线下见面";
}

@end
