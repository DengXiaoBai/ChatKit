//
//  SKSEmoticonMeta.h
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//


#import "SKSChatMessageConstant.h"

@interface SKSEmoticonMeta : NSObject

@property (nonatomic, strong) NSString *emoticonId;

@property (nonatomic, strong) NSString *catalogId;//该表情对应的目录Id

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *name_zh;

@property (nonatomic, strong) NSString *type;

//for ui
@property (nonatomic, assign) BOOL isEmoji;//default is NO

- (instancetype)initWithEmoticonId:(NSString *)emoticonId
                         catalogId:(NSString *)catalogId
                              name:(NSString *)name
                           name_zh:(NSString *)name_zh
                              type:(NSString *)type;

@end
