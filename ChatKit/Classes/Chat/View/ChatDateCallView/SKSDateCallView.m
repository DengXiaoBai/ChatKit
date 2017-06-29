//
//  SKSDateCallView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//

#import "SKSDateCallView.h"
#import "SKSChatMessageModel.h"
#import "SKSDateCallContentConfig.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessage.h"
#import "UIColor+SKS.h"
#import "SKSDateCallMessageObject.h"
#import "View+MASAdditions.h"
#import "SKSChatCellConfig.h"
#import "SKSDefaultValueMaker.h"

@interface SKSDateCallView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSDateCallContentConfig *contentConfig;
@property (nonatomic, strong) SKSDateCallMessageObject *messageObject;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation SKSDateCallView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        _contentConfig = [[messageModel sessionConfig] chatContentConfigWithMessageModel:messageModel];
        _messageObject = messageModel.message.messageAdditionalObject;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = _contentConfig.titleFont;
        _titleLabel.textColor = _contentConfig.titleColor;
        [self addSubview:_titleLabel];
    }

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            break;
        }
        default: {
            if (!_line) {
                _line = [[UIView alloc] init];
                _line.backgroundColor = _contentConfig.lineColor;
                [self addSubview:_line];
            }

            if (!_iconImageView) {
                _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_messageObject.iconImageName]];
                [self addSubview:_iconImageView];
            }

            if (!_descLabel) {
                _descLabel = [[UILabel alloc] init];
                _descLabel.textColor = _contentConfig.descColor;
                _descLabel.font = _contentConfig.descFont;
                [self addSubview:_descLabel];
            }
            break;
        }
    }

    self.backgroundColor = _contentConfig.backgroundColor;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateWithMessageModel:_messageModel force:YES];
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    _titleLabel.text = _messageObject.titleText;
    _descLabel.text = _messageObject.descText;

    UIEdgeInsets titleEdgeInsets = _contentConfig.titleEdgeInsets;
    UIEdgeInsets iconImageViewEdgeInsets = _contentConfig.iconImageEdgeInsets;
    UIEdgeInsets descEdgeInsets = _contentConfig.descEdgeInsets;
    UIEdgeInsets lineEdgeInsets = _contentConfig.lineEdgeInsets;

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];
    CGSize descSize = [_descLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];

    UIImage *iconImage = [UIImage imageNamed:_messageObject.iconImageName];
    CGSize iconImageSize = iconImage.size;

    BOOL isDescLabelHigherThanIconImage = YES;
    if ((iconImageViewEdgeInsets.top + iconImageSize.height + iconImageViewEdgeInsets.bottom) - (descEdgeInsets.top + descSize.height + descEdgeInsets.bottom) > FLT_MIN) {
        isDescLabelHigherThanIconImage = NO;
    }

    CGFloat secondRowYBegin = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + lineEdgeInsets.top + _contentConfig.lineHeight + lineEdgeInsets.bottom;

    CGFloat firstLineWidth = titleSize.width;
    CGFloat secondLineWidth = iconImageSize.width + iconImageViewEdgeInsets.right + descEdgeInsets.left + descSize.width;


    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];
    CGFloat arrowWidth = cellConfig.getBubbleViewArrowWidth;

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _titleLabel.frame = CGRectMake(titleEdgeInsets.left, titleEdgeInsets.top, titleSize.width, titleSize.height);
            break;
        }
        case SKSMessageSourceTypeReceive: {
            BOOL isTheActivityAuthorUserId = [self.messageModel.message.toId isEqualToString:self.messageObject.activityAuthorId] && self.messageModel.message.toId.length > 0;
            if (!isTheActivityAuthorUserId && self.messageObject.callState != SKSMessageCallStateAccept) {
                _iconImageView.hidden = NO;
                _line.hidden = NO;

                CGFloat maxWidth = MAX(firstLineWidth, secondLineWidth);
                _titleLabel.frame = CGRectMake(titleEdgeInsets.left + arrowWidth, titleEdgeInsets.top, titleSize.width, titleSize.height);

                _line.frame = CGRectMake(lineEdgeInsets.left + arrowWidth, titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + lineEdgeInsets.top, maxWidth, _contentConfig.lineHeight);

                if (isDescLabelHigherThanIconImage) {
                    _iconImageView.frame = CGRectMake(arrowWidth + iconImageViewEdgeInsets.left, 0, iconImageSize.width, iconImageSize.height);
                    _descLabel.frame = CGRectMake(arrowWidth + iconImageViewEdgeInsets.left + iconImageSize.width + iconImageViewEdgeInsets.right + descEdgeInsets.left, secondRowYBegin + descEdgeInsets.top, descSize.width, descSize.height);

                    _iconImageView.center = CGPointMake(_iconImageView.center.x, _descLabel.center.y);
                } else {
                    _iconImageView.frame = CGRectMake(arrowWidth + iconImageViewEdgeInsets.left, secondRowYBegin + iconImageViewEdgeInsets.top, iconImageSize.width, iconImageSize.height);
                    _descLabel.frame = CGRectMake(arrowWidth + iconImageViewEdgeInsets.left + iconImageSize.width + iconImageViewEdgeInsets.right + descEdgeInsets.left, 0, descSize.width, descSize.height);

                    _descLabel.center = CGPointMake(_descLabel.center.x, _iconImageView.center.y);
                }
            } else {
                _titleLabel.frame = CGRectMake(titleEdgeInsets.left + arrowWidth, titleEdgeInsets.top, titleSize.width, titleSize.height);
                _iconImageView.hidden = YES;
                _line.hidden = YES;
            }
            break;
        }
        case SKSMessageSourceTypeReceiveCenter:
        case SKSMessageSourceTypeSendCenter:
        case SKSMessageSourceTypeCenter: {
            NSAssert(NO, @"not support SKSMessageSourceType center!");
            break;
        }
    }

}

