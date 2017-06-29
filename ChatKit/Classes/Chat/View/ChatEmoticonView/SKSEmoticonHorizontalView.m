////
////  EmoticonHorizontalView.m
////  AtFirstSight
////
////  Created by iCrany on 16/1/22.
////  Copyright (c) 2016 Sachsen. All rights reserved.
////
//
//#import <Masonry/View+MASAdditions.h>
//#import <Masonry/MASConstraintMaker.h>
//#import "SKSEmoticonHorizontalView.h"
//#import "SKSEmotionToolScrollView.h"
//#import "SKSEmoticonButton.h"
//#import "SKSChatCellConfig.h"
//#import "SKSDefaultValueMaker.h"
//#import "SKSChatMessageConstant.h"
//#import "UIImage+SKS.h"
//#import "SKSChatKeyboardConfig.h"
//
//static CGFloat kEmotionBtnWidth        = 55.0f;
//static CGFloat kEmotionBtnHeight       = 55.0f;
//static CGFloat kEmotionGapY            = 6.0f;
//
//static int32_t kEmotionCountInOneLineH  = 4;//水平一行放4个
//static int32_t kEmotionCountInOneLineV  = 3;//垂直一列放3个
//
//static CGFloat kEmotionPackageControlHeight    = 44.0f;
//static CGFloat kLineGapPadding                 = 5.0f;
//
//#define kEmotionScrollViewHeight (MORE_VIEW_HEIGHT - kEmotionPackageControlHeight)
//
//static const CGFloat SendEmoticonLimitInSeconds = 0.6;
//static const CGFloat SendEmoticonLimitInMil     = SendEmoticonLimitInSeconds * 1000 * 1000;
//
//@interface SKSEmoticonHorizontalView()<UIScrollViewDelegate, SKSEmotionToolScrollViewDelegate>
//
//@property (nonatomic, strong) UIScrollView *emotionScrollView;
//@property (nonatomic, strong) UIPageControl *emotionPageControl;
//@property (nonatomic, strong) SKSEmotionToolScrollView *emotionToolScrollView;
//@property (nonatomic, strong) UIButton *emoticonShopButton;
//
//@property (nonatomic, strong) NSArray *emotionList;
//@property (nonatomic, strong) NSMutableArray *eachEmoticonPackageOccupyPageList;//每一个表情包占用的水平页数
//@property (nonatomic, strong) NSMutableArray *eachEmoticonPackageXOffsetList;//每一套表情的 x 的偏移值
//@property (nonatomic, strong) NSMutableArray *everyPackageFirstEmotionPreviewImageList;
//
////管理员相关
//@property (nonatomic, assign) BOOL isAdmin;
////@property (nonatomic, strong) AFSPopTipView *popTipView;
////@property (nonatomic, strong) AFSPopTipView *showCanLongPressPreviewTip;
//
////限制发送表情的频率
//@property (nonatomic, assign) int64_t lastSendEmoticonTimestamp;
//
////for emoticon button
//@property (nonatomic, strong) SKSEmoticonButton *currentAnimationEmoticonButton;//当前长按预览的按钮对象
//
//@end
//
//@implementation SKSEmoticonHorizontalView
//
//- (instancetype)initWithEmotionList:(NSArray *)emotionList isAdmin:(BOOL)isAdmin {
//    self = [super init];
//    if (self) {
//        _isAdmin = isAdmin;
//        _emotionList = emotionList;
//        [self setupContentView];
//        [self setupNotification];
//    }
//    return self;
//}
//
//- (void)setupNotification {
//    //TODO: 表情管理更新的通知
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadEmoticons) name:kEMOTICON_UPDATED_NOTIFICATION object:nil];
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    _emotionScrollView.delegate = nil;
//}
//
//- (void)setupContentView {
//    self.backgroundColor = [UIColor whiteColor];
//    [self setupEmotionScrollView];
//    [self setupEmotionButtons];
//    [self resetPageControlWithSelectIndex:0 currentPage:0];
//    [self setupEmotionToolScrollView];
//}
//
//- (void)setupEmotionScrollView {
//    _emotionScrollView = [[UIScrollView alloc] init];
//    _emotionScrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    _emotionScrollView.delegate = self;
//    _emotionScrollView.pagingEnabled = YES;
//    _emotionScrollView.showsHorizontalScrollIndicator = NO;
//    _emotionScrollView.showsVerticalScrollIndicator = NO;
//    _emotionScrollView.backgroundColor = [UIColor clearColor];
//    //这里的计算方法需要进行改变, 因为是水平放置的
//    _eachEmoticonPackageOccupyPageList = [[NSMutableArray alloc] init];
//    int32_t numberOfPageInHorizontal = 0;//水平方向一共有多少页
//    int32_t numberOfEmoticonInOnePage = kEmotionCountInOneLineV * kEmotionCountInOneLineH;
//    for (NSDictionary *packageDict in _emotionList) {
//        //TODO: set the kEMOTION_PACKAGE_IMAGES
////        NSArray *emotionPreviewImageList = [packageDict objectForKey:kEMOTION_PACKAGE_IMAGES];
//        NSArray *emotionPreviewImageList = [[NSArray alloc] init];
//        int32_t packageEmotionCount = (int32_t) emotionPreviewImageList.count;
//        //计算这套表情一共需要占用水平方向多少页
//        int32_t numberOfPageInThisPackage = (packageEmotionCount / numberOfEmoticonInOnePage) + (packageEmotionCount % numberOfEmoticonInOnePage == 0 ? 0 : 1);
//        [_eachEmoticonPackageOccupyPageList addObject:@(numberOfPageInThisPackage)];
//        numberOfPageInHorizontal += numberOfPageInThisPackage;
//    }
//    _emotionScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * numberOfPageInHorizontal, [[[SKSDefaultValueMaker shareInstance] getDefaultKeyboardConfig] chatKeyboardMoreViewHeight]);
//    [self addSubview:_emotionScrollView];
//    [_emotionScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//}
//
//- (void)setupEmotionButtons {
//
//    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
//    CGFloat EmotionGapX = (screen_width - kEmotionCountInOneLineH * kEmotionBtnWidth) / (kEmotionCountInOneLineH + 1);//水平间距
//    UIScrollView *packageEmotionView;
//    NSArray *emotionPreviewImageList;
//    NSDictionary *emotionDict;//单个 emotion 的资料
//    SKSEmoticonButton *emotionButton;
//
//    int pageNumber = 0;
//    int32_t numberOfEmoticonInOnePage = kEmotionCountInOneLineV * kEmotionCountInOneLineH;
//    _eachEmoticonPackageXOffsetList = [[NSMutableArray alloc] init];
//    for (int packageNumber = 0 ; packageNumber < _emotionList.count; packageNumber++) {//遍历每一套表情
//        NSDictionary *packageDict = [_emotionList objectAtIndex:packageNumber];
//        //TODO: update the packageDict kEMOTION_PACKAGE_IMAGES
////        emotionPreviewImageList = [packageDict objectForKey:kEMOTION_PACKAGE_IMAGES];
//        NSInteger sumOfPage = [[_eachEmoticonPackageOccupyPageList objectAtIndex:packageNumber] integerValue];
//
//        packageEmotionView = [[UIScrollView alloc] init];
//        packageEmotionView.translatesAutoresizingMaskIntoConstraints = YES;
//        packageEmotionView.showsHorizontalScrollIndicator = NO;
//        packageEmotionView.showsVerticalScrollIndicator = NO;
//        packageEmotionView.clipsToBounds = YES;
//        packageEmotionView.pagingEnabled = YES;
//        packageEmotionView.frame = CGRectMake(pageNumber * screen_width, 0, screen_width * sumOfPage, [[[SKSDefaultValueMaker shareInstance] getDefaultKeyboardConfig] chatKeyboardMoreViewHeight]);
//        [_eachEmoticonPackageXOffsetList addObject:@(pageNumber * screen_width)];
//        //每一套表情现在是水平的占用位置
//        packageEmotionView.contentSize = CGSizeMake(screen_width * sumOfPage, [[[SKSDefaultValueMaker shareInstance] getDefaultKeyboardConfig] chatKeyboardMoreViewHeight]);
//        [self.emotionScrollView addSubview:packageEmotionView];
//
//        for (int i = 0; i < emotionPreviewImageList.count; i++) {
//            emotionDict = [emotionPreviewImageList objectAtIndex:i];
//            emotionButton = [SKSEmoticonButton buttonWithType:UIButtonTypeCustom];
//            [emotionButton addTarget:self action:@selector(emotionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
//            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                                                                                     action:@selector(emotionButtonLongPressAction:)];
//            longPressGestureRecognizer.minimumPressDuration = 0.2;
//            [emotionButton addGestureRecognizer:longPressGestureRecognizer];
//
//            int numberInPage = i / numberOfEmoticonInOnePage;//这套表情中的第几页
//            int numberInOneLine = i % kEmotionCountInOneLineH;//第几个
//            int row     = (i / kEmotionCountInOneLineH) % kEmotionCountInOneLineV;//第几行
//
//            emotionButton.frame = CGRectMake(EmotionGapX + (kEmotionBtnWidth + EmotionGapX) * numberInOneLine  + (numberInPage * screen_width),
//                    kEmotionGapY + (kEmotionBtnHeight + kEmotionGapY) * row,
//                    kEmotionBtnWidth,
//                    kEmotionBtnHeight);
//
//
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                //TODO: Init the preview image
////                NSString *filePath = [[SKSEmotionManager shareManager] getPreviewImagePathWithPackageId:[packageDict objectForKey:kEMOTION_PACKAGE_ID] key:[emotionDict objectForKey:kEMOTION_KEY]];
////                UIImage *emotionPreviewImage = [UIImage imageWithContentsOfFile:filePath];
////                //进行图片的一些额外处理
////                if (!(abs(Double(UIScreen.mainScreen.bounds.size.height - 736.0)) < DBL_EPSILON)) {//针对 2x 做的特殊处理
////                    emotionPreviewImage = [UIImage reSizeImage:emotionPreviewImage toSize:CGSizeMake(kEmotionBtnWidth * 2, kEmotionBtnHeight * 2)];
////                }
////                [emotionButton setImage:emotionPreviewImage forState:UIControlStateNormal];
////
////                emotionButton.packageId = [emotionDict objectForKey:kEMOTION_PACKAGE];
////                emotionButton.key = [emotionDict objectForKey:kEMOTION_KEY];
////                emotionButton.name = [emotionDict objectForKey:kEMOTION_NAME];
////                emotionButton.name_zh = [emotionDict objectForKey:kEMOTION_NAME_ZH];
////                emotionButton.type = [emotionDict objectForKey:kEMOTION_TYPE];
////
////                dispatch_async(dispatch_get_main_queue(), ^{
////                    [packageEmotionView addSubview:emotionButton];
////                });
//            });
//
//            //用于显示长按可预览的逻辑
//            if (pageNumber == 0 && row == 1 && numberInOneLine == 0) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self showBubbleTipWithTargetView:emotionButton inView:packageEmotionView];
//                });
//            }
//        }
//        pageNumber += sumOfPage;
//    }
//}
//
//- (void)resetPageControlWithSelectIndex:(NSInteger)selectIndex currentPage:(NSInteger)page {
//
//    if (selectIndex < 0 || selectIndex >= _emotionList.count) {
//        return;
//    }
//
//    if (!_emotionPageControl) {
//        _emotionPageControl = [[UIPageControl alloc] init];
//        _emotionPageControl.pageIndicatorTintColor = RGB(231, 231, 231);
//        _emotionPageControl.currentPageIndicatorTintColor = RGB(180, 186, 193);
//        _emotionPageControl.translatesAutoresizingMaskIntoConstraints = NO;
//        _emotionPageControl.tag = 0;
//        [_emotionPageControl addTarget:self
//                                action:@selector(emotionPageControlAction:)
//                      forControlEvents:UIControlEventValueChanged];
//    }
//    if (!_emotionPageControl.superview) {
//        [self addSubview:_emotionPageControl];
//        [_emotionPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX);
//            make.height.mas_equalTo(44);
//            make.bottom.equalTo(self.mas_bottom).offset(0);
//        }];
//    }
//    _emotionPageControl.numberOfPages = [[_eachEmoticonPackageOccupyPageList objectAtIndex:selectIndex] integerValue];
//    _emotionPageControl.tag = selectIndex;//记录当前是第几套表情
//
//    //设置 currentPage
//    int32_t beforeSumOfPage = 0;//计算前面几套表情的页数
//    for (int i = 0; i < selectIndex; i++) {
//        beforeSumOfPage += [[_eachEmoticonPackageOccupyPageList objectAtIndex:i] integerValue];
//    }
//
//
//    if (page >= beforeSumOfPage) {
//        _emotionPageControl.currentPage = page - beforeSumOfPage;
//    }
//    CGSize size = [_emotionPageControl sizeForNumberOfPages:_emotionPageControl.numberOfPages];
//    [_emotionPageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.height.equalTo(@(size.height));
//        make.width.equalTo(@(size.width));
//        make.bottom.equalTo(self.mas_bottom).offset(-(kEmotionPackageControlHeight - 5));
//    }];
//}
//
//- (void)setupEmotionToolScrollView {
//    _everyPackageFirstEmotionPreviewImageList = [[NSMutableArray alloc] init];
//
//    for (int packageNumber = 0 ; packageNumber < _emotionList.count; packageNumber++) {//遍历每一套表情, 获取每套表情的预览图
//        NSDictionary *packageDict = [_emotionList objectAtIndex:packageNumber];
//        //TODO: get the kEMOTION_PACKAGE_ID
////        NSString *filePath = [[SKSEmotionManager shareManager] getMainPreviewImagePathWithPackageId:[packageDict objectForKey:kEMOTION_PACKAGE_ID]];
//        NSString *filePath = @"";
//
//        UIImage *packagePreviewImage = [UIImage imageWithContentsOfFile:filePath];
//        if (packagePreviewImage) {
//            [_everyPackageFirstEmotionPreviewImageList addObject:packagePreviewImage];
//        }
//    }
//
//    //表情管理商城按钮UI
//    _emoticonShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _emoticonShopButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [_emoticonShopButton addTarget:self action:@selector(emoticonShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_emoticonShopButton setImage:IMAGE(@"icon_emoticon_shop") forState:UIControlStateNormal];
//    _emoticonShopButton.backgroundColor = RGB(245, 245, 245);
//    [self addSubview:_emoticonShopButton];
//    [_emoticonShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(kEmotionPackageControlHeight, kEmotionPackageControlHeight));
//    }];
//
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
//    lineView.translatesAutoresizingMaskIntoConstraints = NO;
//    lineView.backgroundColor = RGB(209, 212, 216);
//    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_emoticonShopButton.mas_right);
//        make.bottom.equalTo(self.mas_bottom).offset(-kLineGapPadding);
//        make.height.mas_equalTo(kEmotionPackageControlHeight - 2 * kLineGapPadding);
//        make.width.mas_equalTo(1);
//    }];
//
//
//    //重新获取 everyPackageFirstEmotionPreviewImageList 的数组
//    _emotionToolScrollView = [[SKSEmotionToolScrollView alloc] initWithDataSourceList:_everyPackageFirstEmotionPreviewImageList viewHeight:kEmotionPackageControlHeight];
//    _emotionToolScrollView.delegate = self;
//    [self addSubview:_emotionToolScrollView];
//
//    if (_everyPackageFirstEmotionPreviewImageList.count > 0) {
//        [_emotionToolScrollView setSelectIndex:0];
//    }
//
//    [_emotionToolScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.equalTo(self);
//        make.left.equalTo(lineView.mas_right);
//        make.height.equalTo(@(kEmotionPackageControlHeight));
//    }];
//}
//
//- (void)reloadEmoticons {
//    //TODO: reloadEmoticons and update localEmoticons
////    [[SKSEmotionManager shareManager] reloadEmoticons];
////    _emotionList = [[SKSEmotionManager shareManager] getLocalEmotions];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        for (UIView *view in self.subviews) {
//            [view removeFromSuperview];
//        }
//        [_emotionPageControl removeFromSuperview];
//
//        [self setupContentView];
//    });
//}
//
//#pragma mark - Helper Method
//- (void)showBubbleTipWithTargetView:(UIView *)targetView inView:(UIView *)inView {
////    _showCanLongPressPreviewTip = [[AFSPopTipView alloc] initWithMessage:STR(@"friends-chat-emoticon-can-preview")];
////    _showCanLongPressPreviewTip.preferredPointDirection = PointDirectionDown;
////    [_showCanLongPressPreviewTip autoDismissAnimated:YES atTimeInterval:3];
////    [_showCanLongPressPreviewTip presentPointingAtView:targetView inView:inView animated:YES];
//}
//
//- (void)showAdminPopTipViewWithTargetView:(UIView *)targetView inView:(UIView *)inView {
////    _popTipView = [[AFSPopTipView alloc] initWithMessage:STR(@"friends-chat-admin-only-accept-voice-text-msg")];
////    _popTipView.preferredPointDirection = PointDirectionDown;
////    [_popTipView autoDismissAnimated:YES atTimeInterval:3];
////    [_popTipView presentPointingAtView:targetView inView:inView animated:YES];
//}
//
//#pragma mark - EmotionToolScrollViewDelegate
//- (void)emotionToolScrollViewDidSelectButtonAtIndex:(NSInteger)index {
//    //水平自动的滚动到第 index 页面
//    CGSize viewSize = self.emotionScrollView.bounds.size;
//
//    //计算前面的页数
//    NSInteger offsetX = 0;
//    for (int i = 0 ; i < index ; i++) {
//        offsetX += [[_eachEmoticonPackageOccupyPageList objectAtIndex:i] integerValue];
//    }
//
//    [_emotionScrollView setContentOffset:CGPointMake(UIScreen.mainScreen.bounds.size.width * offsetX,0) animated:NO];
//    CGRect rect = CGRectMake(offsetX * viewSize.width, 0, viewSize.width, viewSize.height);
//    [self.emotionScrollView scrollRectToVisible:rect animated:YES];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat minX = _emotionScrollView.contentOffset.x;
//    //计算是第几页, 用于计算是第几套表情中的第几页
//    NSInteger page = (NSInteger)ceil(minX / self.bounds.size.width);
//
//    //计算 minX 的边界, 设置
//    BOOL isFind = NO;
//    for (int i = 0 ; i < _eachEmoticonPackageXOffsetList.count; i++) {
//        CGFloat offsetX = [[_eachEmoticonPackageXOffsetList objectAtIndex:i] floatValue];
//        if (offsetX - minX >= 0.00001 ) {
//            [_emotionToolScrollView setSelectIndex:i - 1 isScrollToPosition:YES];
//            [self resetPageControlWithSelectIndex:i - 1 currentPage:page];
//            isFind = YES;
//            break;
//        }
//    }
//
//    if (isFind == NO) {
//        [_emotionToolScrollView setSelectIndex:_eachEmoticonPackageXOffsetList.count - 1 isScrollToPosition:YES];
//        [self resetPageControlWithSelectIndex:_eachEmoticonPackageXOffsetList.count - 1 currentPage:page];
//    }
//}
//
//#pragma mark - Event Response
//- (void)emotionPageControlAction:(SKSEmoticonButton *)button {
//    NSInteger  emoticonPackageIndex = _emotionPageControl.tag;//当前是第几套表情
//    //计算前面的页数
//    NSInteger offsetX = 0;
//    offsetX = [[_eachEmoticonPackageXOffsetList objectAtIndex:emoticonPackageIndex] integerValue];
//
//    CGSize viewSize = self.emotionScrollView.bounds.size;
//    CGRect rect = CGRectMake(_emotionPageControl.currentPage * viewSize.width + offsetX, 0, viewSize.width, viewSize.height);
//    [self.emotionScrollView scrollRectToVisible:rect animated:YES];
//}
//
//- (void)emotionButtonAction:(SKSEmoticonButton *)sender {
//    if (!_isAdmin) {
//        if (!sender) {
//            return;
//        }
//
//        //TODO:
////        int64_t now = [Utils getCurrentMicrosecond];
////
////        if (now - _lastSendEmoticonTimestamp > SendEmoticonLimitInMil) {
////            NSDictionary *metaDict = @{kEMOTION_PACKAGE : sender.packageId,
////                                       kEMOTION_KEY : sender.key,
////                                       kEMOTION_NAME : sender.name,
////                                       kEMOTION_NAME_ZH : sender.name_zh};
////
////            NSDictionary *emotionDict = [NSDictionary dictionaryWithDictionary:metaDict];
////            [self emoticonDidTap:sender emoticonDict:emotionDict];
////            _lastSendEmoticonTimestamp = now;
////        }
//
//    } else {
//        [self showAdminPopTipViewWithTargetView:sender inView:self];//显示管理员相关的界面提示
//    }
//}
//
//- (void)emoticonDidTap:(SKSEmoticonButton *)sender emoticonDict:(NSDictionary *)emoticonDict {
//
//    //抖动动画
//    sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.7);
//    [UIView animateWithDuration:SendEmoticonLimitInSeconds delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        sender.transform = CGAffineTransformIdentity;
//    } completion:nil];
//
//    if ([self.delegate respondsToSelector:@selector(emotionButtonAction:emotionDict:)]) {
//        [self.delegate emotionButtonAction:self emotionDict:emoticonDict];
//    }
//}
//
//- (void)emotionButtonLongPressAction:(UILongPressGestureRecognizer *)sender {
//    SKSEmoticonButton *emotionButton = (SKSEmoticonButton *)(sender.view);
//    if (!emotionButton) {
//        return;
//    }
//    CGPoint point = [sender locationInView:self];
//    switch(sender.state) {
//        case UIGestureRecognizerStateBegan: {
//            _currentAnimationEmoticonButton = emotionButton;
//            [emotionButton doScaleSmallAnimation:YES];
//            NSDictionary *metaDict = [emotionButton getEmoticonDictionary];
//            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressAction:emotionDict:isBegin:)]) {
//                [self.delegate emotionButtonLongPressAction:self emotionDict:metaDict isBegin:YES];
//            }
//            break;
//        }
//        case UIGestureRecognizerStateEnded: {
//
//            if (emotionButton == _currentAnimationEmoticonButton) {
//                [emotionButton doScaleSmallAnimation:NO];
//            } else {
//                [_currentAnimationEmoticonButton doScaleSmallAnimation:NO];
//            }
//            _currentAnimationEmoticonButton = nil;//重置
//            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressAction:emotionDict:isBegin:)]) {
//                [self.delegate emotionButtonLongPressAction:self emotionDict:nil isBegin:NO];
//            }
//            break;
//        }
//        case UIGestureRecognizerStateChanged: {
//            UIView *newView = [self hitTest:point withEvent:nil];
//            if ([newView isKindOfClass:[SKSEmoticonButton class]]) {
//                SKSEmoticonButton *newEmoticon = (SKSEmoticonButton *)newView;
//                if (_currentAnimationEmoticonButton != newEmoticon) {
//                    [_currentAnimationEmoticonButton doScaleSmallAnimation:NO];
//                    _currentAnimationEmoticonButton = newEmoticon;
//                    [newEmoticon doScaleSmallAnimation:YES];
//                    NSDictionary *metaDict = [newEmoticon getEmoticonDictionary];
//                    if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressAction:emotionDict:isBegin:)]) {
//                        [self.delegate emotionButtonLongPressAction:self emotionDict:metaDict isBegin:YES];
//                    }
//                }
//            }
//
//            break;
//        }
//        case UIGestureRecognizerStateFailed: {
//            _currentAnimationEmoticonButton = nil;
//            break;
//        }
//        case UIGestureRecognizerStatePossible: {
//            break;
//        }
//        case UIGestureRecognizerStateCancelled: {//用于预览过程中视频呼入的情况
//            _currentAnimationEmoticonButton = nil;
//            [emotionButton doScaleSmallAnimation:NO];
//            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressAction:emotionDict:isBegin:)]) {
//                [self.delegate emotionButtonLongPressAction:self emotionDict:nil isBegin:NO];
//            }
//            break;
//        }
//        default: {
//            break;
//        }
//    }
//}
//
//- (void)emoticonShopButtonAction:(UIButton *)sender {
//    if ([self.delegate respondsToSelector:@selector(emotionButtonTapEmoticonShopButtonAction:)]) {
//        [self.delegate emotionButtonTapEmoticonShopButtonAction:self];
//    }
//}
//
//#pragma mark - Notification
//- (void)tipShouldHide {
////    if (_popTipView && _popTipView.) {
////        [_popTipView dismissAnimated:YES];
////    }
//}
//
//
//
//@end
