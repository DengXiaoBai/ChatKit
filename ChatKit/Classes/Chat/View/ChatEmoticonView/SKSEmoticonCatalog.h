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

/**
 * 某套表情包目录的 id, 对应于原来的 packageId
 */
@property (nonatomic, strong) NSString *catalogId;

/**
 * 该套表情包目录的英文描述
 */
@property (nonatomic, strong) NSString *desc;

/**
 * 该套表情包目录的中文描述
 */
@property (nonatomic, strong) NSString *desc_zh;

/**
 * 该套表情包目录的英文名称
 */
@property (nonatomic, strong) NSString *name;

/**
 * 该套表情包目录的中文名称
 */
@property (nonatomic, strong) NSString *name_zh;

/**
 * 该套表情包目录的预览图片，每一套表情包目录都有一个预览图片
 */
@property (nonatomic, strong) NSString *previewImage;

/**
 * 该套表情包目录下的所有表情
 */
@property (nonatomic, strong) NSArray<SKSEmoticonMeta *>* emoticonList;

- (CGSize)size;

@end
