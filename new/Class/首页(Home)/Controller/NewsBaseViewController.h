//
//  NewsBaseViewController.h
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NewsType) {
    NewsTypeTop,
    NewsTypeSociety,
    NewsTypeCivil,
    NewsTypeForeign,
    NewsTypeRecreation,
    NewsTypePhysical,
    NewsTypeScience,
    NewsTypeFinance,
};
@interface NewsBaseViewController : UIViewController
@property (nonatomic, readwrite, assign) NewsType type;
@end
