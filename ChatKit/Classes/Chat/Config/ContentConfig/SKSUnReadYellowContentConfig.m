//
//  SKSUnReadYellowContentConfig.m
//  ChatKit
//
//  Created by iCrany on 2017/2/22.
//
//

#import "SKSUnReadYellowContentConfig.h"
#import "SKSChatMessageConstant.h"
#import "SKSUnReadMessageObject.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatUnReadYellowTipContentView.h"

@interface SKSUnReadYellowContentConfig()

@property (nonatomic, strong) UILabel *commonLabel;

@end

@implementation SKSUnReadYellowContentConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentHeight = 24.0f;
        self.textColor = RGB(94, 94, 94);
        self.textFont = [UIFont systemFontOfSize:14];
        self.textInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        self.backgroundColor = RGB(249, 234, 204);
    }
    return self;
}

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    CGSize contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.contentHeight);
    self.messageModel.contentViewSize = contentSize;
    return contentSize;
}

- (NSString *)cellContentClass {
    return NSStringFromClass([SKSChatUnReadYellowTipContentView class]);
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"%@-%@", [self cellContentClass], self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}


- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsZero;
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;
}

#pragma mark - getter/setter
- (UILabel *)commonLabel {
    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc] init];
        _commonLabel.font = _textFont;
        _commonLabel.numberOfLines = 0;
        _commonLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commonLabel;
}

@end
