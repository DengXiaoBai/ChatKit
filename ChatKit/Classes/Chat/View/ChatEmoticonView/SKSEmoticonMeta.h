//
//  SKSEmoticonMeta.h
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//


#import "SKSChatMessageConstant.h"

@interface SKSEmoticonMeta : NSObject

/**
 * 该表情的 id
 */
@property (nonatomic, strong) NSString *emoticonId;

/**
 * 该表情对应的目录（表情包目录）的 id
 */
@property (nonatomic, strong) NSString *catalogId;

/**
 * 表情的英文名称
 */
@property (nonatomic, strong) NSString *name;

/**
 * 表情的中文名称
 */
@property (nonatomic, strong) NSString *name_zh;

/**
 * 占位，暂时无实际意义
 */
@property (nonatomic, strong) NSString *type;

/**
 * 判断是否是 emoji 表情，默认是 NO
 */
@property (nonatomic, assign) BOOL isEmoji;

- (instancetype)initWithEmoticonId:(NSString *)emoticonId
                         catalogId:(NSString *)catalogId
                              name:(NSString *)name
                           name_zh:(NSString *)name_zh
                              type:(NSString *)type;

@end
