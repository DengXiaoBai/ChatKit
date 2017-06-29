//
//  SKSChatDateOfferContentView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import "SKSChatDateOfferContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSDateOfferView.h"

@interface SKSChatDateOfferContentView()<DateOfferViewDelegate>

@property (nonatomic, strong) SKSDateOfferView *dateOfferContentView;

@end

@implementation SKSChatDateOfferContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_dateOfferContentView) {
        _dateOfferContentView = [[SKSDateOfferView alloc] initWithMessageModel:self.messageModel];
        _dateOfferContentView.delegate = self;
        [self addSubview:_dateOfferContentView];
    }
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
    [_dateOfferContentView updateUIWithMessageModel:self.messageModel force:force];
    _dateOfferContentView.frame = CGRectMake(contentInsets.left, contentInsets.top, contentSize.width, contentSize.height);
}


#pragma mark -
- (void)selectDatingViewBtnActionAtIndex:(NSInteger)atIndex {
    if ([self.delegate respondsToSelector:@selector(chatBaseContentViewBtnActionAtIndex:)]) {
        [self.delegate chatBaseContentViewBtnActionAtIndex:atIndex];
    }
}

@end
