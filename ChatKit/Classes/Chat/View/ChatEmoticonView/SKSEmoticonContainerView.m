//
//  SKSEmoticonContainerView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//
#import <Masonry/Masonry.h>
#import "SKSEmoticonContainerView.h"
#import "SKSEmoticonMeta.h"
#import "SKSChatUserModel.h"
#import "SKSEmoticonCatalog.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatKeyboardConfig.h"
#import "SKSEmotionToolScrollView.h"
#import "SKSKeyboardEmoticonLayoutConfig.h"
#import "SKSEmoticonButton.h"
#import "SKSDefaultKeyboardEmoticonLayoutConfig.h"

static CGFloat kLineGapPadding                 = 5.0f;

@interface SKSEmoticonContainerView() <SKSEmotionToolScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) id<SKSChatSessionConfig> sessionConfig;
@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, strong) SKSChatUserModel *userModel;
@property (nonatomic, strong) NSArray<SKSEmoticonCatalog *> *emoticonCatalogList;


@property (nonatomic, strong) UIScrollView *emotionScrollView;
@property (nonatomic, strong) UIPageControl *emotionPageControl;
@property (nonatomic, strong) SKSEmotionToolScrollView *emotionToolScrollView;
@property (nonatomic, strong) UIButton *emoticonShopButton;

@property (nonatomic, strong) NSMutableArray *eachEmoticonPackageOccupyPageList;//每一个表情包占用的水平页数
@property (nonatomic, strong) NSMutableArray *eachEmoticonPackageXOffsetList;//每一套表情的 x 的偏移值

@property (nonatomic, strong) SKSEmoticonButton *currentAnimationEmoticonButton;

@end

@implementation SKSEmoticonContainerView

- (instancetype)initWithUserModel:(SKSChatUserModel *)userModel sessionConfig:(id<SKSChatSessionConfig>)sessionConfig {
    self = [super init];
    if (self) {
        self.userModel = userModel;
        self.sessionConfig  = sessionConfig;
        self.keyboardConfig = [self.sessionConfig chatKeyboardConfig];
        [self prepareEmoticonCatalogList];
        [self setupContentView];
        [self setupNotification];
    }
    return self;
}

- (void)prepareEmoticonCatalogList {
    NSString *emojiFileName = @"EmojisList";
    NSString *emojiFileType = @"plist";
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:emojiFileName ofType:emojiFileType]];

    //构造成对应的
    NSMutableArray *emoticonCatalogList = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary.allKeys) {
        NSArray *emojiList = dictionary[key];
        SKSEmoticonCatalog *catalog = [[SKSEmoticonCatalog alloc] init];
        NSMutableArray *metaList = [[NSMutableArray alloc] init];
        if (emojiList.count > 0) {
            catalog.previewImage = emojiList[0];
        }

        for (NSString *emojiStr in emojiList) {
            SKSEmoticonMeta *meta = [[SKSEmoticonMeta alloc] initWithEmoticonId:emojiStr catalogId:key name:emojiStr name_zh:@"" type:@""];
            meta.isEmoji = YES;
            [metaList addObject:meta];
        }
        catalog.emoticonLayoutConfig = [[SKSDefaultKeyboardEmoticonLayoutConfig alloc] initForEmoji];
        catalog.emoticonList = [NSArray arrayWithArray:metaList];
        [emoticonCatalogList addObject:catalog];
    }
    _emoticonCatalogList = [NSArray arrayWithArray:emoticonCatalogList];
}

- (void)setupNotification {

}

- (void)setupContentView {
    self.backgroundColor = self.keyboardConfig.chatKeyboardEmoticonContainerViewBackgroundColor;
    [self setupEmoticonScrollView];
    [self setupEmoticonButtons];
    [self resetPageControlWithSelectIndex:0 currentPage:0];
    [self setupEmoticonToolScrollView];
}

