//
//  SlumpBar.h
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlumpBar;

@protocol SlumpBarDelegate <NSObject>

- (void)SlumpBar:(SlumpBar *)slumBar didSelectIndex:(NSInteger)index;

@end
@interface SlumpBar : UIControl

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIFont *titleBtnFont;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,weak) id<SlumpBarDelegate> delegate;

- (void)setSlumpTitles:(NSArray*)array;
- (void)setTitleBtnIndex:(NSInteger)index;
@end
