//
// Created by iCrany on 2016/12/16.
//

#import <Foundation/Foundation.h>

@protocol SKSKeyboardMoreViewItemProtocol;
@protocol SKSChatKeyboardConfig;

@protocol SKSKeyboardMoreViewActionDelegate <NSObject>

- (void)SKSKeyboardMoreItemButtonViewDidTapWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>) itemModel;

@end

@protocol SKSKeyboardMoreViewProtocol <NSObject>

@property (nonatomic, weak) id<SKSKeyboardMoreViewActionDelegate> actionDelegate;

- (instancetype)initWithItemList:(NSArray *)keyboardMoreItemList keyboarConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

- (void)updateKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

@end