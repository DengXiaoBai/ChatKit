//
//  SKSEmoticonMeta.m
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//

#import "SKSEmoticonMeta.h"

@implementation SKSEmoticonMeta

- (instancetype)initWithEmoticonId:(NSString *)emoticonId
                         catalogId:(NSString *)catalogId
                              name:(NSString *)name
                           name_zh:(NSString *)name_zh
                              type:(NSString *)type {
    self = [super init];
    if (self) {
        self.emoticonId = emoticonId;
        self.catalogId = catalogId;
        self.name = name;
        self.name_zh = name_zh;
        self.type = type;
    }

    return self;
}

@end
