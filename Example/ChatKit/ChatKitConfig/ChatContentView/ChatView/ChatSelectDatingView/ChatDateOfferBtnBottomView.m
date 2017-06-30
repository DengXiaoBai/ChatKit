//
//  ChatDateOfferBtnBottomView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatDateOfferBtnBottomView.h"
#import "ChatDateOfferMessageObject.h"
#import "ChatDateOfferContentConfig.h"
#import "ChatDateOfferTopView.h"

static const CGFloat kDefaultHeight = 40;

@interface ChatDateOfferBtnBottomView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatDateOfferMessageObject *messageObject;

@property (nonatomic, strong) UIButton *acceptBtn;
@property (nonatomic, strong) UIButton *rejectBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation ChatDateOfferBtnBottomView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        self.messageObject = self.messageModel.message.messageAdditionalObject;

        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_acceptBtn) {
        _acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_acceptBtn addTarget:self action:@selector(acceptBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_acceptBtn];
    }

    if(!_rejectBtn) {
        _rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rejectBtn addTarget:self action:@selector(rejectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rejectBtn];
    }

    if (!_line) {
        _line = [[UIView alloc] init];
        [self addSubview:_line];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }
    self.messageModel = messageModel;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    self.messageObject = self.messageModel.message.messageAdditionalObject;


    CGFloat contentWidth = [ChatDateOfferTopView getViewSizeWithMessageModel:self.messageModel].width;
    CGFloat centerX = contentWidth / 2;

    [_rejectBtn setTitle:self.messageObject.rejectBtnTitle forState:UIControlStateNormal];
    [_rejectBtn setTitleColor:self.contentConfig.rejectBtnColor forState:UIControlStateNormal];
    _rejectBtn.titleLabel.font = self.contentConfig.rejectBtnFont;
    CGSize rejectSize = CGSizeMake(44, 44);

    CGFloat rejectX = (centerX - rejectSize.width) / 2;
    CGFloat rejectY = (kDefaultHeight - rejectSize.height) / 2;
    _rejectBtn.frame = CGRectMake(rejectX, rejectY, rejectSize.width, rejectSize.height);

    _line.backgroundColor = self.contentConfig.lineColor;
    CGFloat padding = 10;
    _line.frame = CGRectMake(centerX, padding, 1, kDefaultHeight - 2 * padding);

    [_acceptBtn setTitle:self.messageObject.acceptBtnTitle forState:UIControlStateNormal];
    [_acceptBtn setTitleColor:self.contentConfig.acceptBtnColor forState:UIControlStateNormal];
    _acceptBtn.titleLabel.font = self.contentConfig.acceptBtnFont;
    CGSize acceptSize = CGSizeMake(44, 44);

    CGFloat acceptX = centerX + (centerX - acceptSize.width) / 2;
    CGFloat acceptY = (kDefaultHeight - acceptSize.height) / 2;
    _acceptBtn.frame = CGRectMake(acceptX, acceptY, acceptSize.width, acceptSize.height);
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    return CGSizeMake([ChatDateOfferTopView getViewSizeWithMessageModel:messageModel].width, kDefaultHeight);
}

#pragma mark - Event Response
- (void)rejectBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectDatingDescBottomViewDidTapBtnIndex:)]) {
        [self.delegate selectDatingDescBottomViewDidTapBtnIndex:0];
    }
}

- (void)acceptBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectDatingDescBottomViewDidTapBtnIndex:)]) {
        [self.delegate selectDatingDescBottomViewDidTapBtnIndex:1];
    }
}

@end
