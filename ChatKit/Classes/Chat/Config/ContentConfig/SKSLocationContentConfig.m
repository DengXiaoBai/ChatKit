//
//  SKSLocationContentConfig.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSLocationContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatCellConfig.h"

@implementation SKSLocationContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {

    CGFloat width = UIScreen.mainScreen.bounds.size.width / 2;
    CGFloat height = _locationImageInsets.top + _locationImageSize.height + _locationImageInsets.bottom + _titleLabelInsets.top + _titleLabelSize.height + _titleLabelInsets.bottom + _descLabelInsets.top + _descLabelSize.height + _descLabelInsets.bottom;
    self.messageModel.contentViewSize = CGSizeMake(width, height);
    return self.messageModel.contentViewSize;
}


- (NSString *)cellContentClass {
    return @"SKSChatLocationContentView";
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"SKSChatLocationContentView-%@", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}


- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;

    id<SKSChatCellConfig> cellConfig = [self.messageModel.sessionConfig chatCellConfigWithMessage:self.messageModel.message];

    _locationImageSize = CGSizeMake(0, 100);
    _locationImageInsets = UIEdgeInsetsMake(0, 10, 0, 10);

    _titleLabelSize = CGSizeMake(0, 24);
    //cellConfig
    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            _titleLabelInsets = UIEdgeInsetsMake(8, 10 + cellConfig.getBubbleViewArrowWidth, 0, 10);
            break;
        }
        case SKSMessageSourceTypeSend: {
            _titleLabelInsets = UIEdgeInsetsMake(8, 10, 0, 10 + cellConfig.getBubbleViewArrowWidth);
            break;
        }
        default: {
            _titleLabelInsets = UIEdgeInsetsMake(8, 10, 0, 10);
            break;
        }
    }

    _descLabelSize = CGSizeMake(0, 20);
    _descLabelInsets = UIEdgeInsetsMake(-4, 10, 10, 10);

    _descLabelFont = [UIFont systemFontOfSize:12];
    _descLabelColor = RGB(149, 152, 154);

    _titleLabelFont = [UIFont systemFontOfSize:14];
    _titleLabelColor = RGB(51, 51, 51);

    _imageBackgroundColor = RGB(243, 243, 245);
}


@end
