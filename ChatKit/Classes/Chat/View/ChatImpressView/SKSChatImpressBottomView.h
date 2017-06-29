//
//  SKSChatImpressBottomView.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//



@class SKSChatMessageModel;

@protocol SKSChatImpressBottomViewDelegate <NSObject>

- (void)impressBottomViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface SKSChatImpressBottomView : UIView

@property (nonatomic, weak) id<SKSChatImpressBottomViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
