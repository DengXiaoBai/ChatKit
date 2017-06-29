//
//  SKSTypingContentConfig.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/8.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSTypingContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatMessageObject.h"
#import "SKSTypingMessageObject.h"

@implementation SKSTypingContentConfig

- (CGSize)contentSizeWithCellWidth:(CGFloat)cellWidth {
    
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSTypingMessageObject class]]) {
        NSAssert(NO, @"messageAdditionalObject is not kind of SKSTypingMessageObject class");
        return CGSizeZero;
    }
    
    SKSTypingMessageObject *typingMessageObject = self.messageModel.message.messageAdditionalObject;
    if (typingMessageObject.animationImageNameList.count != 3) {
        NSAssert(NO, @"typingMessageObject animationImageNameList.count != 3");
        return CGSizeZero;
    }
    
    NSString *imageDotName1 = typingMessageObject.animationImageNameList[0];
    UIImage *dotImage = [UIImage imageNamed:imageDotName1];
    
    CGFloat scale = 1.5;
  
    CGSize contentViewSize = CGSizeMake(dotImage.size.width * scale, dotImage.size.height * scale);
    self.messageModel.contentViewSize = contentViewSize;
    
    return contentViewSize;
}


- (NSString *)cellContentClass {
    return @"SKSChatTypingContentView";
}


- (NSString *)cellContentIdentifier {
    return [NSString stringWithFormat:@"SKSChatTypingContentView-%@", self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? @"send" : @"receive"];
}


- (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(20, 15 + 8, 15, 20);//15 + 8： 8 是气泡尖角的宽度
}

- (UIEdgeInsets)bubbleViewInsetsRegardlessOfTheTimestampSituation {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}


- (UIEdgeInsets)timestampViewInsets {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel {
    self.messageModel = messageModel;
}

@end
