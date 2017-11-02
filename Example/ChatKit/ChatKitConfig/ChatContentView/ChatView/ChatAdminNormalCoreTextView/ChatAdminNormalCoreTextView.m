//
//  ChatAdminNormalCoreTextView.m
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//

#import "ChatAdminNormalCoreTextView.h"
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTAttributedTextView.h>
#import <DTCoreText/DTAttributedTextContentView.h>
#import "ChatAdminNormalCoreTextMessageObject.h"
#import "ChatAdminNormalCoreTextConfig.h"
#import <ChatKit/SKSChatMessageModel.h>


@interface ChatAdminNormalCoreTextView()
// controls
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *seperator;
@property (nonatomic, strong) DTAttributedTextView *displayCoreTextView;

// models
@property (nonatomic, strong) ChatAdminNormalCoreTextMessageObject *messageObject;
@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatAdminNormalCoreTextConfig *contentConfig;

@end


@implementation ChatAdminNormalCoreTextView

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
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatAdminNormalCoreTextMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatAdminNormalCoreTextMessageObject class");
        return;
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    
    if (!_seperator) {
        _seperator = [[UIView alloc] init];
        _seperator.backgroundColor = self.contentConfig.lineColor;
        [self addSubview:_seperator];
    }
    
    if (!_displayCoreTextView) {
        _displayCoreTextView = [[DTAttributedTextView alloc] initWithFrame:CGRectZero];
        _displayCoreTextView.shouldDrawLinks = NO;
        _displayCoreTextView.shouldDrawImages = NO;
        _displayCoreTextView.backgroundColor = self.contentConfig.backgroundColor;
        [self addSubview:_displayCoreTextView];
    }
    
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [self updateUIWithMessageModel:self.messageModel force:YES];
//}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }
    
    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    
    CGFloat yValue = 0 ;
    
    // title
    CGFloat cell_max_width = self.contentConfig.cellWidth;
    UIEdgeInsets titleEdgeInsets = self.contentConfig.titleInsets;
    
    CGFloat max_width = cell_max_width - titleEdgeInsets.left - titleEdgeInsets.right;
    self.titleLabel.textColor = self.contentConfig.titleColor;
    self.titleLabel.font = self.contentConfig.titleFont;
    self.titleLabel.text = self.messageObject.title;
    
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(max_width, FLT_MAX)];
    yValue = titleEdgeInsets.top ;
    self.titleLabel.frame = CGRectMake(titleEdgeInsets.left, yValue, titleSize.width, titleSize.height);
    
    // line
    yValue = yValue + titleSize.height + titleEdgeInsets.bottom+ self.contentConfig.lineInsets.top ;
    self.seperator.backgroundColor = self.contentConfig.lineColor;
   
    
    // displayCoreTextView
    NSString *html = _messageObject.htmlText;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:nil];
    _displayCoreTextView.attributedString = attributedString;
    CGSize attributedTextSize = [self.displayCoreTextView.attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:self.contentConfig.cellWidth];
    
    self.seperator.frame = CGRectMake(titleEdgeInsets.left, yValue, attributedTextSize.width, 1);
    
    UIEdgeInsets coreTextInsets = self.contentConfig.coreTextViewInsets;
    yValue = yValue + 1 + self.contentConfig.lineInsets.bottom + coreTextInsets.top;
    self.displayCoreTextView.frame = CGRectMake(coreTextInsets.left, yValue, attributedTextSize.width, attributedTextSize.height);
    
}

#pragma mark - Public method
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth {
    
    ChatAdminNormalCoreTextConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    ChatAdminNormalCoreTextMessageObject *messageObject = messageModel.message.messageAdditionalObject;
    
    // title
    CGFloat width = 0;
    CGFloat height = 0;
    
    static UILabel * titleLabel;
    if (titleLabel == nil) {
        titleLabel = [UILabel new];
        titleLabel.numberOfLines = 0;
        titleLabel.font = contentConfig.titleFont;
    }
    
    titleLabel.text = messageObject.title;
    UIEdgeInsets titleEdgeInsets = contentConfig.titleInsets;
    CGFloat max_width = contentConfig.cellWidth - titleEdgeInsets.left - titleEdgeInsets.right;
    CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(max_width, FLT_MAX)];
    
    
    // core text
    UIEdgeInsets coreTextInsets = contentConfig.coreTextViewInsets;
    static DTAttributedTextContentView *attributedTextContentView;
    if (!attributedTextContentView) {
        attributedTextContentView = [[DTAttributedTextContentView alloc] initWithFrame:CGRectZero];
        attributedTextContentView.shouldDrawImages = YES;
        attributedTextContentView.shouldDrawLinks = YES;
    }
    
    NSString *html = messageObject.htmlText;
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    
    attributedTextContentView.attributedString = attributedString;
    [attributedTextContentView relayoutMask];
    [attributedTextContentView relayoutText];
    CGSize coreTextSize = [attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:contentConfig.cellWidth];
    
    width = coreTextInsets.left + coreTextSize.width + coreTextInsets.right ;
    height = titleEdgeInsets.top + titleSize.height + titleEdgeInsets.bottom +  contentConfig.lineInsets.top + 1 + contentConfig.lineInsets.bottom + contentConfig.coreTextViewInsets.top + coreTextSize.height + contentConfig.coreTextViewInsets.bottom;
    
    return CGSizeMake(width, height);
}

@end
