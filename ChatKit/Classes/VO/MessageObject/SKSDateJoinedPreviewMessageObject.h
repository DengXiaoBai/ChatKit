//
//  SKSDateJoinedPreviewMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import "SKSDateActivityMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSDateJoinedPreviewMessageObject : SKSDateActivityMessageObject

@property (nonatomic, strong) NSString *bottomDesc;

@property (nonatomic, strong) NSString *roseDesc;

@property (nonatomic, strong) NSString *rosesIconImageName;

@property (nonatomic, assign) int64_t currentTimestamp;//当前时间戳

@end

NS_ASSUME_NONNULL_END
