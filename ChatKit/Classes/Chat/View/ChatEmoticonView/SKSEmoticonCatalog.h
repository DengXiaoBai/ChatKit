//
//  SKSEmoticonCatalog.h
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//


@protocol SKSKeyboardEmoticonLayoutConfig;
@class SKSEmoticonMeta;

/**
 * 具体一套表情的目录，包括 layoutConfig 布局，该套表情目录下的所有表情资源等等
 * */
@interface SKSEmoticonCatalog : NSObject

@property (nonatomic, strong) id<SKSKeyboardEmoticonLayoutConfig> emoticonLayoutConfig;

@property (nonatomic, strong) NSString *catalogId;//对应于原来的 packageId

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *desc_zh;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *name_zh;

@property (nonatomic, strong) NSString *previewImage;//该套表情的预览图

@property (nonatomic, strong) NSArray<SKSEmoticonMeta *>* emoticonList;

- (CGSize)size;

@end
