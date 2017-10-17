//
//  MarcosDefinition.h
//  ChatKit
//
//  Created by iCrany on 2017/6/20.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

#ifndef MarcosDefinition_h
#define MarcosDefinition_h

#define FONT_DEFAULT(F) [UIFont defaultFontOfSize:F]
#define FONT_DEFAULT_MEDIUM(F) [UIFont mediumDefaultFontOfSize:F]
#define FONT_DEFAULT_BOLD(F) [UIFont boldDefaultFontOfSize:F]


#define IS_IPHONE_X (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)812.0f) < DBL_EPSILON)//判断是否是iPhone_X

#endif /* MarcosDefinition_h */
