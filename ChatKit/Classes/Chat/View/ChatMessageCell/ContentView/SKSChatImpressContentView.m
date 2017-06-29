//
//  SKSChatImpressContentView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import "SKSChatImpressContentView.h"
#import "SKSChatImpressView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSImageView.h"

@interface SKSChatImpressContentView() <SKSChatImpressViewDelegate>

@property (nonatomic, strong) SKSChatImpressView *impressView;

@end

@implementation SKSChatImpressContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_impressView) {
        _impressView = [[SKSChatImpressView alloc] initWithMessageModel:self.messageModel];
        _impressView.delegate = self;
        [self addSubview:_impressView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId != messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;

    [self.impressView updateUIWithMessageModel:self.messageModel force:force];

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    self.impressView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

#pragma mark - SKSChatImpressViewDelegate
- (void)chatImpressViewDidTapBtnIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(chatBaseContentViewBtnActionAtIndex:)]) {
        [self.delegate chatBaseContentViewBtnActionAtIndex:buttonIndex];
    }
}

@end
