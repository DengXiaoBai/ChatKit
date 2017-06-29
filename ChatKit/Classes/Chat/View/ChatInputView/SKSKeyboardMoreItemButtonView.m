//
//  SKSKeyboardMoreItemView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <Masonry/MASConstraintMaker.h>
#import "SKSKeyboardMoreItemButtonView.h"
#import "SKSKeyboardMoreViewItemProtocol.h"

static UIEdgeInsets kButtonImageViewInsets = {5, 5, 0, 5};
static UIEdgeInsets kDescLabelInsets = {14, 5, 5, 5};

@interface SKSKeyboardMoreItemButtonView()

@property (nonatomic, strong) UIButton *imageBtn;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, assign) CGSize viewSize;

@end

@implementation SKSKeyboardMoreItemButtonView

- (instancetype)initWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>)itemModel frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.itemModel = itemModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImage *image = [UIImage imageNamed:_itemModel.normalImageName];
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageBtn setImage:image forState:UIControlStateNormal];
    [_imageBtn setImage:[UIImage imageNamed:_itemModel.highlightImageName] forState:UIControlStateHighlighted];
    [self addSubview:_imageBtn];
    [_imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kButtonImageViewInsets.top);
        make.centerX.equalTo(self.mas_centerX);
    }];

    CGFloat imageBtnWidth = kButtonImageViewInsets.left + image.size.width + kButtonImageViewInsets.right;
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descLabel.text = _itemModel.title;
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = RGB(158, 158, 158);
    [self addSubview:_descLabel];
    CGSize descLabelSize = [_descLabel sizeThatFits:CGSizeMake(imageBtnWidth, FLT_MAX)];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageBtn.mas_bottom).offset(kDescLabelInsets.top);
        make.left.equalTo(self.mas_left).offset(kDescLabelInsets.left);
        make.right.equalTo(self.mas_right).offset(-kDescLabelInsets.right);
        make.height.mas_equalTo(descLabelSize.height);
    }];
    CGFloat descLabelWidth = kDescLabelInsets.left + descLabelSize.width + kDescLabelInsets.right;
    
    _viewSize = CGSizeMake(MAX(imageBtnWidth, descLabelWidth),
                           kButtonImageViewInsets.top + image.size.height + kButtonImageViewInsets.bottom + kDescLabelInsets.top + descLabelSize.height + kDescLabelInsets.bottom);
}

- (CGSize)getViewSize {
    return _viewSize;
}

#pragma mark - Event Response
- (void)imageBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SKSKeyboardMoreItemButtonViewDidTapWithItemModel:)]) {
        [self.delegate SKSKeyboardMoreItemButtonViewDidTapWithItemModel:_itemModel];
    }
}

@end
