//
//  ChatTextContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatTextContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSTextContentConfig.h"
#import "SKSChatSessionConfig.h"

@interface SKSChatTextContentView() <TTTAttributedLabelDelegate>

@property (nonatomic, strong) SKSTextContentConfig *contentConfig;

@end

@implementation SKSChatTextContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    
    if (!_displayTextLabel) {
        _displayTextLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _displayTextLabel.translatesAutoresizingMaskIntoConstraints = YES;
        _displayTextLabel.backgroundColor = [UIColor clearColor];
        _displayTextLabel.textAlignment = NSTextAlignmentLeft;
        _displayTextLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber;
        _displayTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _displayTextLabel.userInteractionEnabled = YES;
        _displayTextLabel.numberOfLines = 0;
        _displayTextLabel.delegate = self;
        
        _displayTextLabel.textColor = _contentConfig.textColor;
        _displayTextLabel.font = _contentConfig.textFont;
        
        NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionary];
        [mutableLinkAttributes setValue:(__bridge id)[[UIColor colorWithRed:64/255.0f green:140/255.0f blue:255/255.0f alpha:1] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableLinkAttributes setValue:[NSNumber numberWithBool:YES] forKey:(__bridge NSString *)kCTUnderlineStyleAttributeName];
        _displayTextLabel.linkAttributes = mutableLinkAttributes;
        [self addSubview:_displayTextLabel];
        
        [self bringSubviewToFront:_displayTextLabel];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    if (messageModel.message.messageMediaType != SKSMessageMediaTypeText
            && messageModel.message.messageMediaType != SKSMessageMediaTypeUnsupport) {//检测类型
        DLog(@"[Error] in SKSChatTextContentView but messageMediaType != SKSMessageMediaTypeText && messageMediaType != SKSMessageMediaTypeUnsupport");
        return;
    }

    self.messageModel = messageModel;
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];


    CGSize contentSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentInsets = self.messageModel.contentViewInsets;

    _displayTextLabel.text = self.messageModel.message.text;
    _displayTextLabel.frame = CGRectMake(contentInsets.left, contentInsets.top, contentSize.width, contentSize.height);
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
