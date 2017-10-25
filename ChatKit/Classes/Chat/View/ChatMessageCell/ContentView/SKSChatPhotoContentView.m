//
//  SKSChatPhotoContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSChatPhotoContentView.h"
#import "SKSDrawBubbleView.h"
#import "SKSImageView.h"
#import "SKSPhotoMessageObject.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"

@interface SKSChatPhotoContentView()

@property (nonatomic, strong) SKSPhotoMessageObject *photoMessageObject;

@property (nonatomic, strong) SKSImageView *displayPhotoImageView;
@property (nonatomic, strong) SKSDrawBubbleView *drawBubbleView;

@end

@implementation SKSChatPhotoContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSPhotoMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of SKSPhotoMessageObject class");
    }

    self.photoMessageObject = self.messageModel.message.messageAdditionalObject;

    if (!_drawBubbleView) {
        _drawBubbleView = [[SKSDrawBubbleView alloc] init];
        [self addSubview:_drawBubbleView];
    }

    if (!_displayPhotoImageView) {
        _displayPhotoImageView = [[SKSImageView alloc] init];
        _displayPhotoImageView.userInteractionEnabled = YES;
        _displayPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _displayPhotoImageView.clipsToBounds = YES;
        _displayPhotoImageView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        _displayPhotoImageView.layer.borderWidth = 1;
        [self addSubview:_displayPhotoImageView];
    }

    _displayPhotoImageView.image = self.photoMessageObject.thumbnailPhoto;

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    if (messageModel.message.messageMediaType != SKSMessageMediaTypePhoto) {
        DLog(@"[Error] in SKSChatPhotoContentView but messageMediaType != SKSMessageMediaTypePhoto");
        return;
    }

    self.messageModel = messageModel;
    self.photoMessageObject = self.messageModel.message.messageAdditionalObject;

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    _displayPhotoImageView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
