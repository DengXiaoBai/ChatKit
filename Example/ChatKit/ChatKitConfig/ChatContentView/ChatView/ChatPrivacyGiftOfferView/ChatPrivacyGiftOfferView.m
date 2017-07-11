//
//  ChatPrivacyGiftOfferView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <DTCoreText/DTAttributedTextContentView.h>
#import <DTCoreText/DTAttributedTextView.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <DTCoreText/DTCoreText.h>
#import "ChatPrivacyGiftOfferView.h"
#import "ChatPrivacyGiftOfferBtnView.h"
#import "ChatPrivacyGiftOfferDescView.h"
#import "ChatPrivacyGiftOfferMessageObject.h"
#import "ChatPrivacyGiftOfferContentConfig.h"


@interface ChatPrivacyGiftOfferView() <ChatPrivacyGiftOfferBtnViewDelegate, DTAttributedTextContentViewDelegate>

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyGiftOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyGiftOfferMessageObject *messageObject;

@property (nonatomic, strong) DTAttributedTextView *displayCoreTextView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) ChatPrivacyGiftOfferBtnView *bottomBtnView;
@property (nonatomic, strong) ChatPrivacyGiftOfferDescView *bottomDescView;

@end

@implementation ChatPrivacyGiftOfferView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatPrivacyGiftOfferMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatPrivacyGiftOfferMessageObject class");
        return;
    }

    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.displayCoreTextView = [[DTAttributedTextView alloc] init];
    [self addSubview:self.displayCoreTextView];
    _displayCoreTextView.shouldDrawLinks = YES;
    _displayCoreTextView.shouldDrawImages = NO;
    _displayCoreTextView.userInteractionEnabled = NO;
    _displayCoreTextView.textDelegate = self;
    _displayCoreTextView.backgroundColor = self.contentConfig.backgroundColor;
    [self addSubview:_displayCoreTextView];

    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeReceive) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = self.contentConfig.lineColor;
        [self addSubview:self.lineView];

        self.bottomBtnView = [[ChatPrivacyGiftOfferBtnView alloc] initWithMessageModel:self.messageModel];
        self.bottomBtnView.delegate = self;
        [self addSubview:self.bottomBtnView];

        self.bottomDescView = [[ChatPrivacyGiftOfferDescView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:self.bottomDescView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    NSString *html = _messageObject.titleContent;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:nil];
    _displayCoreTextView.attributedString = attributedString;
    [self.bottomDescView updateUIWithMessageModel:self.messageModel force:force];
    [self.bottomBtnView updateUIWithMessageModel:self.messageModel force:force];

    UIEdgeInsets titleLabelInset = self.contentConfig.contentLabelInsets;
    CGSize titleSize = [self.displayCoreTextView.attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:self.contentConfig.cellWidth];
    self.displayCoreTextView.frame = CGRectMake(titleLabelInset.left, titleLabelInset.top, titleSize.width, titleSize.height);
    self.lineView.frame = CGRectMake(titleLabelInset.left, titleLabelInset.top + titleSize.height + self.contentConfig.hLineInsets.top, titleSize.width, 1);

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            switch(self.messageObject.state) {
                case SKSPrivacyGiftOfferStateUnhandle: {
                    self.bottomBtnView.hidden = NO;
                    self.bottomDescView.hidden = YES;
                    break;
                }
                case SKSPrivacyGiftOfferStateAccept: {
                    self.bottomBtnView.hidden = YES;
                    self.bottomDescView.hidden = NO;
                    break;
                }
                case SKSPrivacyGiftOfferStateReject: {
                    self.bottomBtnView.hidden = YES;
                    self.bottomDescView.hidden = NO;
                    break;
                }
                default: {
                    break;
                }
            }

            CGFloat y = titleLabelInset.top + titleSize.height + titleLabelInset.bottom + self.contentConfig.hLineInsets.top + 1;
            self.bottomDescView.frame = CGRectMake(titleLabelInset.left, y, titleSize.width, self.contentConfig.bottomViewHeight);
            self.bottomBtnView.frame = CGRectMake(titleLabelInset.left, y, titleSize.width, self.contentConfig.bottomViewHeight);
            break;
        }
        case SKSMessageSourceTypeSend: {
            break;
        }
        default: {
            break;
        }
    }

}

#pragma mark - Public method
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth {
    ChatPrivacyGiftOfferContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    ChatPrivacyGiftOfferMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    static DTAttributedTextContentView *attributedTextContentView;
    if (!attributedTextContentView) {
        attributedTextContentView = [[DTAttributedTextContentView alloc] initWithFrame:CGRectZero];
        attributedTextContentView.shouldDrawImages = YES;
        attributedTextContentView.shouldDrawLinks = YES;
    }

    NSString *html = messageObject.titleContent;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];

    attributedTextContentView.attributedString = attributedString;
    [attributedTextContentView relayoutMask];
    [attributedTextContentView relayoutText];
    CGSize titleSize = [attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:contentConfig.cellWidth];

    UIEdgeInsets titleInset = contentConfig.contentLabelInsets;

    CGSize contentSize = CGSizeZero;
    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            contentSize = CGSizeMake(titleInset.left + titleSize.width + titleInset.right,
                    titleInset.top + titleSize.height + titleInset.bottom + contentConfig.vLineInsets.top + 1 + contentConfig.hLineInsets.bottom + contentConfig.bottomViewHeight);
            break;
        }
        case SKSMessageSourceTypeSend: {
            contentSize = CGSizeMake(titleInset.left + titleSize.width + titleInset.right,
                    titleInset.top + titleSize.height + titleInset.bottom);
            break;
        }
        default: {
            break;
        }
    }

    return contentSize;
}

#pragma mark - ChatPrivacyGiftOfferBtnViewDelegate
- (void)privacyGiftOfferButtonTapIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(privacySendRosesViewButtonTapIndex:)]) {
        [self.delegate privacySendRosesViewButtonTapIndex:buttonIndex];
    }
}

#pragma mark - DTAttributedTextContentViewDelegate
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    if ([attachment isKindOfClass:[DTImageTextAttachment class]]) {
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];

        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];

        if (imageView.image == nil && !attachment.hyperLinkURL) {
            //获取图片的资源
            UIImage *image = [UIImage imageNamed:attachment.contentURL.absoluteString];
            imageView.image = image;
        }

        // url for deferred loading
        imageView.url = attachment.contentURL;
        return imageView;
    }
    return nil;
}

@end
