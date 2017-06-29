//
//  SKSKeyboardMoreItemView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SKSKeyboardMoreViewItemProtocol;

@protocol SKSKeyboardMoreItemButtonViewDelegate <NSObject>

- (void)SKSKeyboardMoreItemButtonViewDidTapWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>) itemModel;

@end

@interface SKSKeyboardMoreItemButtonView : UIControl

@property (nonatomic, weak) id<SKSKeyboardMoreItemButtonViewDelegate> delegate;

@property (nonatomic, strong) id<SKSKeyboardMoreViewItemProtocol> itemModel;

- (instancetype)initWithItemModel:(id<SKSKeyboardMoreViewItemProtocol>)itemModel frame:(CGRect)frame;

- (CGSize)getViewSize;

@end
