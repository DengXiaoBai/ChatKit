//
//  SKSLocationMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSLocationMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSLocationMessageObject

- (instancetype)initWithLocationImageUrl:(NSString *)locationImageUrl
                          locationTitile:(NSString *)locationTitle
                            locationDesc:(NSString *)locationDesc
                            coordinate2D:(CLLocationCoordinate2D)coordinate2D {
    self = [super init];
    if (self) {
        self.locationImageUrl = locationImageUrl;
        self.locationTitle = locationTitle;
        self.locationDesc = locationDesc;
        self.coordinate2D = coordinate2D;
        self.retrySnapshotImageTime = 0;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeLocation;
}

@end
