//
//  SKSChatCoreTextContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSChatCoreTextContentView.h"
#import "DTAttributedTextView.h"
#import "SKSCoreTextMessageObject.h"
#import <DTCoreText/DTCoreText.h>
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"

@interface SKSChatCoreTextContentView() <DTAttributedTextContentViewDelegate>

@property (nonatomic, strong) DTAttributedTextView *displayCoreTextView;
@property (nonatomic, strong) SKSCoreTextMessageObject *messageObject;

@end

@implementation SKSChatCoreTextContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_displayCoreTextView) {
        _displayCoreTextView = [[DTAttributedTextView alloc] initWithFrame:CGRectZero];
        _displayCoreTextView.shouldDrawLinks = YES;
        _displayCoreTextView.shouldDrawImages = NO;
        _displayCoreTextView.userInteractionEnabled = NO;
        _displayCoreTextView.textDelegate = self;
        [self addSubview:_displayCoreTextView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    _messageObject = self.messageModel.message.messageAdditionalObject;

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    NSString *html = _messageObject.htmlText;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:nil];

    _displayCoreTextView.attributedString = attributedString;
    _displayCoreTextView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);

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

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
