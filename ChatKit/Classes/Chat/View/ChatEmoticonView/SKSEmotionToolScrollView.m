//
//  EmotionToolScrollView.m
//  AtFirstSight
//
//  Created by iCrany on 15/12/24.
//  Copyright (c) 2015 Sachsen. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "SKSEmotionToolScrollView.h"
#import "SKSChatMessageConstant.h"
#import "SKSEmoticonCatalog.h"
#import "SKSKeyboardEmoticonLayoutConfig.h"
#import "UIColor+SKS.h"
#import "SKSChatKeyboardConfig.h"


@interface SKSEmotionToolScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) NSArray<SKSEmoticonCatalog *> *emoticonCatalogList;//SKSEmoticonCatalog 数组
@property (nonatomic, strong) UIScrollView *toolContentScrollView;

@property (nonatomic, strong) NSMutableArray *toolButtonList;
@property (nonatomic, strong) UIButton *preSelectedButton;//上一个被选中的button

@property (nonatomic, strong) UIButton *sendBtn;//Emoji 的发送按钮

@end

@implementation SKSEmotionToolScrollView

- (instancetype)initWithDataSourceList:(NSArray<SKSEmoticonCatalog *> *)emoticonCatalogList
                        keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    self = [super init];
    if (self) {
        _keyboardConfig = keyboardConfig;
        _viewHeight = _keyboardConfig.chatKeyboardEmoticonToolViewHeight;
        _emoticonCatalogList = emoticonCatalogList;
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    NSInteger count = _emoticonCatalogList.count;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    _toolContentScrollView = [[UIScrollView alloc] init];
    _toolContentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _toolContentScrollView.delegate = self;
    _toolContentScrollView.showsVerticalScrollIndicator = NO;
    _toolContentScrollView.showsHorizontalScrollIndicator = NO;
    _toolContentScrollView.backgroundColor = _keyboardConfig.chatKeyboardEmoticonToolBackgroundColor;
    _toolContentScrollView.contentSize = CGSizeMake(_viewHeight * count , _viewHeight);
    [self addSubview:_toolContentScrollView];
    [_toolContentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self setupTopLine];

    //设置按钮的 frame 位置
    _toolButtonList = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0 ; i < count ; i++) {
        SKSEmoticonCatalog *emoticonCatalog = [_emoticonCatalogList objectAtIndex:i];
        UIButton *toolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        toolButton.frame = CGRectMake((i * _viewHeight), 0.5, _viewHeight, _viewHeight);
        [toolButton addTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (emoticonCatalog.emoticonLayoutConfig.isEmoji) {
            [toolButton setTitle:emoticonCatalog.previewImage forState:UIControlStateNormal];
        }
        toolButton.tag = i;

        [_toolButtonList addObject:toolButton];
        [_toolContentScrollView addSubview:toolButton];
    }

    [self setupSendBtn];
}

- (void)setupSendBtn {
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat sendBtnWidth = 66;
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:_keyboardConfig.chatKeyboardEmoticonSendButtonText forState:UIControlStateNormal];
    [_sendBtn setTitleColor:_keyboardConfig.chatKeyboardEmoticonSendButtonTextColor forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _sendBtn.titleLabel.font = _keyboardConfig.chatKeyboardEmoticonSendButtonTextFont;
    _sendBtn.backgroundColor = _keyboardConfig.chatKeyboardEmoticonSendButtonBackgroundColor;
    _sendBtn.layer.shadowOffset = CGSizeMake(-1, 1);
    _sendBtn.layer.shadowColor = [RGBA(0, 0, 0, 0.5) CGColor];
    _sendBtn.layer.shadowRadius = 3;
    _sendBtn.layer.shadowOpacity = 0.5;

    [self addSubview:_sendBtn];

    _sendBtn.frame = CGRectMake(screen_width - sendBtnWidth, 0.5, sendBtnWidth, _viewHeight);
}

- (void)setupTopLine {
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = _keyboardConfig.chatKeyboardEmoticonToolTopLineColor;
    [_toolContentScrollView addSubview:_topLine];
    _topLine.frame = CGRectMake(0, 0, screen_width, 0.5);
}

#pragma mark - Event Response
- (void)toolButtonAction:(UIButton *)sender {
    //检测 toolButtonList 中的选中状态, 重置它
    if (sender.selected == NO) {
        _preSelectedButton.backgroundColor = [UIColor clearColor];
        sender.backgroundColor = _keyboardConfig.chatKeyboardEmoticonToolBtnNormalBackgroundColor;
        _preSelectedButton.selected = NO;
        sender.selected = !sender.selected;
        _preSelectedButton = sender;

        if ([self.delegate respondsToSelector:@selector(emotionToolScrollViewDidSelectButtonAtIndex:)]) {
            [self.delegate emotionToolScrollViewDidSelectButtonAtIndex:sender.tag];
        }
    }
}

- (void)sendBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(emoticonToolScrollViewDidSendAction)]) {
        [self.delegate emoticonToolScrollViewDidSendAction];
    }
}

#pragma mark - Public method
- (void)setSelectIndex:(NSInteger)selectIndex {
    if (selectIndex >= _toolButtonList.count) {
        return;
    }
    UIButton *selectButton = [_toolButtonList objectAtIndex:selectIndex];
    _preSelectedButton.backgroundColor = [UIColor clearColor];
    selectButton.backgroundColor = _keyboardConfig.chatKeyboardEmoticonToolBtnSelectedBackgroundColor;
    _preSelectedButton.selected = NO;
    selectButton.selected = YES;
    _preSelectedButton = selectButton;

}

- (void)setSelectIndex:(NSInteger)selectIndex isScrollToPosition:(BOOL)isScrollToPosition {
    [self setSelectIndex:selectIndex];
    if (isScrollToPosition && selectIndex < _toolButtonList.count) {
        CGRect rect = CGRectMake((selectIndex * _viewHeight), 0, _viewHeight, _viewHeight);
        [_toolContentScrollView scrollRectToVisible:rect animated:NO];
    }
}

- (void)emoticonToolSendBtnState:(SKSKeyboardEmoticonSendButtonState)buttonState {
    switch (buttonState) {
        case SKSKeyboardEmoticonSendButtonStateDisableShow: {
            _sendBtn.backgroundColor = _keyboardConfig.chatKeyboardEmoticonSendButtonBackgroundColor;
            [_sendBtn setTitleColor:_keyboardConfig.chatKeyboardEmoticonSendButtonTextColor forState:UIControlStateNormal];
            _sendBtn.enabled = NO;
            break;
        }
        case SKSKeyboardEmtocionSendButtonStateEnableShow: {
            _sendBtn.backgroundColor = _keyboardConfig.chatKeyboardEmoticonSendButtonEnableBackgroundColor;
            [_sendBtn setTitleColor:_keyboardConfig.chatKeyboardEmoticonSendButtonEnableTextColor forState:UIControlStateNormal];
            _sendBtn.enabled = YES;
            break;
        }
        default: {

            break;
        }
    }
}

@end
