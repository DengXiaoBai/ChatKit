//
//  SKSEmoticonContainerView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//

#import "SKSEmoticonContainerViewProtocol.h"

@class SKSEmoticonMeta;
@class SKSChatUserModel;
@class SKSEmoticonCatalog;
@protocol SKSChatSessionConfig;

@protocol SKSEmoticonContainerViewDelegate <NSObject>

/**
 表情按钮单击回调
 @param emotionMeta 表情的元数据
 */
- (void)emotionButtonActionWithEmotionMeta:(SKSEmoticonMeta *)emotionMeta;//单击


/**
 表情按钮长按回调
 @param emoticonMeta 表情的元数据
 @param isBegin 长安手势的状态是否开始, 否则则为长按手势结束
 */
- (void)emotionButtonLongPressActionWithEmotionMeta:(SKSEmoticonMeta *)emoticonMeta isBegin:(BOOL)isBegin;//长按


/**
 表情商城按钮回调
 */
- (void)emotionButtonTapEmoticonShopButtonAction;

/**
 * 普通 Emoji 表情中的删除按钮
 * */
- (void)emoticonDeleteButtonAction;

/**
 * Emoji 的发送按钮回调
 * */
- (void)emoticonDidTapSendAction;


@end

@interface SKSEmoticonContainerView : UIView <SKSEmoticonContainerViewProtocol>

@property (nonatomic, weak) id<SKSEmoticonContainerViewDelegate> delegate;

- (instancetype)initWithUserModel:(SKSChatUserModel *)userModel
                    sessionConfig:(id<SKSChatSessionConfig>)sessionConfig;

- (void)keyboardViewTextDidChange:(NSString *)text;//键盘文字更新

@end
