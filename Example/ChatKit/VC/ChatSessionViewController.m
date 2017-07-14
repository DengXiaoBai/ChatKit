//
//  ChatSessionViewController.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "ChatSessionViewController.h"
#import <ChatKit/SKSDefaultValueMaker.h>
#import <ChatKit/SKSMessageCell.h>
#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSDefaultCellMaker.h>
#import <ChatKit/UIResponder+SKS.h>
#import <ChatKit/SKSChatRecordView.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSKeyboardView.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSVoiceMessageObject.h>
#import <Masonry/Masonry.h>
#import "ChatTestViewModel.h"
#import "ChatSessionHelper.h"

@interface ChatSessionViewController () <SKSChatMessageViewControllerDelegate,
        SKSChatMessageViewControllerDataSource,
        SKSMessageCellDelegate,
        SKSChatRecordViewDelegate>

@property (nonatomic, strong) ChatTestViewModel *viewModel;

@property (nonatomic, strong) SKSChatRecordView *chatRecordView;

@end

@implementation ChatSessionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _viewModel = [[ChatTestViewModel alloc] init];
        _viewModel.sessionConfig = [[SKSDefaultValueMaker shareInstance] getDefaultSessionConfig];
        self.sessionConfig = [[SKSDefaultValueMaker shareInstance] getDefaultSessionConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.sksDelegate = self;
    self.sksDataSource = self;

    self.view.backgroundColor = RGB(249, 249, 249);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];

