//
// Created by iCrany on 2016/12/12.
//

#import "NSTimer+SKS.h"


@implementation NSTimer (SKS)

- (void)pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

- (UIBackgroundTaskIdentifier)beginBackgroundTask {
    //support timer run in background
    UIBackgroundTaskIdentifier backgroundTaskIdentifier = 0;
    UIApplication  *app = [UIApplication sharedApplication];
    backgroundTaskIdentifier = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:backgroundTaskIdentifier];
    }];
    //end
    return backgroundTaskIdentifier;
}

- (void)endBackgroundTaskWithIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier {
    UIApplication *application = [UIApplication sharedApplication];
    [application endBackgroundTask:backgroundTaskIdentifier];
}

@end