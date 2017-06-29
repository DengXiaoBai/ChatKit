//
//  ChatSessionHelper.m
//  ChatKit
//
//  Created by iCrany on 2017/2/28.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

#import <ChatKit/SKSChatMessageConstant.h>
#import "ChatSessionHelper.h"

@implementation ChatSessionHelper


+ (void)sysnEmoticonList {
    NSString *emojiFileName = @"EmojisList";
    NSString *emojiFileType = @"plist";
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:emojiFileName ofType:emojiFileType]];

    NSString *emojiInsName = @"in2";
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:emojiInsName ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

    NSArray *array = [content componentsSeparatedByString:@"\n"];
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger content = [[array objectAtIndex:i] integerValue];
        DLog(@"%ld: %ld", (long)i, (long)content);
    }

    NSMutableDictionary *newDict = [dictionary mutableCopy];

    for (NSString *key in dictionary.allKeys) {
        NSArray *emojiList = dictionary[key];

        NSMutableArray *newEmojiList = [[NSMutableArray alloc] init];

        NSInteger i = 0;
        for (NSString *emojiStr in emojiList) {
            DLog(@"%ld: %@", (long)i, emojiStr);

            BOOL isFind = NO;
            for (NSInteger j = 0; j < array.count; j++) {
                NSInteger index = [[array objectAtIndex:j] integerValue];
                if (index == i) {
                    isFind = YES;
                    break;
                }
            }

            if (isFind) {
                [newEmojiList addObject:emojiStr];
                DLog(@"Exit emoji");
            } else {
                DLog(@"Not exit emoji");
            }
            i++;
        }

        DLog(@"emojiList.count: %ld", (long)emojiList.count);
        DLog(@"newEmojiList.count: %ld", (long)newEmojiList.count);
        newDict[key] = newEmojiList;
    }


    NSString *newFileName = @"newEmojisList.plist";
    //写文件
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullFilePathName = [filePath stringByAppendingPathComponent:newFileName];
    DLog(@"fullFilePathName: %@", fullFilePathName);
    BOOL isOk = [newDict writeToFile:fullFilePathName atomically:YES];
    DLog(@"isOk: %d", isOk);
}

@end