- (void)setupEmoticonScrollView {
    _emotionScrollView = [[UIScrollView alloc] init];
    _emotionScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _emotionScrollView.delegate = self;
    _emotionScrollView.pagingEnabled = YES;
    _emotionScrollView.showsHorizontalScrollIndicator = NO;
    _emotionScrollView.showsVerticalScrollIndicator = NO;
    _emotionScrollView.backgroundColor = [UIColor clearColor];

    _eachEmoticonPackageOccupyPageList = [[NSMutableArray alloc] init];

    int32_t numberOfPageInHorizontal = 0;//水平方向一共有多少页
    for (SKSEmoticonCatalog *catalog in _emoticonCatalogList) {
        int32_t catalogEmoticonCount = (int32_t)catalog.emoticonList.count;
        int32_t numberOfPageInThisCatalog = (catalogEmoticonCount / catalog.emoticonLayoutConfig.itemCountInOnePage) + ((catalogEmoticonCount % catalog.emoticonLayoutConfig.itemCountInOnePage) > 0 ? 1 : 0);
        [_eachEmoticonPackageOccupyPageList addObject:@(numberOfPageInThisCatalog)];
        numberOfPageInHorizontal += numberOfPageInThisCatalog;
    }
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    _emotionScrollView.contentSize = CGSizeMake(screen_width * numberOfPageInHorizontal, self.keyboardConfig.chatKeyboardMoreViewHeight);
    [self addSubview:_emotionScrollView];
    _emotionScrollView.frame = CGRectMake(0, 0, screen_width, self.keyboardConfig.chatKeyboardMoreViewHeight);
}


- (void)setupEmoticonButtons {

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    _eachEmoticonPackageXOffsetList = [[NSMutableArray alloc] init];
    for (int catalogNumber = 0; catalogNumber < _emoticonCatalogList.count; catalogNumber++) {
        SKSEmoticonCatalog *emoticonCatalog = _emoticonCatalogList[catalogNumber];
        NSInteger sumOfPage = [[_eachEmoticonPackageOccupyPageList objectAtIndex:catalogNumber] integerValue];

        CGFloat emoticonHeight = self.keyboardConfig.chatKeyboardMoreViewHeight - self.keyboardConfig.chatKeyboardEmoticonToolViewHeight;
        CGFloat EmoticonGapY = (emoticonHeight - emoticonCatalog.emoticonLayoutConfig.rows * emoticonCatalog.emoticonLayoutConfig.btnSize.height - emoticonCatalog.emoticonLayoutConfig.emoticonInsets.top - emoticonCatalog.emoticonLayoutConfig.emoticonInsets.bottom) / (emoticonCatalog.emoticonLayoutConfig.rows + 1);
        CGFloat EmoticonGapX = (screen_width - emoticonCatalog.emoticonLayoutConfig.colums * emoticonCatalog.emoticonLayoutConfig.btnSize.width - emoticonCatalog.emoticonLayoutConfig.emoticonInsets.left - emoticonCatalog.emoticonLayoutConfig.emoticonInsets.right) / (emoticonCatalog.emoticonLayoutConfig.colums + 1);

        UIScrollView *catalogEmoticonView = [[UIScrollView alloc] init];
        catalogEmoticonView.showsHorizontalScrollIndicator = NO;
        catalogEmoticonView.showsVerticalScrollIndicator = NO;
        catalogEmoticonView.clipsToBounds = YES;
        catalogEmoticonView.pagingEnabled = YES;
        catalogEmoticonView.frame = CGRectMake(catalogNumber * screen_width, 0, screen_width * sumOfPage, self.sessionConfig.chatKeyboardConfig.chatKeyboardMoreViewHeight);
        [_eachEmoticonPackageXOffsetList addObject:@(catalogNumber * screen_width)];

        catalogEmoticonView.contentSize = CGSizeMake(screen_width * sumOfPage, self.sessionConfig.chatKeyboardConfig.chatKeyboardMoreViewHeight);
        [self.emotionScrollView addSubview:catalogEmoticonView];

        NSString *emoticonButtonClassName = self.keyboardConfig.chatKeyboardEmoticonButtonClassName;
        Class clazz = NSClassFromString(emoticonButtonClassName);

        for (int i = 0; i < emoticonCatalog.emoticonList.count; i++) {
            SKSEmoticonMeta *emoticonMeta = emoticonCatalog.emoticonList[i];
            SKSEmoticonButton *emoticonButton;
            if (clazz) {
                emoticonButton = [clazz buttonWithType:UIButtonTypeCustom];
            } else {
                emoticonButton = [SKSEmoticonButton buttonWithType:UIButtonTypeCustom];
            }

            [emoticonButton addTarget:self action:@selector(emoticonButtonAction:) forControlEvents:UIControlEventTouchUpInside];

            if (!emoticonCatalog.emoticonLayoutConfig.isEmoji) {//Emoji 没有长按手势
                UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(emotionButtonLongPressAction:)];
                longPressGestureRecognizer.minimumPressDuration = 0.2;
                [emoticonButton addGestureRecognizer:longPressGestureRecognizer];
            }

            int numberInPage = i / emoticonCatalog.emoticonLayoutConfig.itemCountInOnePage;//这套表情中的第几页
            int colum = i % emoticonCatalog.emoticonLayoutConfig.colums;//第几列
            int row = (i / emoticonCatalog.emoticonLayoutConfig.colums) % emoticonCatalog.emoticonLayoutConfig.rows;//第几行

            if (emoticonCatalog.emoticonLayoutConfig.isEmoji && numberInPage > 0) {
                //Emoji 修正
                int tempI = i + numberInPage;
                colum = tempI % emoticonCatalog.emoticonLayoutConfig.colums;//第几列
                row = (tempI / emoticonCatalog.emoticonLayoutConfig.colums) % emoticonCatalog.emoticonLayoutConfig.rows;//第几行
            }

            CGFloat emoticonX = emoticonCatalog.emoticonLayoutConfig.emoticonInsets.left + EmoticonGapX + (emoticonCatalog.emoticonLayoutConfig.btnSize.width + EmoticonGapX) * colum + numberInPage * screen_width;
            CGFloat emoticonY = emoticonCatalog.emoticonLayoutConfig.emoticonInsets.top + EmoticonGapY + (emoticonCatalog.emoticonLayoutConfig.btnSize.height + EmoticonGapY) * row;
            emoticonButton.frame = CGRectMake(emoticonX, emoticonY, emoticonCatalog.emoticonLayoutConfig.btnSize.width, emoticonCatalog.emoticonLayoutConfig.btnSize.height);

            [emoticonButton updateEmoticonMeta:emoticonMeta];
            [catalogEmoticonView addSubview:emoticonButton];

            if(emoticonCatalog.emoticonLayoutConfig.isEmoji) {
                emoticonButton.titleLabel.font = emoticonCatalog.emoticonLayoutConfig.emojiFont;
            }
        }

        if (emoticonCatalog.emoticonLayoutConfig.isEmoji) {
            //重新添加删除按钮
            for (int i = 0; i < sumOfPage; i++) {
                NSInteger row = emoticonCatalog.emoticonLayoutConfig.rows - 1;
                NSInteger colum = emoticonCatalog.emoticonLayoutConfig.colums - 1;
                CGFloat x = emoticonCatalog.emoticonLayoutConfig.emoticonInsets.left + EmoticonGapX + (emoticonCatalog.emoticonLayoutConfig.btnSize.width + EmoticonGapX) * colum + i * screen_width;
                CGFloat y = emoticonCatalog.emoticonLayoutConfig.emoticonInsets.top + EmoticonGapY + (emoticonCatalog.emoticonLayoutConfig.btnSize.height + EmoticonGapY) * row;
                SKSEmoticonButton *deleteButton = [SKSEmoticonButton buttonWithType:UIButtonTypeCustom];
                [deleteButton setImage:[UIImage imageNamed:self.keyboardConfig.chatKeyboardEmoticonDeleteButtonImageName] forState:UIControlStateNormal];
                [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.frame = CGRectMake(x, y, emoticonCatalog.emoticonLayoutConfig.btnSize.width, emoticonCatalog.emoticonLayoutConfig.btnSize.height);
                [catalogEmoticonView addSubview:deleteButton];
            }
        }

    }
}

