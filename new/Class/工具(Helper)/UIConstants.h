//
//  UIConstants.h
//  scale
//
//  Created by Maxye on 14/12/2.
//  Copyright (c) 2014年 Maxye. All rights reserved.
//

// UIConstants provides contants variables for UI control.
#define UI_NAVIGATION_BAR_STATUS_BAR_HEIGHT    64
#define UI_NAVIGATION_BAR_HEIGHT    44
#define UI_TAB_BAR_HEIGHT           49
#define UI_STATUS_BAR_HEIGHT        20
#define UI_SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define UI_LABEL_LENGTH             200
#define UI_LABEL_HEIGHT             15
#define UI_LABEL_FONT_SIZE          12
#define UI_LABEL_FONT               [UIFont systemFontOfSize:UI_LABEL_FONT_SIZE]

#define UI_WIDTH_IPHONE4 320
#define UI_HEIGHT_IPHONE4 480

#define UI_WIDTH_IPHONE5 320
#define UI_HEIGHT_IPHONE5 568

#define UI_WIDTH_IPHONE6 375
#define UI_HEIGHT_IPHONE6 667

#define UI_WIDTH_IPHONE6P 414
#define UI_HEIGHT_IPHONE6P 736

#define UI_IS_IPHONE4    (([[UIScreen mainScreen] bounds].size.height)==480)
#define UI_IS_IPHONE5    (([[UIScreen mainScreen] bounds].size.height)==568)
#define UI_IS_IPHONE6    (([[UIScreen mainScreen] bounds].size.height)==667)
#define UI_IS_IPHONE6P    (([[UIScreen mainScreen] bounds].size.height)==736)
