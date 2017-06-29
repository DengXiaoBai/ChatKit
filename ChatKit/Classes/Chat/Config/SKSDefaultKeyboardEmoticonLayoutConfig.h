//
//  SKSDefaultKeyboardEmoticonLayoutConfig.h
//  ChatKit
//
//  Created by iCrany on 2016/12/30.
//
//


#import "SKSKeyboardEmoticonLayoutConfig.h"

@interface SKSDefaultKeyboardEmoticonLayoutConfig : NSObject <SKSKeyboardEmoticonLayoutConfig>

@property (nonatomic, assign) UIEdgeInsets emoticonInsets;

@property (nonatomic, assign) NSInteger rows;

@property (nonatomic, assign) NSInteger colums;

@property (nonatomic, assign) NSInteger itemCountInOnePage;//在每一页都满数的情况下, Emoji 不一定就是 rows * colums 的总数

@property (nonatomic, assign) CGSize btnSize;//表情或者 Emoji 的大小

@property (nonatomic, assign) BOOL isEmoji;//是否是 Emoji 例如 --》 😀😀😀😀😀😄😄😄😄
@property (nonatomic, strong) UIFont *emojiFont;

@end
