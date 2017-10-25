//
//  ChatDateOfferContentView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatDateOfferContentView.h"
#import "ChatDateOfferView.h"

@interface ChatDateOfferContentView()<DateOfferViewDelegate>

@property (nonatomic, strong) ChatDateOfferView *dateOfferContentView;

@end

@implementation ChatDateOfferContentView

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
        _dateOfferContentView = [[ChatDateOfferView alloc] initWithMessageModel:self.messageModel];
        _dateOfferContentView.delegate = self;
        [self addSubview:_dateOfferContentView];
    }

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
