//
//  SKSChatDateOfferDescBottomView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import "SKSChatDateOfferDescBottomView.h"
#import "SKSChatMessageModel.h"
#import "SKSDateOfferContentConfig.h"
#import "SKSDateOfferMessageObject.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessage.h"
#import "SKSChatDateOfferTopView.h"

static const CGFloat kDefaultHeight = 46;//在 Receive 方，跟 SKSChatDateOfferBtnBottomView 的高度统一, 避免因 DateOffer 状态的改变而重新刷新 Cell 的高度

@interface SKSChatDateOfferDescBottomView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) SKSDateOfferMessageObject *messageObject;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation SKSChatDateOfferDescBottomView

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
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.numberOfLines = 0;
        [self addSubview:_descLabel];
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

    CGFloat contentViewWidth = [UIScreen mainScreen].bounds.size.width * 0.5;
    UIEdgeInsets descInsets = self.contentConfig.bottomTitleInsets;
    _descLabel.font = self.contentConfig.bottomTitleFont;
    _descLabel.textColor = self.contentConfig.bottomTitleColor;
    _descLabel.text = self.messageObject.bottomDesc;

    CGSize descSize = [_descLabel sizeThatFits:CGSizeMake(contentViewWidth - descInsets.left - descInsets.right, FLT_MAX)];

    CGFloat x = descInsets.left;
    CGFloat y = descInsets.top;

    _descLabel.frame = CGRectMake(x, y, descSize.width, descSize.height);

    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeReceive) {
        CGSize topContentSize = [SKSChatDateOfferTopView getViewSizeWithMessageModel:self.messageModel];
        CGSize bottomContentSize = [SKSChatDateOfferDescBottomView getViewSizeWithMessageModel:self.messageModel];
        CGFloat max_width = MAX(topContentSize.width, bottomContentSize.width);
        _descLabel.frame = CGRectMake(max_width - descSize.width - descInsets.right, 0, descSize.width, descSize.height);
        if ( descInsets.top + descSize.height + descInsets.bottom - kDefaultHeight < FLT_MIN ) {
            _descLabel.center = CGPointMake(_descLabel.center.x, kDefaultHeight / 2);
        }
    }
}

#pragma mark - Public method
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {

    SKSDateOfferContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    SKSDateOfferMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    static UILabel *descLabel;
    if (!descLabel) {
        descLabel = [[UILabel alloc] init];
        descLabel.numberOfLines = 0;
        descLabel.font = contentConfig.bottomTitleFont;
    }

    descLabel.text = messageObject.bottomDesc;
    UIEdgeInsets descInsets = contentConfig.bottomTitleInsets;

    CGFloat contentViewWidth = [UIScreen mainScreen].bounds.size.width * 0.5;
    CGSize descSize = [descLabel sizeThatFits:CGSizeMake(contentViewWidth - descInsets.left - descInsets.right, FLT_MAX)];

    CGFloat mas_height = descInsets.top + descSize.height + descInsets.bottom;

    if (messageModel.message.messageSourceType == SKSMessageSourceTypeReceive) {
        mas_height = MAX(mas_height, kDefaultHeight);//对于接受方，需要取一个最大值
    }

    return CGSizeMake(descInsets.left + descSize.width + descInsets.right, mas_height);
}

@end
