//
//  SKSMenuItemBaseObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/21.
//
//



#import "SKSMenuItemProtocol.h"

@interface SKSMenuItemBaseObject : NSObject <SKSMenuItemProtocol>

@property(nonatomic, strong) NSString *menuItemName;

@property(nonatomic, assign) SEL selector;


@end
