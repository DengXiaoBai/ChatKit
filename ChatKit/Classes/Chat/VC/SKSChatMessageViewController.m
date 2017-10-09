//
//  SKSChatMessageViewController.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SKSChatMessageViewController.h"
#import "SKSKeyboardView.h"
#import "SKSDefaultValueMaker.h"
#import "SKSKeyboardViewActionProtocol.h"
#import "SKSChatMessageModel.h"
#import "SKSChatKeyboardConfig.h"
#import "SKSInputTextView.h"
#import "SKSButtonInputView.h"


@interface SKSChatMessageViewController () <UITableViewDelegate,
        UITableViewDataSource,
        SKSKeyboardViewDelegate,
        SKSKeyboardViewActionProtocol>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SKSKeyboardView *keyboardView;

@end

@implementation SKSChatMessageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionConfig = [[SKSDefaultValueMaker shareInstance] getDefaultSessionConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerNotification];
    [self setupNav];
    [self setupContentView];
}

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuDidHide:)
                                                 name:UIMenuControllerDidHideMenuNotification
                                               object:nil];
}

- (void)setupNav {
    self.navigationItem.title = @"好友聊天";
    
}

- (void)setupContentView {
    [self setupKeyboardView];
    [self setupTableView];
}

- (void)setupKeyboardView {
    if ([_sksDelegate respondsToSelector:@selector(didInitKeyboardView)]) {
        [_sksDelegate didInitKeyboardView];
        
    } else {
        //使用SKS的默认键盘
        if (_keyboardView == nil) {
            _keyboardView = [[SKSKeyboardView alloc] initWithSessionConfig:self.sessionConfig];
            _keyboardView.translatesAutoresizingMaskIntoConstraints = NO;
            _keyboardView.delegate = self;
            _keyboardView.actionDelegate = self;
            [self.view addSubview:_keyboardView];
            
            [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.height.mas_equalTo([[self.sessionConfig chatKeyboardConfig] chatKeyboardViewDefaultHeight]);
            }];
        }
    }
}

- (void)setupTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.userInteractionEnabled = YES;
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(0);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(_keyboardView.mas_top);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void)menuDidHide:(NSNotification *)notification {
    if (_keyboardView.inputTextView.overrideNextResponder != nil) {
        _keyboardView.inputTextView.overrideNextResponder = nil;
    }

    if (self.keyboardView.emoticonBtn.overrideNextResponder != nil) {
        _keyboardView.emoticonBtn.overrideNextResponder = nil;
    }

    if (_keyboardView.moreBtn.overrideNextResponder != nil) {
        _keyboardView.moreBtn.overrideNextResponder = nil;
    }
}

#pragma mark - Public method
- (void)tableViewScrollToBottomWithIsAnimated:(BOOL)isAnimated {
    
    NSInteger numberOfRows = [_tableView numberOfRowsInSection:0];
    if (numberOfRows <= 0) {
        return ;
    }
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:isAnimated];
}

- (void)prepareWithMessageModel:(SKSChatMessageModel *)messageModel {
    [messageModel calculateContent:[UIScreen mainScreen].bounds.size.width force:NO];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.sksDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:targetMessageModel:)]) {
        
        SKSChatMessageModel *messageModel = nil;
        if ([self.sksDelegate respondsToSelector:@selector(messageForRowAtIndexPath:)]) {
            messageModel = [_sksDataSource messageForRowAtIndexPath:indexPath];
        } else {
            NSAssert(NO, @"请实现 messageForRowAtIndexPath: delegate");
        }
        
        //具体的算高业务逻辑子类去实现
        return [_sksDelegate tableView:tableView heightForRowAtIndexPath:indexPath targetMessageModel:messageModel];
    } else {
        //使用自定义高度
        return 44.0f;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKSChatMessageModel *messageModel = [_sksDataSource messageForRowAtIndexPath:indexPath];
    
    if ([self.sksDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:targetMessageModel:)]) {
        //业务逻辑分离， 由子类来实现
        [self prepareWithMessageModel:messageModel];
        return [self.sksDataSource tableView:tableView cellForRowAtIndexPath:indexPath targetMessageModel:messageModel];
    } else {
        return nil;
    }
    
}

#pragma mark - SKSKeyboardViewDelegate
- (void)inputTextViewHeightDidChange:(SKSKeyboardView *)keyboardView {
    [_keyboardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(keyboardView.customInputViewHeight));
        make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardView.systemKeyboardViewHeight);
    }];
    
    //update tableView insets
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_keyboardView.mas_top);
    }];

    [_tableView layoutIfNeeded];
    [keyboardView layoutIfNeeded];
    
    //tableView scroll to bottom
    [self tableViewScrollToBottomWithIsAnimated:YES];
}

#pragma mark - SKSChatKeyboardViewProtocol
- (void)onTapKeyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType {

    if ([_sksDelegate respondsToSelector:@selector(onTapKeyboardMoreType:)]) {
        [_sksDelegate onTapKeyboardMoreType:keyboardMoreType];
        
    } else {
        NSAssert(NO, @"请实现 onTapKeyboardMoreType: 方法");
    }
    
}

@end
