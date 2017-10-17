//
//  SKSChatMessageConstant.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#ifndef SKSChatMessageConstant_h
#define SKSChatMessageConstant_h

#ifdef DEBUG

#define DLog(xx, ...) NSLog(@"%@ %s %d: " xx, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __func__, __LINE__, ##__VA_ARGS__)

#else

#define DLog(xx, ...)

#endif

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define SKS_IS_IPHONE_X (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)812.0f) < DBL_EPSILON)//判断是否是iPhone_X

/**
 自定义消息类型
 */
typedef NS_ENUM(NSInteger, SKSMessageMediaType) {
    SKSMessageMediaTypeUnsupport                    = -1,//不支持的类型, 不存储到数据库中!
    SKSMessageMediaTypeText                         = 0,//文本
    SKSMessageMediaTypePhoto                        = 1,//图片
    SKSMessageMediaTypeVideo                        = 2,//离线视频
    SKSMessageMediaTypeVoice                        = 3,//离线语音
    SKSMessageMediaTypeEmoticon                     = 4,//表情
    SKSMessageMediaTypeLocation                     = 5,//地理位置
    SKSMessageMediaTypeYO                           = 6,//Yo
    SKSMessageMediaTypeRealTimeVoice                = 7,//实时语音
    SKSMessageMediaTypeRealTimeVideo                = 8,//实时视频
    SKSMessageMediaTypeTyping                       = 9,//正在输入提示
    SKSMessageMediaTypeTipLabel                     = 10,//纯文本描述显示栏
    SKSMessageMediaTypeCoreText                     = 11,//富文本显示
    SKSMessageMediaTypeUserGuideInAdministrator     = 12,//管理员聊天中的教程类型
    SKSMessageMediaTypeDataCall                     = 13,//活动的约会视频
    SKSMessageMediaTypeDateOffer                    = 14,//活动邀约
    SKSMessageMediaTypeDateJoinedPreview            = 15,//参与的约会的预览
    SKSMessageMediaTypeConfirmMeet                  = 16,//系统询问是否约会成功
    SKSMessageMediaTypeImpress                      = 17,//系统印象评价
    SKSMessageMediaTypeUnReadTip                    = 18,//聊天消息中的未读消息Tip
    SKSMessageMediaTypePrivacyActivity              = 19,//私人邀约
    SKSMessageMediaTypePrivacyGiftOffer             = 20,//私人送玫瑰的请求
};


/**
 消息当前发送状态
 */
typedef NS_ENUM(NSInteger, SKSMessageDeliveryState) {
    SKSMessageDeliveryStateSent         = 0,//发送成功，但未收到已送达消息
    SKSMessageDeliveryStateDelivered    = 1,//已送达
    SKSMessageDeliveryStateRead         = 2,//对方已读
    SKSMessageDeliveryStateDelivering   = 3,//正在发送中
    SKSMessageDeliveryStateFail         = 4,//发送失败

};


/**
 消息来源
 */
typedef NS_ENUM(NSInteger, SKSMessageSourceType) {
    SKSMessageSourceTypeSend            = 0,//发送
    SKSMessageSourceTypeReceive         = 1,//接受
    SKSMessageSourceTypeCenter          = 2,//居中显示,没有发送方，接受方的概念
    SKSMessageSourceTypeSendCenter      = 3,//发送方的居中显示
    SKSMessageSourceTypeReceiveCenter   = 4,//接收方的居中显示
};


/**
 语音视频呼叫的状态
 */
typedef NS_ENUM(NSInteger, SKSMessageCallState) {
    SKSMessageCallStateNoResponse       = 0,//对方无应答
    SKSMessageCallStateCancel           = 1,//呼叫方取消
    SKSMessageCallStateReject           = 2,//对方拒绝
    SKSMessageCallStateAccept           = 3,//对方接受
    SKSMessageCallStateFail             = 4,//连接失败
    SKSMessageCallStateBusy             = 5,//对方正忙
    SKSMessageCallStateReconnectFail    = 6,//重新连接失败
};



/**
 语音短消息格式类型
 */
typedef NS_ENUM(NSInteger, SKSVoiceMessageFormat) {
    SKSVoiceMessageFormat_ISAC          = 0,//
};


/**
 语音消息中的录音状态
 */
typedef NS_ENUM(NSInteger, SKSVoiceRecordState) {
    SKSVoiceRecordStateStart                    = 0,//录音开始
    SKSVoiceRecordStateRecordingInSide          = 1,//正在录音并且在录音按钮里面
    SKSVoiceRecordStateRecordingOutside         = 2,//正在录音并且在录音按钮外面
    SKSVoiceRecordStateCanceled                 = 3,//录音取消
    SKSVoiceRecordStateEnd                      = 4,//录音结束
    SKSVoiceRecordStateOverLimit                = 5,//录音时长超过限制
    SKSVoiceRecordStateTooShort                 = 6,//录音时长太短
    SKSVoiceRecordStateCountDownStateInside     = 7,//录音处于倒计时的状态,并且在录音按钮里面
    SKSVoiceRecordStateCountDownStateOutside    = 8,//录音处于倒计时的状态,并且在录音按钮的外面
};

