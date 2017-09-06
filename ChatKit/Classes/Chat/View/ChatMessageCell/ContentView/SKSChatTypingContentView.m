//
//  SKSChatTypingContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSChatTypingContentView.h"
#import "SKSChatMessage.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessageObject.h"
#import "SKSTypingMessageObject.h"
#import "UIColor+SKS.h"
#import "UIImage+SKS.h"

@interface SKSChatTypingContentView()

@property (nonatomic, strong) UIImageView *typingImageView;
@property (nonatomic, strong) SKSTypingMessageObject *typingAdditionalMessage;

@end

@implementation SKSChatTypingContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSTypingMessageObject class]]) {
        NSAssert(NO, @"messageAdditionalObject is not kind of SKSTypingMessageObject");
        return;
    }
    
    _typingAdditionalMessage = self.messageModel.message.messageAdditionalObject;
    
    if (_typingAdditionalMessage.animationImageNameList.count != 3) {
        NSAssert(NO, @"typing animationImageNameList.count != 3");
        return;
    }
    
    if (!_typingImageView) {
        NSString *imageDot1 = _typingAdditionalMessage.animationImageNameList[0];
        NSString *imageDot2 = _typingAdditionalMessage.animationImageNameList[1];
        NSString *imageDot3 = _typingAdditionalMessage.animationImageNameList[2];
        
        _typingImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:imageDot1] imageByApplyingAlpha:0.2]];
        _typingImageView.contentMode = UIViewContentModeScaleAspectFill;
        _typingImageView.clipsToBounds = YES;
        UIImage *image1 = [[UIImage imageNamed:imageDot1] imageByApplyingAlpha:0.2];
        UIImage *image2 = [[UIImage imageNamed:imageDot2] imageByApplyingAlpha:0.2];
        UIImage *image3 = [[UIImage imageNamed:imageDot3] imageByApplyingAlpha:0.2];
        
        if (image1 != nil && image2 != nil && image3 != nil) {
            [_typingImageView setAnimationImages:@[image1, image2, image3]];
        }
        
        [_typingImageView setAnimationDuration:1.5f];
        [self addSubview:_typingImageView];
    }
    
    [_typingImageView startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;

    CGSize contentSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentInsets = self.messageModel.contentViewInsets;

    [_typingImageView startAnimating];
    _typingImageView.frame = CGRectMake(contentInsets.left, contentInsets.top, contentSize.width, contentSize.height);
}


@end
