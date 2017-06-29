//
//  SKSDateOfferMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



#import "SKSDateActivityMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSDateOfferMessageObject : SKSDateActivityMessageObject

@property (nonatomic, strong) NSString *topDesc;

@property (nonatomic, strong) NSString *bottomDesc;

@property (nonatomic, strong) NSString *acceptBtnTitle;

@property (nonatomic, strong) NSString *rejectBtnTitle;

@property (nonatomic, strong) NSString *iconImageName;

@end

NS_ASSUME_NONNULL_END
