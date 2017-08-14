//
//  ChatPrivacyGiftOfferMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSChatMessageConstant.h>
#import <ChatKit/SKSChatMessageObject.h>
#import "ChatConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatPrivacyGiftOfferMessageObject : NSObject <SKSChatMessageObject>

@property (nullable, nonatomic, weak) SKSChatMessage *message;

@property (nonatomic, assign) int32_t roseCount;
@property (nonatomic, strong) NSString *leftBtnTitle;
@property (nonatomic, strong) NSString *rightBtnTitle;
@property (nonatomic, assign) SKSPrivacyGiftOfferState state;

@property (nonatomic, strong, readonly) NSString *titleContent;
@property (nonatomic, strong, readonly) NSString *bottomDescContent;

- (instancetype)initWithRoseCount:(int32_t)roseCount
                     leftBtnTitle:(NSString *)leftBtnTitle
                    rightBtnTitle:(NSString *)rightBtnTitle
                            state:(SKSPrivacyGiftOfferState)state;

NS_ASSUME_NONNULL_END

@end
