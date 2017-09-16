//
//  SKSChatCoreTextContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSChatCoreTextContentView.h"
#import "SKSCoreTextMessageObject.h"
#import <DTCoreText/DTAttributedTextView.h>
#import <DTCoreText/DTLinkButton.h>
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
        _displayCoreTextView.shouldDrawLinks = NO;
        _displayCoreTextView.shouldDrawImages = NO;
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

    if (messageModel.message.messageMediaType != SKSMessageMediaTypeCoreText) {//检测类型
        DLog(@"[Error] in SKSChatCoreTextContentView but messageMediaType != SKSMessageMediaTypeCoreText");
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

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame {

    NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];

    NSURL *URL = [attributes objectForKey:DTLinkAttribute];
    NSString *identifier = [attributes objectForKey:DTGUIDAttribute];


    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
    button.URL = URL;
    button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
    button.GUID = identifier;

    // get image with normal link text
    UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
    [button setImage:normalImage forState:UIControlStateNormal];

    // get image for highlighted link text
    UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
    [button setImage:highlightImage forState:UIControlStateHighlighted];

    // use normal push action for opening URL
    [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];

    // demonstrate combination with long press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
    [button addGestureRecognizer:longPress];

    return button;
}


#pragma mark - Event Response
- (void)linkPushed:(DTLinkButton *)sender {
    if ([self.delegate respondsToSelector:@selector(chatCoreTextDidTapAction:)]) {
        [self.delegate chatCoreTextDidTapAction:sender.URL];
    }
}

- (void)linkLongPressed:(UILongPressGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if ([self.delegate respondsToSelector:@selector(chatCoreTextDidLongPressAction:)]) {
                [self.delegate chatCoreTextDidLongPressAction:((DTLinkButton *)sender.view).URL];
            }
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
