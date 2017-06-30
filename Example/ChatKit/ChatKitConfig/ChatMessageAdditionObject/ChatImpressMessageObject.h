//
//  ChatImpressMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import <ChatKit/SKSChatMessageObject.h>
#import <ChatKit/SKSChatMessageConstant.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatImpressMessageObject : NSObject <SKSChatMessageObject>

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, assign) SKSChatGender gender;

@property (nonatomic, assign) SKSImpressStatus impressStatus;

@property(nonatomic, nullable, weak) SKSChatMessage *message;

@property (nonatomic, strong) NSString *topDesc;

@property (nonatomic, strong) NSString *bottomDesc;

@property (nonatomic, strong) NSString *goToImpressBtnTitle;

- (instancetype)initWithUserId:(NSString *)userId
                      nickname:(NSString *)nickname
                        gender:(SKSChatGender)gender
                 impressStatus:(SKSImpressStatus)impressStatus
                       message:(SKSChatMessage *)message;

@end

NS_ASSUME_NONNULL_END
