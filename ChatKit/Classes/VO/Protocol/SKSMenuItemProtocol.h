//
// Created by iCrany on 2016/12/21.
//

#import <Foundation/Foundation.h>

@protocol SKSMenuItemProtocol <NSObject>

@property(nonatomic, strong) NSString *menuItemName;

@property(nonatomic, assign) SEL selector;

- (instancetype)initWithMenuItemName:(NSString *)menuItemName aSelector:(SEL)aSelector;

@end