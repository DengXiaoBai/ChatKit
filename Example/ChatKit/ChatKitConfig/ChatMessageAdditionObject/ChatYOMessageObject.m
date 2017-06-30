//
//  ChatYOMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatMessage.h>
#import "ChatYOMessageObject.h"

@implementation ChatYOMessageObject

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        [self prepareInitData];
    }
    return self;
}

- (void)prepareInitData {
    
    NSDictionary *dict = [self json2dict:self.text];
    
    self.yoFont = [UIFont fontWithName:[dict objectForKey:@"font"] size:30];
    self.yoColor = [self stringTOColor:[dict objectForKey:@"color"]];
    
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeYO;
}

#pragma mark - Helper method
- (NSDictionary *)json2dict:(NSString *)json {
    NSDictionary *dict = nil;
    if (json) {
        NSError *error;
        dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    }
    
    return dict;
}

- (UIColor *) stringTOColor:(NSString *)str {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
