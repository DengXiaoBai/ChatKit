//
//  ChatDateOfferTopView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import "ChatDateOfferTopView.h"
#import "ChatDateActivityMessageObject.h"
#import "ChatDateOfferMessageObject.h"
#import "ChatDateOfferContentConfig.h"
#import "ChatDateOfferDescBottomView.h"

@interface ChatDateOfferTopView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatDateOfferMessageObject *messageObject;
@property (nonatomic, strong) ChatDateOfferContentConfig *contentConfig;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *line;

@end

@implementation ChatDateOfferTopView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.messageObject = self.messageModel.message.messageAdditionalObject;
        self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            break;
        }
        default: {
            if (!_descLabel) {
                _descLabel = [[UILabel alloc] init];
                _descLabel.numberOfLines = 0;
                [self addSubview:_descLabel];
            }
            break;
        }
    }


    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
    }

    if (!_line) {
        _line = [[UIView alloc] init];
        [self addSubview:_line];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateWithMessageModel:self.messageModel force:YES];
}

#pragma mark - Public method
- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    CGFloat cell_max_width = [UIScreen mainScreen].bounds.size.width * 0.5;
    self.titleLabel.textColor = self.contentConfig.titleColor;
    self.titleLabel.font = self.contentConfig.titleFont;
    self.titleLabel.text = self.messageObject.title;
    UIEdgeInsets titleEdgeInsets = self.contentConfig.titleInsets;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(cell_max_width - titleEdgeInsets.left - titleEdgeInsets.right, FLT_MAX)];
    self.titleLabel.frame = CGRectMake(titleEdgeInsets.left, titleEdgeInsets.top, titleSize.width, titleSize.height);

    self.iconImageView.image = [UIImage imageNamed:self.messageObject.iconImageName];
    UIEdgeInsets iconImageInsets = self.contentConfig.iconImageInsets;
    CGSize iconImageSize = self.iconImageView.image.size;

    UIEdgeInsets descEdgeInsets = UIEdgeInsetsZero;
    CGSize descSize = CGSizeZero;
    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            break;
        }
        default: {
            self.descLabel.textColor = self.contentConfig.descColor;
            self.descLabel.font = self.contentConfig.descFont;
            self.descLabel.text = self.messageObject.topDesc;
            descEdgeInsets = self.contentConfig.descInsets;
            descSize = [self.descLabel sizeThatFits:CGSizeMake(cell_max_width - descEdgeInsets.left - descEdgeInsets.right, FLT_MAX)];
            CGFloat descX = descEdgeInsets.left;
            CGFloat descY = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + descEdgeInsets.top;
            self.descLabel.frame = CGRectMake(descX, descY, descSize.width, descSize.height);
            break;
        }
    }


    CGFloat firstRow = titleEdgeInsets.left + titleSize.width + titleEdgeInsets.right;
    CGFloat secondRow = descEdgeInsets.left + descSize.width + descEdgeInsets.right;

    UIEdgeInsets bottomTitleInsets = self.contentConfig.bottomTitleInsets;
    CGFloat descBottomWidth = 0;

    if (self.messageModel.message.messageSourceType != SKSMessageSourceTypeReceive || self.messageObject.dateOfferState != SKSDateOfferStateNotProcessed) {
        descBottomWidth = [ChatDateOfferDescBottomView getViewSizeWithMessageModel:messageModel].width - bottomTitleInsets.left - bottomTitleInsets.right;
    }

    CGFloat maxRowWidth = MAX(firstRow, secondRow);
    maxRowWidth = MAX(descBottomWidth, maxRowWidth);

    CGFloat iconX = maxRowWidth + iconImageInsets.left;
    CGFloat iconY = (titleEdgeInsets.top + titleSize.height - iconImageSize.height) / 2;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconImageSize.width, iconImageSize.height);
    self.iconImageView.center = CGPointMake(self.iconImageView.center.x, self.titleLabel.center.y);


    self.line.backgroundColor = self.contentConfig.lineColor;
    UIEdgeInsets lineInsets = self.contentConfig.lineInsets;
    CGFloat lineY = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + descEdgeInsets.top + descSize.height + descEdgeInsets.bottom + lineInsets.top;
    CGFloat lineWidth = self.iconImageView.frame.origin.x + iconImageSize.width;

    self.line.frame = CGRectMake(lineInsets.left, lineY, lineWidth, self.contentConfig.lineHeight);
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {

    ChatDateOfferContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    ChatDateOfferMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    static UILabel *titleLabel;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = contentConfig.titleFont;
    }

    static UILabel *descLabel;
    if (!descLabel) {
        descLabel = [[UILabel alloc] init];
        descLabel.numberOfLines = 0;
        descLabel.font = contentConfig.descFont;
    }

    CGFloat cell_max_width = [UIScreen mainScreen].bounds.size.width * 0.5;
    titleLabel.text = messageObject.title;
    UIEdgeInsets titleEdgeInsets = contentConfig.titleInsets;
    CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(cell_max_width - titleEdgeInsets.left - titleEdgeInsets.right, FLT_MAX)];

    UIImage *iconImage = [UIImage imageNamed:messageObject.iconImageName];
    UIEdgeInsets iconImageInsets = contentConfig.iconImageInsets;
    CGSize iconImageSize = iconImage.size;


    UIEdgeInsets descEdgeInsets = UIEdgeInsetsZero;
    CGSize descSize = CGSizeZero;

    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            break;
        }
        default: {
            descLabel.text = messageObject.topDesc;
            descEdgeInsets = contentConfig.descInsets;
            descSize = [descLabel sizeThatFits:CGSizeMake(cell_max_width - descEdgeInsets.left - descEdgeInsets.right, FLT_MAX)];
            break;
        }
    }

    CGFloat width1 = titleEdgeInsets.left + titleSize.width + titleEdgeInsets.right;// + iconImageInsets.left + iconImageSize.width + iconImageInsets.right;
    CGFloat width2 = descEdgeInsets.left + descSize.width + descEdgeInsets.right;

    //还有比比底部 ChatDateOfferDescBottomView 的宽度
    CGFloat descBottomWidth = 0;
    if (messageModel.message.messageSourceType != SKSMessageSourceTypeReceive || messageObject.dateOfferState != SKSDateOfferStateNotProcessed) {
        descBottomWidth = [ChatDateOfferDescBottomView getViewSizeWithMessageModel:messageModel].width;
    }

    CGFloat max_width = MAX(width1, width2);
    max_width = MAX(descBottomWidth, max_width) + iconImageInsets.left + iconImageSize.width + iconImageInsets.right;
    CGFloat max_height = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + descEdgeInsets.top + descSize.height + descEdgeInsets.bottom + contentConfig.lineInsets.top + contentConfig.lineHeight + contentConfig.lineInsets.bottom;
    return CGSizeMake(max_width, max_height);
}

@end
