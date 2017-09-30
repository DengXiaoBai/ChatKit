//
//  SKSChatMessageModel.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageModel.h"
#import "SKSChatCellLayoutConfig.h"
#import "SKSDefaultValueMaker.h"
#import "SKSChatSessionConfig.h"

@implementation SKSChatMessageModel

- (instancetype)initWithMessage:(SKSChatMessage *)message {
    self = [super init];
    if (self) {
        self.message = message;
        [self updateLayoutConfig];
    }
    return self;
}


- (void)calculateContent:(CGFloat)width force:(BOOL)force {
    if (CGSizeEqualToSize(self.contentViewSize, CGSizeZero) || force) {
        
        [self updateLayoutConfig];
        
        _contentViewSize = [self.layoutConfig getContentSizeWithMessageModel:self cellWidth:width];
        
    }
}

- (UIImage *)defaultAvatarImage {
    return [self.sessionConfig defaultAvatar];
}

#pragma mark - Private method
- (void)updateLayoutConfig {
    //update avatarViewInsets
    [self avatarViewInsets];
    
    //update timeViewInsets
    [self timelabelViewInsets];
}

#pragma mark - getter/setter

- (CGSize)contentViewSize {
    if (CGSizeEqualToSize(_contentViewSize, CGSizeZero)) {
        CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
        if ([self.layoutConfig respondsToSelector:@selector(getContentSizeWithMessageModel:cellWidth:)]) {
            _contentViewSize = [self.layoutConfig getContentSizeWithMessageModel:self cellWidth:screen_width];
            
        } else {
            _contentViewSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] getContentSizeWithMessageModel:self cellWidth:screen_width];
        }
    }
    
    return _contentViewSize;
}

- (UIEdgeInsets)contentViewInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_contentViewInsets, UIEdgeInsetsZero)) {
        if ([self.layoutConfig respondsToSelector:@selector(getContentViewInsetsWithMessageModel:)]) {
            _contentViewInsets = [self.layoutConfig getContentViewInsetsWithMessageModel:self];
        } else {
            _contentViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] getContentViewInsetsWithMessageModel:self];
        }
    }
    return _contentViewInsets;
}

- (UIEdgeInsets)bubbleViewInsets {
    //每次都得重新计算，因为存在是否要显示时间标签的情况
    if ([self.layoutConfig respondsToSelector:@selector(getBubbleViewInsetsWithMessageModel:)]) {
        _bubbleViewInsets = [self.layoutConfig getBubbleViewInsetsWithMessageModel:self];
    } else {
        _bubbleViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] getBubbleViewInsetsWithMessageModel:self];
    }
    return _bubbleViewInsets;
}

- (UIEdgeInsets)avatarViewInsets {
    if (_shouldShowAvatar) {
        if ([self.layoutConfig respondsToSelector:@selector(avatarViewInsets:)]) {
            _avatarViewInsets = [self.layoutConfig avatarViewInsets:self];
        } else {
            _avatarViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] avatarViewInsets:self];
        }
    } else {
        if ([self.layoutConfig respondsToSelector:@selector(notShowAvatarViewInsets:)]) {
            _avatarViewInsets = [self.layoutConfig notShowAvatarViewInsets:self];
        } else {
            _avatarViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] notShowAvatarViewInsets:self];
        }
    }
    return _avatarViewInsets;
}

- (CGSize)avatarViewSize {
    if (_shouldShowAvatar) {
        if (CGSizeEqualToSize(_avatarViewSize, CGSizeZero)) {
            if ([self.layoutConfig respondsToSelector:@selector(avatarViewSize:)]) {
                _avatarViewSize = [self.layoutConfig avatarViewSize:self];
            } else {
                _avatarViewSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] avatarViewSize:self];
            }
        }
    } else {
        _avatarViewSize = CGSizeZero;
    }
    
    return _avatarViewSize;
}

- (UIEdgeInsets)timelabelViewInsets {
    if (_shouldShowTimestamp) {
        if (UIEdgeInsetsEqualToEdgeInsets(_timelabelViewInsets, UIEdgeInsetsZero)) {
            if ([self.layoutConfig respondsToSelector:@selector(timestampViewInsets:)]) {
                _timelabelViewInsets = [self.layoutConfig timestampViewInsets:self];
            } else {
                _timelabelViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] timestampViewInsets:self];
            }
        }
    } else {
        _timelabelViewInsets = UIEdgeInsetsZero;
    }
    return _timelabelViewInsets;
}

- (CGSize)timelabelSize {
    if (_shouldShowTimestamp) {
        if (CGSizeEqualToSize(_timelabelSize, CGSizeZero)) {
            if ([self.layoutConfig respondsToSelector:@selector(timestampViewSize:)]) {
                _timelabelSize = [self.layoutConfig timestampViewSize:self];
            } else {
                _timelabelSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig]  timestampViewSize:self];
            }
        }
    } else {
        _timelabelSize = CGSizeZero;
    }
    return _timelabelSize;
}

- (UIEdgeInsets)noTimestampBubbleViewInsets {
    if ([self.layoutConfig respondsToSelector:@selector(getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:)]) {
        _noTimestampBubbleViewInsets = [self.layoutConfig getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:self];
    } else {
        _noTimestampBubbleViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:self];
    }
    return _noTimestampBubbleViewInsets;
}

- (UIEdgeInsets)readLabelViewInsets {
    if ([self.layoutConfig respondsToSelector:@selector(readLabelViewInsets:)]) {
        _readLabelViewInsets = [self.layoutConfig readLabelViewInsets:self];
    } else {
        _readLabelViewInsets = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig] readLabelViewInsets:self];
    }
    
    return _readLabelViewInsets;
}

@end
