//
//  SKSDateOfferView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import "SKSDateOfferView.h"
#import "SKSChatDateOfferTopView.h"
#import "SKSChatDateOfferBtnBottomView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatDateOfferDescBottomView.h"
#import "SKSChatMessage.h"
#import "SKSDateOfferMessageObject.h"

@interface SKSDateOfferView() <SKSChatSelectDatingDescBottomViewDelegate>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSDateOfferMessageObject *messageObject;

@property (nonatomic, strong) SKSChatDateOfferTopView *topView;
@property (nonatomic, strong) SKSChatDateOfferBtnBottomView *btnBottomView;
@property (nonatomic, strong) SKSChatDateOfferDescBottomView *descBottomView;

@end

@implementation SKSDateOfferView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.messageObject = self.messageModel.message.messageAdditionalObject;
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    if (!_topView) {
        _topView = [[SKSChatDateOfferTopView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_topView];
    }

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            if (self.messageObject.dateOfferState == SKSDateOfferStateNotProcessed) {
                if (!_btnBottomView) {
                    _btnBottomView = [[SKSChatDateOfferBtnBottomView alloc] initWithMessageModel:self.messageModel];
                    _btnBottomView.delegate = self;
                    [self addSubview:_btnBottomView];
                }

                if (!_descBottomView) {
                    _descBottomView = [[SKSChatDateOfferDescBottomView alloc] initWithMessageModel:self.messageModel];
                    _descBottomView.hidden = YES;//需要从未处理状态转换成失效状态
                    [self addSubview:_descBottomView];
                }
            } else {
                if (!_descBottomView) {
                    _descBottomView = [[SKSChatDateOfferDescBottomView alloc] initWithMessageModel:self.messageModel];
                    [self addSubview:_descBottomView];
                }
            }
            break;
        }
        case SKSMessageSourceTypeSend: {
            if (!_descBottomView) {
                _descBottomView = [[SKSChatDateOfferDescBottomView alloc] initWithMessageModel:self.messageModel];
                [self addSubview:_descBottomView];
            }
            break;
        }
        default: {
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

#pragma mark - Public method
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    [_topView updateWithMessageModel:self.messageModel force:force];

    //根据不同的类型来判断
    CGSize topViewSize = [SKSChatDateOfferTopView getViewSizeWithMessageModel:self.messageModel];
    _topView.frame = CGRectMake(0, 0, topViewSize.width, topViewSize.height);

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            [_descBottomView updateUIWithMessageModel:self.messageModel force:force];
            CGSize descBottomViewSize = [SKSChatDateOfferDescBottomView getViewSizeWithMessageModel:self.messageModel];
            _descBottomView.frame = CGRectMake(0, topViewSize.height, descBottomViewSize.width, descBottomViewSize.height);
            break;
        }
        case SKSMessageSourceTypeReceive: {
            if (self.messageObject.dateOfferState == SKSDateOfferStateNotProcessed) {
                _descBottomView.hidden = YES;
                _btnBottomView.hidden = NO;

                [_btnBottomView updateUIWithMessageModel:self.messageModel force:force];
                CGSize btnBottomViewSize = [SKSChatDateOfferBtnBottomView getViewSizeWithMessageModel:self.messageModel];
                _btnBottomView.frame = CGRectMake(0, topViewSize.height, btnBottomViewSize.width, btnBottomViewSize.height);

            } else {
                _btnBottomView.hidden = YES;
                _descBottomView.hidden = NO;

                [_descBottomView updateUIWithMessageModel:self.messageModel force:force];
                CGSize descBottomViewSize = [SKSChatDateOfferDescBottomView getViewSizeWithMessageModel:self.messageModel];
                _descBottomView.frame = CGRectMake(0, topViewSize.height, topViewSize.width, descBottomViewSize.height);
            }
            break;
        }
        default: {
            DLog(@"Not Support messageSourceType %ld", (long)self.messageModel.message.messageSourceType);
            break;
        }
    }
}

#pragma mark - SKSChatSelectDatingDescBottomViewDelegate
- (void)selectDatingDescBottomViewDidTapBtnIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(selectDatingViewBtnActionAtIndex:)]) {
        [self.delegate selectDatingViewBtnActionAtIndex:buttonIndex];
    }
}

@end
