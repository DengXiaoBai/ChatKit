//
//  SKSDateJoinedPreviewView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

@class SKSChatMessageModel;

@protocol SKSDateJoinedPreviewViewDelegate <NSObject>

- (void)dateJoinedPreviewViewDownloadCoverImageWithCompletion:(void(^)(UIImage *coverImage))completion;
- (void)dateJoinedPreviewViewGetTimeRemainDescWithCompletion:(void(^)(NSString *content))completion;//获取倒计时的文案

@end

@interface SKSDateJoinedPreviewView : UIView

@property (nonatomic, weak) id<SKSDateJoinedPreviewViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getSizeWithMessageModel:(SKSChatMessageModel *)messageModel;


- (void)startTimer;
- (void)stopTimer;



@end
