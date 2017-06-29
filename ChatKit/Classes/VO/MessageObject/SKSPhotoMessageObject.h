//
//  SKSPhotoMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSPhotoMessageObject : NSObject <SKSChatMessageObject>


/**
 图片的本地缓存 url 地址, 也可对应为服务器端 url 地址
 */
@property(nonatomic, nullable, strong) NSString *photoUrl;



/**
 缩略图实例对象
 */
@property(nonatomic, strong) UIImage *thumbnailPhoto;

@property (nonatomic, assign) CGSize imageSize;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property(nonatomic, nullable, weak) SKSChatMessage *message;


/**
 图片实例构造方法

 @param photoUrl 图片本地缓存url地址，也可对应为服务器端 url 地址
 @param thumbnailPhoto 缩略图实例对象
 @return 图片实例对象
 */
- (instancetype)initWithPhotoUrl:(NSString *)photoUrl thumbnailPhoto:(UIImage *)thumbnailPhoto __deprecated;

/**
 图片实例构造方法

 @param photoUrl 图片本地缓存url地址，也可对应为服务器端 url 地址
 @param imageSize 图像的大小
 @return 图片实例对象
 */
- (instancetype)initWithPhotoUrl:(NSString *)photoUrl imageSize:(CGSize)imageSize;

@end

NS_ASSUME_NONNULL_END
