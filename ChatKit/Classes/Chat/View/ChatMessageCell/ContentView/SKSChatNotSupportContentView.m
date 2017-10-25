//
//  SKSChatNotSupportContentView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "SKSChatNotSupportContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatCellConfig.h"
#import "SKSNotSupportContentConfig.h"
#import "SKSChatSessionConfig.h"

@interface SKSChatNotSupportContentView()

@property (nonatomic, strong) TTTAttributedLabel *displayTextLabel;

@property (nonatomic, strong) SKSNotSupportContentConfig *notSupportConfig;

@end

@implementation SKSChatNotSupportContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    _notSupportConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    
    if (!_displayTextLabel) {
        _displayTextLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _displayTextLabel.translatesAutoresizingMaskIntoConstraints = YES;
        _displayTextLabel.backgroundColor = [UIColor clearColor];
        _displayTextLabel.textAlignment = NSTextAlignmentLeft;
        _displayTextLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber;
        _displayTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _displayTextLabel.userInteractionEnabled = YES;
        _displayTextLabel.numberOfLines = 0;
        _displayTextLabel.font = _notSupportConfig.textFont;
        
        NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionary];
        [mutableLinkAttributes setValue:(__bridge id)[[UIColor colorWithRed:64/255.0f green:140/255.0f blue:255/255.0f alpha:1] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableLinkAttributes setValue:[NSNumber numberWithBool:YES] forKey:(__bridge NSString *)kCTUnderlineStyleAttributeName];
        _displayTextLabel.linkAttributes = mutableLinkAttributes;
        [self addSubview:_displayTextLabel];
        
        [self bringSubviewToFront:_displayTextLabel];
    }

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    _notSupportConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    CGSize contentSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentInsets = self.messageModel.contentViewInsets;
    _displayTextLabel.textColor = _notSupportConfig.textColor;
    _displayTextLabel.text = self.messageModel.message.text;
    _displayTextLabel.frame = CGRectMake(contentInsets.left, contentInsets.top, contentSize.width, contentSize.height);

}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
