//
//  SKSChatCompressTopView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import "ChatImpressTopView.h"
#import "ChatImpressMessageObject.h"
#import "ChatImpressContentConfig.h"

@interface ChatImpressTopView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatImpressMessageObject *messageObject;
@property (nonatomic, strong) ChatImpressContentConfig *contentConfig;

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation ChatImpressTopView

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
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = self.contentConfig.topDescColor;
        _descLabel.font = self.contentConfig.topDescFont;
        [self addSubview:_descLabel];
    }

    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = self.contentConfig.lineColor;
        [self addSubview:_line];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId != messageModel.message.messageId && messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.descLabel.text = self.messageObject.topDesc;
    CGSize descSize = [self.descLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];

    self.descLabel.frame = CGRectMake(0, 0, self.contentConfig.cellWidth, descSize.height);

    UIEdgeInsets lineInsets = self.contentConfig.lineInsets;
    CGFloat lineYOffset = descSize.height + lineInsets.top;
    self.line.frame = CGRectMake(0, lineYOffset, self.contentConfig.cellWidth, self.contentConfig.lineHeight);
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    ChatImpressMessageObject *messageObject = messageModel.message.messageAdditionalObject;
    ChatImpressContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];

    static UILabel *tempLabel;
    if (!tempLabel) {
        tempLabel = [[UILabel alloc] init];
        tempLabel.numberOfLines = 0;
        tempLabel.font = contentConfig.topDescFont;
    }

    tempLabel.text = messageObject.topDesc;
    CGSize descSize = [tempLabel sizeThatFits:CGSizeMake(contentConfig.cellWidth, FLT_MAX)];

    UIEdgeInsets lineInsets = contentConfig.lineInsets;

    return CGSizeMake(contentConfig.cellWidth, descSize.height + lineInsets.top + contentConfig.lineHeight + lineInsets.bottom);
}

@end