- (void)resetPageControlWithSelectIndex:(NSInteger)selectIndex currentPage:(NSInteger)page {
    if (selectIndex < 0 || selectIndex >= _emoticonCatalogList.count) {
        return;
    }

    if (!_emotionPageControl) {
        _emotionPageControl = [[UIPageControl alloc] init];
        _emotionPageControl.pageIndicatorTintColor = _keyboardConfig.chatKeyboardEmoticonPageIndicatorTintColor;
        _emotionPageControl.currentPageIndicatorTintColor = _keyboardConfig.chatKeyboardEmoticonCurrentPageIndicatorTintColor;
        _emotionPageControl.translatesAutoresizingMaskIntoConstraints = NO;
        _emotionPageControl.tag = 0;
        [_emotionPageControl addTarget:self
                                action:@selector(emotionPageControlAction:)
                      forControlEvents:UIControlEventValueChanged];
    }
    if (!_emotionPageControl.superview) {
        [self addSubview:_emotionPageControl];
        [_emotionPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(44);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
    }
    _emotionPageControl.numberOfPages = [[_eachEmoticonPackageOccupyPageList objectAtIndex:selectIndex] integerValue];
    _emotionPageControl.tag = selectIndex;//记录当前是第几套表情

    //设置 currentPage
    int32_t beforeSumOfPage = 0;//计算前面几套表情的页数
    for (int i = 0; i < selectIndex; i++) {
        beforeSumOfPage += [[_eachEmoticonPackageOccupyPageList objectAtIndex:i] integerValue];
    }

    if (page >= beforeSumOfPage) {
        _emotionPageControl.currentPage = page - beforeSumOfPage;
    }
    CGSize size = [_emotionPageControl sizeForNumberOfPages:_emotionPageControl.numberOfPages];
    [_emotionPageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(size.height));
        make.width.equalTo(@(size.width));
        make.bottom.equalTo(self.mas_bottom).offset(-(self.keyboardConfig.chatKeyboardEmoticonToolViewHeight - 5));
    }];
}

