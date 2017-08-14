//
//  ChatDateActivityMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSChatMessageObject.h>
#import "ChatConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatDateActivityMessageObject : NSObject <SKSChatMessageObject>

@property (nullable, nonatomic, weak) SKSChatMessage *message;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *coverUrl;

@property (nonatomic, assign) int64_t startTime;

@property (nonatomic, assign) int32_t duration;

@property (nonatomic, assign) BOOL isRequiredGift;

@property (nonatomic, assign) int32_t roses;

@property (nonatomic, assign) SKSDateOfferState dateOfferState;

@property (nonatomic, assign) SKSActivityState state;//约会状态


@end

NS_ASSUME_NONNULL_END
