//
//  ChatImpressView.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

@class SKSChatMessageModel;

@protocol ChatImpressViewDelegate <NSObject>

- (void)chatImpressViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface ChatImpressView : UIView

@property (nonatomic, weak) id<ChatImpressViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
