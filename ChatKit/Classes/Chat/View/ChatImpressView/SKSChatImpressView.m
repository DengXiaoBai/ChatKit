//
//  SKSChatImpressView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import "SKSChatImpressView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatImpressTopView.h"
#import "SKSChatImpressBottomView.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSImpressContentConfig.h"

@interface SKSChatImpressView() <SKSChatImpressBottomViewDelegate>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSImpressContentConfig *contentConfig;

@property (nonatomic, strong) SKSChatImpressTopView *topView;
@property (nonatomic, strong) SKSChatImpressBottomView *bottomView;

@end

@implementation SKSChatImpressView

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
        _topView = [[SKSChatImpressTopView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_topView];
    }

    if (!_bottomView) {
        _bottomView = [[SKSChatImpressBottomView alloc] initWithMessageModel:self.messageModel];
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
    CGSize topViewSize = [SKSChatImpressTopView getViewSizeWithMessageModel:self.messageModel];

    UIEdgeInsets bottomViewInsets = self.contentConfig.bottomDescInsets;
    CGSize bottomViewSize = [SKSChatImpressBottomView getViewSizeWithMessageModel:self.messageModel];

    _topView.frame = CGRectMake(topViewInsets.left, topViewInsets.top, topViewSize.width, topViewSize.height);
    _bottomView.frame = CGRectMake(bottomViewInsets.left, topViewInsets.top + topViewSize.height + topViewInsets.bottom + bottomViewInsets.top, bottomViewSize.width, bottomViewSize.height);
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    SKSImpressContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];

    UIEdgeInsets topViewInsets = contentConfig.topDescInsets;
    CGSize topSize = [SKSChatImpressTopView getViewSizeWithMessageModel:messageModel];

    UIEdgeInsets bottomViewInsets = contentConfig.bottomDescInsets;
    CGSize bottomSize = [SKSChatImpressBottomView getViewSizeWithMessageModel:messageModel];

    return CGSizeMake(topViewInsets.left + contentConfig.cellWidth + topViewInsets.right, topViewInsets.top + topSize.height + topViewInsets.bottom + bottomViewInsets.top + bottomSize.height + bottomViewInsets.bottom);
}

#pragma mark - SKSChatImpressBottomViewDelegate
- (void)impressBottomViewDidTapBtnIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(chatImpressViewDidTapBtnIndex:)]) {
        [self.delegate chatImpressViewDidTapBtnIndex:buttonIndex];
    }
}

@end
