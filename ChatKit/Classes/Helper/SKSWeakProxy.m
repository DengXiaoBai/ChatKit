//
//  SKSWeakProxy.m
//  ChatKit
//
//  Created by iCrany on 2017/4/13.
//
//

#import "SKSWeakProxy.h"

@implementation SKSWeakProxy


- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}


/**
 *
 * @param aSelector a selector instance
 * @discussion
 * If an object implements (or inherits) this method, and returns a non-nil (and non-self) result, that returned object is used as the new receiver object and the message dispatch resumes to that new object. (Obviously if you return self from this method, the code would just fall into an infinite loop.)
 * If you implement this method in a non-root class, if your class has nothing to return for the given selector then you should return the result of invoking super’s implementation.
 * This method gives an object a chance to redirect an unknown message sent to it before the much more expensive forwardInvocation: machinery takes over. This is useful when you simply want to redirect messages to another object and can be an order of magnitude faster than regular forwarding. It is not useful where the goal of the forwarding is to capture the NSInvocation, or manipulate the arguments or return value during the forwarding.
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

/**
 * NO if the receiver really descends from NSObject, otherwise YES.
 * @return YES or NO
 * @discussion
 * This method is necessary because sending isKindOfClass: or isMemberOfClass: to an NSProxy object will test the object the proxy stands in for, not the proxy itself.
 * Use this method to test if the receiver is a proxy (or a member of some other root class).
 */
- (BOOL)isProxy {
    return YES;
}

@end