+ (CGSize)dateCallSizeWithMessageModel:(SKSChatMessageModel *)messageModel {

    SKSDateCallContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    SKSDateCallMessageObject *messageObject = messageModel.message.messageAdditionalObject;
    id<SKSChatCellConfig> cellConfig = [messageModel.sessionConfig chatCellConfigWithMessage:messageModel.message];

    UIEdgeInsets titleEdgeInsets = contentConfig.titleEdgeInsets;
    UIEdgeInsets iconImageViewEdgeInsets = contentConfig.iconImageEdgeInsets;
    UIEdgeInsets descEdgeInsets = contentConfig.descEdgeInsets;
    UIEdgeInsets lineEdgeInsets = contentConfig.lineEdgeInsets;

    static UILabel *titleLabel;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = contentConfig.titleFont;
    }

    static UILabel *descLabel;
    if (!descLabel) {
        descLabel = [[UILabel alloc] init];
        descLabel.font = contentConfig.descFont;
    }

    titleLabel.text = messageObject.titleText;
    descLabel.text = messageObject.descText;

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];
    CGSize descSize = [descLabel sizeThatFits:CGSizeMake(screen_width, FLT_MAX)];
    CGSize imageSize = [UIImage imageNamed:messageObject.iconImageName].size;

    CGFloat firstRowWidth = titleEdgeInsets.left + titleSize.width + titleEdgeInsets.right;
    CGFloat secondRowWidth =  iconImageViewEdgeInsets.left + imageSize.width + iconImageViewEdgeInsets.right + descEdgeInsets.left + descSize.width + descEdgeInsets.right;

    CGFloat secondRowHeight = 0;
    CGFloat resultWidth = 0;
    CGFloat resultHeight = 0;

    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            resultWidth = firstRowWidth;
            resultHeight = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom;

            CGSize contentMinSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellConfig] chatNormalTextContentViewMinSize];
            if (contentMinSize.height  - resultHeight > FLT_MIN) {
                resultHeight = contentMinSize.height;
            }
            break;
        }
        default: {
            //如果自己是发布约会的人，是不能有回拨的功能
            BOOL isTheActivityAuthorUserId = [messageModel.message.toId isEqualToString:messageObject.activityAuthorId] && messageModel.message.toId.length > 0;
            if (!isTheActivityAuthorUserId && messageObject.callState != SKSMessageCallStateAccept) {
                secondRowHeight = MAX(iconImageViewEdgeInsets.top + imageSize.height + iconImageViewEdgeInsets.bottom, descEdgeInsets.top + descSize.height + descEdgeInsets.bottom);
                resultWidth = MAX(firstRowWidth, secondRowWidth);
                resultHeight = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom + lineEdgeInsets.top + contentConfig.lineHeight + lineEdgeInsets.bottom + secondRowHeight;
            } else {
                resultWidth = firstRowWidth;
                resultHeight = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom;

                CGSize contentMinSize = [[[SKSDefaultValueMaker shareInstance] getDefaultChatCellConfig] chatNormalTextContentViewMinSize];
                if (contentMinSize.height  - resultHeight > FLT_MIN) {
                    resultHeight = contentMinSize.height;
                }
                DLog(@"只显示一行, resultHeight: %lf", resultHeight);
            }
            break;
        }
    }

    return CGSizeMake(resultWidth + cellConfig.getBubbleViewArrowWidth, resultHeight);
}

@end
