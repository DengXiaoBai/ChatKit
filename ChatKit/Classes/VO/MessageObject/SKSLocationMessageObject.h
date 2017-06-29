//
//  SKSLocationMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "SKSChatMessageObject.h"
@class SKSChatMessage;

NS_ASSUME_NONNULL_BEGIN

@interface SKSLocationMessageObject : NSObject <SKSChatMessageObject>


/**
 当前本地缓存地理位置的地图截图地址
 */
@property(nonatomic, strong) NSString *locationImageUrl;


/**
 地理位置的标题
 */
@property(nonatomic, strong) NSString *locationTitle;


/**
 地理位置的详细地址
 */
@property(nonatomic, strong) NSString *locationDesc;


/**
 地址位置的经纬度
 */
@property(nonatomic, assign) CLLocationCoordinate2D coordinate2D;

/**
 * 尝试截图的次数
 * */
@property(nonatomic, assign) NSInteger retrySnapshotImageTime;


/**
   地图图片表针的图标名称
 * */
@property(nonatomic, strong) NSString *pinImageName;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property(nonatomic, nullable, weak) SKSChatMessage *message;


/**
 地理位置对象构造方法

 @param locationImageUrl 当前本地缓存地理位置的地图截图地址
 @param locationTitle 地理位置的标题
 @param locationDesc 地理位置的详细地址
 @param coordinate2D 地址位置的经纬度
 @return 地理位置对象实例
 */
- (instancetype)initWithLocationImageUrl:(NSString *)locationImageUrl
                          locationTitile:(NSString *)locationTitle
                            locationDesc:(NSString *)locationDesc
                            coordinate2D:(CLLocationCoordinate2D)coordinate2D;

@end

NS_ASSUME_NONNULL_END