- (void)setupEmoticonToolScrollView {

    //重新获取 everyPackageFirstEmotionPreviewImageList 的数组
    _emotionToolScrollView = [[SKSEmotionToolScrollView alloc] initWithDataSourceList:_emoticonCatalogList keyboardConfig:self.keyboardConfig];
    _emotionToolScrollView.delegate = self;
    [self addSubview:_emotionToolScrollView];

    if (self.keyboardConfig.chatKeyboardShowEmoticonShopButton) {
        //表情管理商城按钮UI
        _emoticonShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonShopButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_emoticonShopButton addTarget:self action:@selector(emoticonShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_emoticonShopButton setImage:[UIImage imageNamed:self.keyboardConfig.chatKeyboardEmoticonShopImageName] forState:UIControlStateNormal];
        _emoticonShopButton.backgroundColor = self.keyboardConfig.chatKeyboardEmoticonShopBackgroundColor;
        [self addSubview:_emoticonShopButton];
        [_emoticonShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.keyboardConfig.chatKeyboardEmoticonToolViewHeight, self.keyboardConfig.chatKeyboardEmoticonToolViewHeight));
        }];

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        lineView.backgroundColor = RGB(209, 212, 216);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_emoticonShopButton.mas_right);
            make.bottom.equalTo(self.mas_bottom).offset(-kLineGapPadding);
            make.height.mas_equalTo(self.keyboardConfig.chatKeyboardEmoticonToolViewHeight - 2 * kLineGapPadding);
            make.width.mas_equalTo(1);
        }];

        [_emotionToolScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.left.equalTo(lineView.mas_right);
            make.height.equalTo(@(self.keyboardConfig.chatKeyboardEmoticonToolViewHeight));
        }];
    } else {
        [_emotionToolScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self);
            make.height.equalTo(@(self.keyboardConfig.chatKeyboardEmoticonToolViewHeight));
        }];
    }

    if (_emoticonCatalogList.count > 0) {
        [_emotionToolScrollView setSelectIndex:0];
    }
}

- (void)keyboardViewTextDidChange:(NSString *)text {
    if (text.length > 0) {
        [self.emotionToolScrollView emoticonToolSendBtnState:SKSKeyboardEmtocionSendButtonStateEnableShow];
    } else {
        [self.emotionToolScrollView emoticonToolSendBtnState:SKSKeyboardEmoticonSendButtonStateDisableShow];
    }
}

#pragma mark - EmotionToolScrollViewDelegate
- (void)emotionToolScrollViewDidSelectButtonAtIndex:(NSInteger)index {
    //水平自动的滚动到第 index 页面
    CGSize viewSize = self.emotionScrollView.bounds.size;

    //计算前面的页数
    NSInteger offsetX = 0;
    for (int i = 0 ; i < index ; i++) {
        offsetX += [[_eachEmoticonPackageOccupyPageList objectAtIndex:i] integerValue];
    }

    [_emotionScrollView setContentOffset:CGPointMake(UIScreen.mainScreen.bounds.size.width * offsetX,0) animated:NO];
    CGRect rect = CGRectMake(offsetX * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.emotionScrollView scrollRectToVisible:rect animated:YES];
}

