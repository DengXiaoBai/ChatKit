//
//  SKSImpressMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import "SKSImpressMessageObject.h"

@implementation SKSImpressMessageObject

- (instancetype)initWithUserId:(NSString *)userId
                      nickname:(NSString *)nickname
                        gender:(SKSChatGender)gender
                 impressStatus:(SKSImpressStatus)impressStatus
                       message:(SKSChatMessage *)message {
    self = [super init];
    if (self) {
        self.userId = userId;
        self.nickname = nickname;
        self.gender = gender;
        self.impressStatus = impressStatus;
        self.message = message;
    }
    return self;
}

- (NSString *)topDesc {
    NSString *heOrShe = self.gender == SKSChatGenderFemale? @"她" : @"他";
    return [NSString stringWithFormat:@"你已与%@见过面，说说你对%@的印象吧~",self.nickname, heOrShe];
}

- (NSString *)bottomDesc {
    switch (self.impressStatus) {
        case SKSImpressStatusInvalid: {
            return @"该评价已失效";
        }
        case SKSImpressStatusSuccess: {
            return @"评价成功";
        }
        default: {
            return @"";
        }
    }
}

- (NSString *)goToImpressBtnTitle {
    return @"去评价";
}

@end
