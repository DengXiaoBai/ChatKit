//
//  ChatImpressView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatImpressView.h"
#import "ChatImpressTopView.h"
#import "ChatImpressBottomView.h"
#import "ChatImpressContentConfig.h"

@interface ChatImpressView() <ChatImpressBottomViewDelegate>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatImpressContentConfig *contentConfig;

@property (nonatomic, strong) ChatImpressTopView *topView;
@property (nonatomic, strong) ChatImpressBottomView *bottomView;

@end

@implementation ChatImpressView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_topView) {
        _topView = [[ChatImpressTopView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_topView];
    }

    if (!_bottomView) {
        _bottomView = [[ChatImpressBottomView alloc] initWithMessageModel:self.messageModel];
        _bottomView.delegate = self;
        [self addSubview:_bottomView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId != messageModel.message.messageId && messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    [self.topView updateUIWithMessageModel:self.messageModel force:force];
    [self.bottomView updateUIWithMessageModel:self.messageModel force:force];

    UIEdgeInsets topViewInsets = self.contentConfig.topDescInsets;
    CGSize topViewSize = [ChatImpressTopView getViewSizeWithMessageModel:self.messageModel];

    UIEdgeInsets bottomViewInsets = self.contentConfig.bottomDescInsets;
    CGSize bottomViewSize = [ChatImpressBottomView getViewSizeWithMessageModel:self.messageModel];

    _topView.frame = CGRectMake(topViewInsets.left, topViewInsets.top, topViewSize.width, topViewSize.height);
    _bottomView.frame = CGRectMake(bottomViewInsets.left, topViewInsets.top + topViewSize.height + topViewInsets.bottom + bottomViewInsets.top, bottomViewSize.width, bottomViewSize.height);
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    ChatImpressContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];

    UIEdgeInsets topViewInsets = contentConfig.topDescInsets;
    CGSize topSize = [ChatImpressTopView getViewSizeWithMessageModel:messageModel];

    UIEdgeInsets bottomViewInsets = contentConfig.bottomDescInsets;
    CGSize bottomSize = [ChatImpressBottomView getViewSizeWithMessageModel:messageModel];

    return CGSizeMake(topViewInsets.left + contentConfig.cellWidth + topViewInsets.right, topViewInsets.top + topSize.height + topViewInsets.bottom + bottomViewInsets.top + bottomSize.height + bottomViewInsets.bottom);
}

#pragma mark - SKSChatImpressBottomViewDelegate
- (void)impressBottomViewDidTapBtnIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(chatImpressViewDidTapBtnIndex:)]) {
        [self.delegate chatImpressViewDidTapBtnIndex:buttonIndex];
    }
}

@end
