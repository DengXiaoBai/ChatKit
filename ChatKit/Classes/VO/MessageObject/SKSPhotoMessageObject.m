//
//  SKSPhotoMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSPhotoMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSPhotoMessageObject

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl thumbnailPhoto:(UIImage *)thumbnailPhoto {
    self = [super init];
    if (self) {
        self.photoUrl = photoUrl;
        self.thumbnailPhoto = thumbnailPhoto;
        self.imageSize = thumbnailPhoto.size;
    }
    return self;
}

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl imageSize:(CGSize)imageSize {
    self = [super init];
    if (self) {
        self.photoUrl = photoUrl;
        self.imageSize = imageSize;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypePhoto;
}


@end