//    [self.keyboardView disableKeyboardView:YES];//Disable the keyboard view
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - SKSChatMessageViewControllerDelegate 
- (void)onTapKeyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType {
    switch (keyboardMoreType) {
        case SKSKeyboardMoreTypeAlumbs:{

            break;
        }
        case SKSKeyboardMoreTypeTakePhoto:{

            break;
        }
        case SKSKeyboardMoreTypeLocation: {

            break;
        }
        case SKSKeyboardMoreTypeRealTimeVoice: {
            //TODO: 实时语音呼叫
            
            break;
        }
        case SKSKeyboardMoreTypeRealTimeVideo: {
            //TODO: 实时视频呼叫
            
            break;
        }
        default: {
            NSAssert(NO, @"未识别的 SKSKeyboardMoreType 类型");
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath targetMessageModel:(SKSChatMessageModel *)messageModel {
    
    CGFloat cellHeight = 0;
    if ([messageModel isKindOfClass:[SKSChatMessageModel class]]) {
        
        SKSChatMessageModel *model = _viewModel.messageList[indexPath.row];

        [self prepareWithMessageModel:model];
        
        CGSize contentSize = model.contentViewSize;
        UIEdgeInsets contentViewInsets = model.contentViewInsets;
        UIEdgeInsets bubbleViewInsets = model.bubbleViewInsets;
        
        cellHeight = bubbleViewInsets.top + contentViewInsets.top + contentSize.height + contentViewInsets.bottom + bubbleViewInsets.bottom;
        
    } else {
        NSAssert(NO, @"不支持的 messageModel 类型");
    }
    
    return cellHeight;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SKSChatMessageModel *messageModel = self.viewModel.messageList[indexPath.row];
    DLog(@"[tableView:willDisplayCell:forRowAtIndexPath:] messageId: %lld", messageModel.message.messageId);
}

#pragma mark - SKSChatMessageViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.messageList.count;
}

- (SKSChatMessageModel *)messageForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _viewModel.messageList[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath targetMessageModel:(SKSChatMessageModel *)messageModel {
    UITableViewCell *cell = nil;
    if ([messageModel isKindOfClass:[SKSChatMessageModel class]]) {

        [self prepareWithMessageModel:messageModel];
        
        cell = (UITableViewCell *)[SKSDefaultCellMaker getCellWithTableView:tableView targetMessageModel:messageModel];
        
        if ([cell isKindOfClass:[SKSMessageCell class]]) {
            [(SKSMessageCell *)cell updateUIWithMessageModel:messageModel];
            [(SKSMessageCell *)cell setDelegate:self];
        }
    } else {
        NSAssert(NO, @"不支持的 messageModel 类型");
    }
    return cell;
}

#pragma mark - SKSMessageCellDelegate
- (void)messageCellDidTapAvatarBtnAction:(SKSChatMessageModel *)messageModel {
    
}

- (void)messageCellDidTapFailBtnAction:(SKSChatMessageModel *)messageModel {
    
}

- (void)messageCellDidLongPressAction:(SKSChatMessageModel *)messageModel inView: (UIView *)inView {

}

- (void)messageCellDidTapAction:(SKSChatMessageModel *)messageModel cell:(SKSMessageCell *)cell {
    DLog(@"messageCellDidTapAction:cell: method");
    switch (messageModel.message.messageMediaType) {
        case SKSMessageMediaTypeVoice: {
            SKSVoiceMessageObject *messageObject = messageModel.message.messageAdditionalObject;
            messageObject.isFirstTimePlay = NO;
            messageObject.voicePlayState = SKSVoicePlayStateStartPlay;
            [cell updateUIStateState:messageModel];
            break;
        }
        default: {
            break;
        }
    }
}


- (void)messageCellDidTapMenuItemWithMessageModel:(SKSChatMessageModel *)messageModel menuItemType:(SKSMessageMenuSelectType)menuItemType {

}

- (void)messageCellDidTapFunctionAction:(SKSChatMessageModel *)messageModel messageFunctionType:(SKSMessageFunctionType)messageFunctionType entity:(id)entity {
    DLog(@"messageFunctionType: %ld, entity: %@", (long)messageFunctionType, entity);
}

- (void)messageCellDidCustomTapAction:(SKSChatMessageModel *)messageModel buttonIndex:(NSInteger)buttonIndex {
    DLog(@"messageCellDidCustomTapAction, buttonIndex: %ld", (long)buttonIndex);
}

- (void)messageCellDidTapCoreTextLinkAction:(SKSChatMessageModel *)messageModel url:(NSURL *)url {
    DLog(@"messageCellDidTapCoreTextLinkAction:url: %@", url);
}

- (void)messageCellDidLongPressCoreTextLinkAction:(SKSChatMessageModel *)messageModel url:(NSURL *)url {
    DLog(@"messageCellDidLongPressCoreTextLinkAction:url: %@", url);
}

#pragma mark - SKSChatKeyboardViewProtocol
- (void)onSendText:(NSString *)text {
    DLog(@"发送文字消息");
}

- (void)onInputTextViewTextDidChange:(NSString *)text {
    DLog(@"发送Typing消息");
}

- (void)onSendEmoticon:(NSDictionary *)emoticonMetaDict {
    DLog(@"发送表情");
}

- (void)onOpenEmoticonShop {
    DLog(@"打开表情商城");
}

- (void)onPreviewEmoticon:(id)emoticonToolView emoticonMetaDict:(NSDictionary *)emoticonMetaDict {
    DLog(@"表情预览功能");
}

- (void)onStartRecording {
    DLog(@"onStartRecording method");
    if (!_chatRecordView) {
        _chatRecordView = [[SKSChatRecordView alloc] initWithKeyboardConfig:[self.viewModel.sessionConfig chatKeyboardConfig]];
        _chatRecordView.delegate = self;
        [_chatRecordView showChatRecordView];

        //For: test
        [self.keyboardView didRTCStartRecording];
    } else {
        DLog(@"[Fail]: onStartRecording , chatRecordView should be nil");
        [_chatRecordView showChatRecordView];

        //For: test
        [self.keyboardView didRTCStartRecording];
    }
}

- (void)onStopRecording {
    if (_chatRecordView) {
        [_chatRecordView clearResource];
        [_chatRecordView dismissChatRecordView];
        [_chatRecordView removeFromSuperview];
        _chatRecordView = nil;
    }
}

- (void)onCancelRecording {
    DLog(@"onCancelRecording method");
    if (_chatRecordView) {
        [_chatRecordView clearResource];
        [_chatRecordView dismissChatRecordView];
        [_chatRecordView removeFromSuperview];
        _chatRecordView = nil;
    }
}

- (void)onRecordingProgressWithRecordVoiceState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown {

    if (_chatRecordView) {
        DLog(@"chatRecordView exit");
        [_chatRecordView updateUIWithRecordState:voiceRecordState countDown:countDown];
    } else {
        switch (voiceRecordState) {
            case SKSVoiceRecordStateTooShort: {
                DLog(@"too short method");
                if (!_chatRecordView) {
                    _chatRecordView = [[SKSChatRecordView alloc] initWithKeyboardConfig:[self.viewModel.sessionConfig chatKeyboardConfig]];
                    _chatRecordView.delegate = self;
                    [_chatRecordView showChatRecordView];
                }
                [_chatRecordView updateUIWithRecordState:voiceRecordState countDown:countDown];
                break;
            }
            default: {
                break;
            }
        }
    }
}

#pragma mark - SKSChatRecordViewDelegate
- (void)chatRecordViewDidDismiss {
    [_chatRecordView clearResource];
    _chatRecordView = nil;
}

#pragma mark - SKSKeyboardViewDelegate
- (void)inputTextViewDidChange:(NSString *)text {
    DLog(@"[inputTextViewDidChange] text: %@", text);
}

@end
