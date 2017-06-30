//
//  ChatDateJoinedPreviewView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

@class SKSChatMessageModel;

@protocol ChatDateJoinedPreviewViewDelegate <NSObject>

- (void)dateJoinedPreviewViewDownloadCoverImageWithCompletion:(void(^)(UIImage *coverImage))completion;
- (void)dateJoinedPreviewViewGetTimeRemainDescWithCompletion:(void(^)(NSString *content))completion;//获取倒计时的文案

@end

@interface ChatDateJoinedPreviewView : UIView

@property (nonatomic, weak) id<ChatDateJoinedPreviewViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getSizeWithMessageModel:(SKSChatMessageModel *)messageModel;


- (void)startTimer;
- (void)stopTimer;



@end
