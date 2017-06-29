//
// Created by iCrany on 2016/12/21.
//

#import <UIKit/UIKit.h>
#import "UIResponder+SKS.h"

static id currentFirstResponder;

@implementation UIResponder (SKS)

+ (instancetype)currentFirstResponder {
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;

}

@end