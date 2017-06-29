//
//  SKSUnReadMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2017/2/17.
//
//



#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSUnReadMessageObject : NSObject <SKSChatMessageObject>

@property (nullable, nonatomic, weak) SKSChatMessage *message;

@property (nonatomic, assign) int32_t unReadCount;//未读消息的数量
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
