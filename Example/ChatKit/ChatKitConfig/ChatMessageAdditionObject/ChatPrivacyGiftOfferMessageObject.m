//
//  ChatPrivacyGiftOfferMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//


#import <GRMustache/GRMustacheTemplate.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatPrivacyGiftOfferMessageObject.h"

@implementation ChatPrivacyGiftOfferMessageObject

- (instancetype)initWithRoseCount:(int32_t)roseCount
                     leftBtnTitle:(NSString *)leftBtnTitle
                    rightBtnTitle:(NSString *)rightBtnTitle
                            state:(SKSPrivacyGiftOfferState)state {
    self = [super init];
    if (self) {
        self.roseCount = roseCount;
        self.leftBtnTitle = leftBtnTitle;
        self.rightBtnTitle = rightBtnTitle;
        self.state = state;
    }
    return self;
}

- (NSString *)titleContent {

    NSString *templatePath;

    //需要区分是发送者还是接收者
    if (self.message.messageSourceType == SKSMessageSourceTypeReceive) {
        templatePath = [[NSBundle mainBundle] pathForResource:@"chat_admin" ofType:@"html"];
    } else {
        templatePath = [[NSBundle mainBundle] pathForResource:@"chat_admin_send" ofType:@"html"];
    }

    NSString *templateHtml = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:NULL];

    NSError *error;
    NSString *registerSuccessContent = @"<p>我觉得你很好，决定送你%ld朵<img style=\"width:16px; height:16px;\" src=\"common-roses-icon.png\">表示我的心意，希望能和你沟通一下</p>";
    NSString *renderChatHtml = [GRMustacheTemplate renderObject: @ {
            @"key_content" : registerSuccessContent,
            @"key_css_name" : @"chat"
    } fromString:templateHtml error:&error];

    return [NSString stringWithFormat:renderChatHtml, self.roseCount];
}

- (NSString *)bottomDescContent {

    switch (self.state) {
        case SKSPrivacyGiftOfferStateUnhandle: {
            return @"";
        }
        case SKSPrivacyGiftOfferStateAccept: {
            return @"已接受";
        }
        case SKSPrivacyGiftOfferStateReject: {
            return @"已拒绝";
        }
        default:{
            return @"";
        }
    }
}



@end
