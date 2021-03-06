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
#import <ChatKit/SKSChatRecordView.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSKeyboardView.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSVoiceMessageObject.h>
#import <Masonry/Masonry.h>
#import <ChatKit/SKSChatKeyboardConfig.h>
#import "ChatTestViewModel.h"
#import "MarcosDefinition.h"
#import "ChatKit_Example-Swift.h"

@interface ChatSessionViewController () <SKSChatMessageViewControllerDelegate,
        SKSChatMessageViewControllerDataSource,
        SKSMessageCellDelegate,
        SKSChatRecordViewDelegate>

@property (nonatomic, strong) ChatTestViewModel *viewModel;

@property (nonatomic, strong) SKSChatRecordView *chatRecordView;
@property (nonatomic, assign) BOOL isKeyboardShowing;

@end

@implementation ChatSessionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _viewModel = [[ChatTestViewModel alloc] init];
        _viewModel.sessionConfig = [[SKSDefaultValueMaker shareInstance] getDefaultSessionConfig];
        self.sessionConfig = [[SKSDefaultValueMaker shareInstance] getDefaultSessionConfig];
        [self registerNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.sksDelegate = self;
    self.sksDataSource = self;

    self.view.backgroundColor = RGB(249, 249, 249);
    [self updateTableView];
    [self updateKeyboardView];
    [self registerNotification];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)updateTableView {

    /// 防止iOS11自动启用Self-Sizing
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

    /// 防止iOS11自动调整contentInset
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset([ConstantUtils getStatusBarAndNavBarHeightTotalHeight]);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.keyboardView.mas_top);
    }];
}

- (void)updateKeyboardView {
    if (@available(iOS 11.0, *)) {
        if (IS_IPHONE_X) {
            [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                make.left.right.equalTo(self.view);
                make.height.mas_equalTo([[self.sessionConfig chatKeyboardConfig] chatKeyboardViewDefaultHeight]);
            }];
        }
    }
}


#pragma mark - Notification
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    DLog(@"keyboardWillShowNotification");
    self.isKeyboardShowing = YES;
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    DLog(@"keyboardWillHideNotification");
    self.isKeyboardShowing = NO;
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
            
            break;
        }
        case SKSKeyboardMoreTypeRealTimeVideo: {
            
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
- (void)inputTextViewHeightDidChange:(NSString *)text {

    DLog(@"inputTextViewHeightDidChange...isKeyboardShowing: %d", self.isKeyboardShowing);
    [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(self.keyboardView.customInputViewHeight));
        if (@available(iOS 11.0, *)) {
            if (IS_IPHONE_X) {
                if (!self.isKeyboardShowing) {
                    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-self.keyboardView.systemKeyboardViewHeight);
                } else {
                    make.bottom.equalTo(self.view.mas_bottom).offset(-self.keyboardView.systemKeyboardViewHeight);
                }

            } else {
                make.bottom.equalTo(self.view.mas_bottom).offset(-self.keyboardView.systemKeyboardViewHeight);
            }
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-self.keyboardView.systemKeyboardViewHeight);
        }
    }];

    //update tableView insets
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset([ConstantUtils getStatusBarAndNavBarHeightTotalHeight]);
        make.bottom.equalTo(self.keyboardView.mas_top);
    }];

    [self.tableView layoutIfNeeded];
    [self.keyboardView layoutIfNeeded];

    //tableView scroll to bottom
    [self tableViewScrollToBottomWithIsAnimated:YES];
}

- (void)inputTextViewDidChange:(NSString *)text {
    DLog(@"[inputTextViewDidChange] text: %@", text);
}

@end
