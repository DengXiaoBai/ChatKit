//
//  SKSMenuItemBaseObject.m
//  ChatKit
//
//  Created by iCrany on 2016/12/21.
//
//

#import "SKSMenuItemBaseObject.h"

@implementation SKSMenuItemBaseObject

- (instancetype)initWithMenuItemName:(NSString *)menuItemName aSelector:(SEL)aSelector {
    self = [super init];
    if (self) {
        self.menuItemName = menuItemName;
        self.selector = aSelector;
    }

    return self;
}

@end
