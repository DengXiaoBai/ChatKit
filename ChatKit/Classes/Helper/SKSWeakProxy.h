//
//  SKSWeakProxy.h
//  ChatKit
//
//  Created by iCrany on 2017/4/13.
//
//



@interface SKSWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

@end