/**
 * 语音短消息中的播放状态
 * */
typedef NS_ENUM(NSInteger, SKSVoicePlayState) {
    SKSVoicePlayStateNormal                 = 0,//播放开始的原始状态
    SKSVoicePlayStatePlaying                = 1,//播放中的状态
    SKSVoicePlayStatePause                  = 2,//播放暂停
    SKSVoicePlayStateStop                   = 3,//播放完毕
    SKSVoicePlayStateStartPlay              = 4,//从播放完毕或初始化状态开始播放
    SKSVoicePlayStateStartPlayFromPause     = 5,//从暂停状态开始继续播放
};

/**
 聊天键盘中更多按钮的类型
 */
typedef NS_ENUM(NSInteger, SKSKeyboardMoreType) {
    SKSKeyboardMoreTypeAlumbs           = 0,//相册
    SKSKeyboardMoreTypeTakePhoto        = 1,//照相
    SKSKeyboardMoreTypeLocation         = 2,//地理位置
    SKSKeyboardMoreTypeRealTimeVoice    = 3,//实时语音
    SKSKeyboardMoreTypeRealTimeVideo    = 4,//实时视频
    SKKKeyboardMoreTypeMedia            = 5,//媒体功能，包含实时视频+实时语音消息
};

/**
 发送及接受消息的两者之间的关系
 */
typedef NS_ENUM(NSInteger, SKSChatRelationshipType) {
    SKSChatRelationshipTypeNoLimit      = -1,//不限
    SKSChatRelationshipTypeStranger     = 0,//陌生人
    SKSChatRelationshipTypeFriend       = 1,//好友
    SKSChatRelationshipTypeAdmin        = 2,//管理员
};

/**
 用户性别
 */
typedef NS_ENUM(NSInteger, SKSChatGender) {
    SKSChatGenderUnSet  = 0,
    SKSChatGenderFemale = 1,
    SKSChatGenderMale   = 2,
};

/**
 * 约会状态
 */
typedef NS_ENUM(NSInteger, SKSActivityState) {
    SKSActivityState_UNKNOWN = 0,
    SKSActivityState_PUBLISHED = 1,
    SKSActivityState_EXPIRED = 2,
    SKSActivityState_DELETED = 3,
    SKSActivityState_PULLED = 4,
    SKSActivityState_CLOSED = 5,
    SKSActivityState_SILENTLY_PULLED = 6,
    SKSActivityState_MET = 7
};

/**
 * 键盘中表情按钮的分类
 * */
typedef NS_ENUM(NSInteger, SKSEmoticonMetaType) {
    SKSEmoticonMetaTypeEmoticonButton               = 0,//普通的表情
    SKSEmoticonMetaTypeEmojiButton                  = 1,//字符串表情
    SKSEmoticonMetaTypeEmojiCatalogPreviewButton    = 2,//表情的工具栏预览图
};

/**
 *  用户长按聊天 Cell 弹出的 Menu 类型
 */
typedef NS_ENUM(NSInteger, SKSMessageMenuSelectType) {
    SKSMessageMenuSelectTypeTextCopy                = 0,//复制
    SKSMessageMenuSelectTypeDelete                  = 1,//删除
    SKSMessageMenuSelectTypeSpeakerVoiceMessage     = 2,//扬声器模式
    SKSMessageMenuSelectTypeEarpieceMessage         = 3,//听筒模式
};

/**
 * 聊天中的功能分类
 * */
typedef NS_ENUM(NSInteger, SKSMessageFunctionType) {
    SKSMessageFunctionTypeNotKnow               = 0,//未知
    SKSMessageFunctionTypeSendMessage           = 1,//发送短信功能
    SKSMessageFunctionTypePhone                 = 2,//号码拨打功能
    SKSMessageFunctionTypeAddNewContact         = 3,//创建新的联系人功能
    SKSMessageFunctionTypeEditContact           = 4,//编辑已存在的联系人功能
    SKSMessageFunctionTypeUrl                   = 5,//打开超链接
};

/**
 * 评价状态
 * */
typedef NS_ENUM(NSInteger, SKSImpressStatus) {
    SKSImpressStatusNotProgress = 0,//未操作
    SKSImpressStatusSuccess     = 1,//评价成功
    SKSImpressStatusInvalid     = 2,//评价失效
};


/**
 * 键盘的表情控件中的发送按钮状态
 * */
typedef NS_ENUM(NSInteger, SKSKeyboardEmoticonSendButtonState) {
    SKSKeyboardEmtocionSendButtonStateEnableShow        = 0,
    SKSKeyboardEmoticonSendButtonStateEnabelHide        = 1,
    SKSKeyboardEmoticonSendButtonStateDisableShow       = 2,
    SKSKeyboardEmtocionSendButtonStateDisableHide       = 3
};




/**
 * 键盘控件的当前状态
 */
typedef NS_ENUM(NSInteger, SKSKeyboardState) {
    SKSKeyboardStateDisable                = 0,//键盘不可点击
    SKSKeyboardStateEnable                 = 1,//键盘可点击
};

#endif /* SKSChatMessageConstant_h */
