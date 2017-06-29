//
//  SKSChatRecordingOutsideView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//

@protocol SKSChatKeyboardConfig;

@interface SKSChatRecordingOutsideView : UIView

- (instancetype)initWithFrame:(CGRect)frame keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

+ (CGSize)getViewSizeWithKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

@end