- (void)emoticonToolScrollViewDidSendAction {
    if ([self.delegate respondsToSelector:@selector(emoticonDidTapSendAction)]) {
        [self.delegate emoticonDidTapSendAction];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minX = _emotionScrollView.contentOffset.x;
    //计算是第几页, 用于计算是第几套表情中的第几页
    NSInteger page = (NSInteger)ceil(minX / self.bounds.size.width);

    //计算 minX 的边界, 设置
    BOOL isFind = NO;
    for (int i = 0 ; i < _eachEmoticonPackageXOffsetList.count; i++) {
        CGFloat offsetX = [[_eachEmoticonPackageXOffsetList objectAtIndex:i] floatValue];
        if (offsetX - minX >= FLT_MIN ) {
            [_emotionToolScrollView setSelectIndex:i - 1 isScrollToPosition:YES];
            [self resetPageControlWithSelectIndex:i - 1 currentPage:page];
            isFind = YES;
            break;
        }
    }

    if (isFind == NO) {
        [_emotionToolScrollView setSelectIndex:_eachEmoticonPackageXOffsetList.count - 1 isScrollToPosition:YES];
        [self resetPageControlWithSelectIndex:_eachEmoticonPackageXOffsetList.count - 1 currentPage:page];
    }
}

#pragma mark - Event Response
- (void)emotionPageControlAction:(SKSEmoticonButton *)button {
    NSInteger  emoticonPackageIndex = _emotionPageControl.tag;//当前是第几套表情
    //计算前面的页数
    NSInteger offsetX = 0;
    offsetX = [[_eachEmoticonPackageXOffsetList objectAtIndex:emoticonPackageIndex] integerValue];

    CGSize viewSize = self.emotionScrollView.bounds.size;
    CGRect rect = CGRectMake(_emotionPageControl.currentPage * viewSize.width + offsetX, 0, viewSize.width, viewSize.height);
    [self.emotionScrollView scrollRectToVisible:rect animated:YES];
}

- (void)emoticonButtonAction:(SKSEmoticonButton *)sender {
    [self emoticonDidTap:sender emoticonMeta:sender.emoticonMeta];
}

- (void)emoticonShopButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(emotionButtonTapEmoticonShopButtonAction)]) {
        [self.delegate emotionButtonTapEmoticonShopButtonAction];
    }
}

- (void)emoticonDidTap:(SKSEmoticonButton *)sender emoticonMeta:(SKSEmoticonMeta *)emoticonMeta {

    //抖动动画
//    sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.7);
//    [UIView animateWithDuration:SendEmoticonLimitInSeconds delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        sender.transform = CGAffineTransformIdentity;
//    } completion:nil];

    if ([self.delegate respondsToSelector:@selector(emotionButtonActionWithEmotionMeta:)]) {
        [self.delegate emotionButtonActionWithEmotionMeta:emoticonMeta];
    }
}

- (void)deleteButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(emoticonDeleteButtonAction)]) {
        [self.delegate emoticonDeleteButtonAction];
    }
}

- (void)emotionButtonLongPressAction:(UILongPressGestureRecognizer *)sender {
    SKSEmoticonButton *emotionButton = (SKSEmoticonButton *)(sender.view);
    if (!emotionButton) {
        return;
    }

    if (emotionButton.emoticonMetaType == SKSEmoticonMetaTypeEmojiButton) {
        return;//Emoji 没有预览功能
    }

    CGPoint point = [sender locationInView:self];
    switch(sender.state) {
        case UIGestureRecognizerStateBegan: {
            _currentAnimationEmoticonButton = emotionButton;
            [emotionButton doScaleSmallAnimation:YES];
            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressActionWithEmotionMeta:isBegin:)]) {
                [self.delegate emotionButtonLongPressActionWithEmotionMeta:emotionButton.emoticonMeta isBegin:YES];
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {

            if (emotionButton == _currentAnimationEmoticonButton) {
                [emotionButton doScaleSmallAnimation:NO];
            } else {
                [_currentAnimationEmoticonButton doScaleSmallAnimation:NO];
            }
            _currentAnimationEmoticonButton = nil;//重置
            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressActionWithEmotionMeta:isBegin:)]) {
                [self.delegate emotionButtonLongPressActionWithEmotionMeta:nil isBegin:NO];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            UIView *newView = [self hitTest:point withEvent:nil];
            if ([newView isKindOfClass:[SKSEmoticonButton class]]) {
                SKSEmoticonButton *newEmoticon = (SKSEmoticonButton *)newView;
                if (_currentAnimationEmoticonButton != newEmoticon) {
                    [_currentAnimationEmoticonButton doScaleSmallAnimation:NO];
                    _currentAnimationEmoticonButton = newEmoticon;
                    [newEmoticon doScaleSmallAnimation:YES];
                    if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressActionWithEmotionMeta:isBegin:)]) {
                        [self.delegate emotionButtonLongPressActionWithEmotionMeta:emotionButton.emoticonMeta isBegin:YES];
                    }
                }
            }

            break;
        }
        case UIGestureRecognizerStateFailed: {
            _currentAnimationEmoticonButton = nil;
            break;
        }
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateCancelled: {//用于预览过程中视频呼入的情况
            _currentAnimationEmoticonButton = nil;
            [emotionButton doScaleSmallAnimation:NO];
            if ([self.delegate respondsToSelector:@selector(emotionButtonLongPressActionWithEmotionMeta:isBegin:)]) {
                [self.delegate emotionButtonLongPressActionWithEmotionMeta:nil isBegin:NO];
            }
            break;
        }
        default: {
            break;
        }
    }
}

@end
