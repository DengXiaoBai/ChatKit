//
// Created by iCrany on 2016/12/16.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageConstant.h"

@protocol SKSKeyboardMoreViewItemProtocol;

@protocol SKSChatKeyboardConfig <NSObject>

/**
 输入控件最大输入长度
 @return 输入控件最大输入长度， 返回 NSNotFound 则为无穷大
 */
- (NSInteger)maxInputLength;

/**
 * 输入控件的 Layer.borderColor 色值
 * @return 输入控件的 Layer.borderColor 色值
 */
- (UIColor *)keyboardBorderColor;

/**
 输入控件的 placeholder 字符串值
 @return 输入控件的 placeholder 字符串值
 */
- (NSString *)inputViewPlaceholder;

/**
 * 输入控件的（整个键盘的，不只是输入框的 TextView 背景） background 颜色
 *
 * */
- (UIColor *)inputViewBackgroundColor;

/**
 * 键盘被选中的背景色
 * */
- (UIColor *)inputViewSelectedBackgroundColor;

/**
 * 输入键盘 TextView 中的文字颜色
 *
 * */
- (UIColor *)inputViewTextColor;

/**
 * 输入的键盘的边框颜色
 * */
- (UIColor *)inputViewBorderColor;

/**
 * 输入键盘的光标颜色
 */
- (UIColor *)inputViewTintColor;


/**
 配置键盘中更多按钮出现的视图中的数据源
 @discussion 不同的关系可能有不同的功能开放出来
 @return 实现了 SKSKeyboardMoreViewItemProtocol 协议的对象的数组
 */
- (NSArray<id <SKSKeyboardMoreViewItemProtocol>> *)getKeyboardMoreViewItemList;

/**
 聊天中键盘的四面边距

 @return 键盘的边距
 */
- (UIEdgeInsets)chatKeyboardViewInsets;


/**
 键盘中的内容的四面边距, 既键盘光标所在的地方的四面边距

 @return 键盘内容的四面边距
 */
- (UIEdgeInsets)chatKeyboardViewTextContainerInsets;


/**
 整个键盘所在的控件的默认高度

 @return 键盘所在控件的默认高度
 */
- (CGFloat)chatKeyboardViewDefaultHeight;


/**
 键盘中输入文字控件的默认高度

 @return 键盘中输入文字控件的默认高度
 */
- (CGFloat)chatInputTextViewInKeyboardViewDefaultHeight;


/**
 键盘中输入文字控件的字体

 @return 键盘中输入文字控件的字体
 */
- (UIFont *)chatInputTextViewFont;


/**
 键盘中像表情界面以及更多按钮的高度

 @return 键盘中像表情界面以及更多按钮的高度
 */
- (CGFloat)chatKeyboardMoreViewHeight;

/**
 * 键盘中自定义 InputView 的视图高度, 为适配 iPhoneX添加的接口
 * @return 键盘中自定义 InputView 的视图高度
 */
- (CGFloat)chatKeyboardCustomInputViewHeight;

/**
 键盘中表情栏中的底部工具栏的高度

 @return 底部工具栏的高度
 */
- (CGFloat)chatKeyboardEmoticonToolViewHeight;

/**
 键盘『More』 按钮界面View的Class名称

 @return 键盘『More』 按钮界面View的Class名称
 */
- (NSString *)chatKeyboardMoreViewClassName;

/**
 * 键盘中的表情商城的图片名称
 * */
- (NSString *)chatKeyboardEmoticonShopImageName;

- (UIColor *)chatKeyboardEmoticonShopBackgroundColor;

/**
 * 是否展示表情商城按钮
 * */
- (BOOL)chatKeyboardShowEmoticonShopButton;

/**
 * 键盘中表情视图容器的 Class 名称
 * */
- (NSString *)chatKeyboardEmoticonContainerViewClassName;

/**
 * 键盘中的表情预览背景颜色
 * */
- (UIColor *)chatKeyboardEmoticonContainerViewBackgroundColor;

/**
 * 键盘中表情的按钮容器的 Class 名称
 * */
- (NSString *)chatKeyboardEmoticonButtonClassName;

/**
 * 聊天键盘中的Emoji删除按钮
 * */
- (NSString *)chatKeyboardEmoticonDeleteButtonImageName;

/**
 * 聊天键盘中的Emoji发送按钮文案
 * */
- (NSString *)chatKeyboardEmoticonSendButtonText;

/**
 * 聊天键盘中的Emoji发送按钮的背景色
 * */
- (UIColor *)chatKeyboardEmoticonSendButtonBackgroundColor;//不可点击状态背景色
- (UIColor *)chatKeyboardEmoticonSendButtonEnableBackgroundColor;//可点击状态背景色

/**
 * 聊天键盘中的Emoji发送按钮的字体
 * */
- (UIFont *)chatKeyboardEmoticonSendButtonTextFont;

- (UIColor *)chatKeyboardEmoticonSendButtonTextColor;

- (UIColor *)chatKeyboardEmoticonSendButtonEnableTextColor;//不可点击状态文字

/**
 * 聊天键盘中的表情底部的工具栏底色
 * */
- (UIColor *)chatKeyboardEmoticonToolBackgroundColor;

/**
 * 表情预览于表情工具栏之间的分割线色值
 * */
- (UIColor *)chatKeyboardEmoticonToolTopLineColor;

/**
 * 表情工具栏中的按钮被选中之后的背景颜色
 * */
- (UIColor *)chatKeyboardEmoticonToolBtnSelectedBackgroundColor;

- (UIColor *)chatKeyboardEmoticonToolBtnNormalBackgroundColor;//正常状态下的按钮背景颜色

/**
 * 表情容器视图中的点的色值
 * */
- (UIColor *)chatKeyboardEmoticonPageIndicatorTintColor;

- (UIColor *)chatKeyboardEmoticonCurrentPageIndicatorTintColor;


#pragma mark - KeyboardView More Item Config

/**
 * 键盘更多选项中的视图容器的背景颜色
 * */
- (UIColor *)chatKeyboardMoreViewBackgroundColor;

/**
 * 键盘中更多选中的中的按钮字体颜色
 * */
- (UIColor *)chatKeyboardMoreViewDescTextColor;

- (UIFont *)chatKeyboardMoreViewDescTextFont;

#pragma mark - Record voice message

/**
 * 语音按钮的文字色值
 * */
- (UIColor *)chatKeyboardHoldToTalkTextColor;

/**
 * 语音按钮被按下的背景色
 * */
- (UIColor *)chatKeyboardHoldToTalkSelectedBackgroundColor;


/**
 * 语音按钮正常的背景色
 * */
- (UIColor *)chatKeyboardHoldToTalkNormalBackgroundColor;

/**
 * 语音输入的 placeholder
 *
 * */
- (NSString *)voiceBtnHoldToTalkPlaceholder:(SKSVoiceRecordState)voiceRecordState;


/**
 * 获取不同录音状态的icon
 * */
- (NSString *)chatKeyboardRecordImageNameWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState;

/**
 * 获取不同录音状态下的底部文案
 * */
- (NSString *)chatKeyboardRecordBottomTextWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState;

/**
 * 获取录音在倒计时10秒时文字的大小
 * */
- (UIFont *)chatKeyboardRecordCountTipTextFont;

/**
 * 录音倒计时相关的临界数值
 * */
- (NSInteger)chatKeyboardRecordMaxLimitCount;

- (NSInteger)chatKeyboardRecordCountDownCriticalPoint;


@end
