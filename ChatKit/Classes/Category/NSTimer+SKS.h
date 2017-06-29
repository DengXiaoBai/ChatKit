//
// Created by iCrany on 2016/12/12.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SKS)

- (void)pauseTimer;//无限期暂停 NSTimer
- (void)resumeTimer;//重新启动 NSTimer

- (UIBackgroundTaskIdentifier)beginBackgroundTask;
- (void)endBackgroundTaskWithIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier;

@end