//
//  SKSChatLocationView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSChatLocationView.h"
#import <Masonry/Masonry.h>
#import "SKSChatMessage.h"
#import "SKSChatMessageModel.h"
#import "SKSLocationMessageObject.h"
#import "SKSLocationContentConfig.h"
#import "SKSChatSessionConfig.h"

@interface SKSChatLocationView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSLocationMessageObject *locationMessageAdditionalMessage;
@property (nonatomic, strong) SKSLocationContentConfig *contentConfig;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *pinImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation SKSChatLocationView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    CGSize contentViewSize = messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = messageModel.contentViewInsets;
    self = [super initWithFrame:CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height)];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSLocationMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of SKSLocationMessageObject class");
        return;
    }
    _locationMessageAdditionalMessage = self.messageModel.message.messageAdditionalObject;
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.backgroundColor = _contentConfig.imageBackgroundColor;
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(_contentConfig.locationImageSize.height);
    }];
    
    _pinImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_locationMessageAdditionalMessage.pinImageName]];
    _pinImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _pinImageView.hidden = YES;
    [self addSubview:_pinImageView];
    [_pinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_imageView);
    }];
    
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_imageView);
    }];
    [_loadingView startAnimating];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.text = _locationMessageAdditionalMessage.locationTitle;
    _titleLabel.font = _contentConfig.titleLabelFont;
    _titleLabel.textColor = _contentConfig.titleLabelColor;
    _titleLabel.userInteractionEnabled = YES;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset((_contentConfig.locationImageInsets.bottom + _contentConfig.titleLabelInsets.top));
        make.left.equalTo(self.mas_left).offset(_contentConfig.titleLabelInsets.left);
        make.right.equalTo(self.mas_right).offset(-_contentConfig.titleLabelInsets.right);
        make.height.mas_offset(_contentConfig.titleLabelSize.height);
    }];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descLabel.text = _locationMessageAdditionalMessage.locationDesc;
    _descLabel.font = _contentConfig.descLabelFont;
    _descLabel.textColor = _contentConfig.descLabelColor;
    _descLabel.userInteractionEnabled = YES;
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(_titleLabel.mas_bottom).offset(_contentConfig.descLabelInsets.top);
        make.height.mas_equalTo(_contentConfig.descLabelSize.height);
    }];
}

#pragma mark - Private method
- (void)isShowLoadingView:(BOOL)isShowLoading {
    if (isShowLoading) {
        [_loadingView startAnimating];
        _loadingView.hidden = NO;
        _pinImageView.hidden = YES;
    } else {
        [_loadingView stopAnimating];
        _loadingView.hidden = YES;
        _pinImageView.hidden = NO;
    }
}

#pragma mark - Public method
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force: (BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && _imageView.image != nil && !force) {
        return;
    }
    
    self.messageModel = messageModel;
    self.locationMessageAdditionalMessage = self.messageModel.message.messageAdditionalObject;
    _imageView.image = nil;
    
    [self isShowLoadingView:YES];
    __weak typeof(self) wSelf = self;
    [self.delegate SKSChatLocationViewDidGetImageWithMessageModel:self.messageModel success:^(UIImage *image) {
       dispatch_async(dispatch_get_main_queue(), ^{
           if (image) {
               [wSelf isShowLoadingView:NO];
               wSelf.imageView.image = image;
           } else {
               [wSelf.delegate SKSChatLocationViewDidGetSnapshotImageWithMessageModel:wSelf.messageModel];
           }
       });
    }];
    
    _descLabel.text = self.locationMessageAdditionalMessage.locationDesc;
    _titleLabel.text = self.locationMessageAdditionalMessage.locationTitle;
}

@end
