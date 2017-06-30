//
//  ChatDateOfferTopView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



@class SKSChatMessageModel;

@interface ChatDateOfferTopView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 更新 UI
 * */
- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

//get the view size
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
