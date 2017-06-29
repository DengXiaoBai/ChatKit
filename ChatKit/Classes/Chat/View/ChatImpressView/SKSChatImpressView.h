//
//  SKSChatImpressView.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//



@class SKSChatMessageModel;

@protocol SKSChatImpressViewDelegate <NSObject>

- (void)chatImpressViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface SKSChatImpressView : UIView

@property (nonatomic, weak) id<SKSChatImpressViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
