//
//  SlumpBar.m
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "SlumpBar.h"

@interface SlumpBar() {
    NSArray *_titleWidthArray;
    NSInteger _scrollViewContentWidth;
    UIView *_selectedLine;
    UIView *_bottomLine;
}

@end

@implementation SlumpBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0.5)];
        _scrollView.clipsToBounds = YES;
        _scrollView.backgroundColor = RGBA(1, 1, 1, 0);
        _scrollView.opaque = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = BackgroundColor;
        [_scrollView addSubview:_bottomLine];
        
        _selectedLine  = [[UIView alloc] init];
        _selectedLine.backgroundColor = ThemeColor;
        [_scrollView addSubview:_selectedLine];
        
    }
    
    return self;
}
- (UIFont*)titleBtnFont {
    return _titleBtnFont?:[UIFont systemFontOfSize:17];
}
- (void)setSlumpTitles:(NSArray *)array {
    NSMutableArray *titleWidthMutableArray = [NSMutableArray array];
    NSInteger scrollViewContentWidth = 0;
    for (int i = 0; i < array.count; i++) {
        
        NSString *titleStr = [array objectAtIndex:i];
        CGFloat titleWidth = [titleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleBtnFont} context:nil].size.width + 20;
        [titleWidthMutableArray addObject:@(titleWidth)];
        
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(scrollViewContentWidth, 0, titleWidth, self.bounds.size.height)];
        titleBtn.tag = 1000 + i;
        [titleBtn.titleLabel setFont:self.titleBtnFont];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [titleBtn setTitle:titleStr forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:titleBtn];
        scrollViewContentWidth += titleWidth;
        
        if (i == 0) {
            [titleBtn setSelected:YES];
            _selectedLine.frame = CGRectMake(0, _scrollView.bounds.size.height-2, scrollViewContentWidth, 2);
            _selectedIndex = 0;
        }
        
    }
    
    _scrollViewContentWidth = scrollViewContentWidth;
    _scrollView.contentSize = CGSizeMake(_scrollViewContentWidth,0);
    _titleWidthArray = [titleWidthMutableArray copy];
    _bottomLine.frame = CGRectMake(0, _scrollView.frame.size.height-2, _scrollViewContentWidth, 2);
}

- (void)titleBtnClick:(UIButton*)selectBtn{
    [self setSelectBtn:selectBtn];
    if ([_delegate respondsToSelector:@selector(SlumpBar:didSelectIndex:)]) {
        [_delegate SlumpBar:self didSelectIndex:_selectedIndex];
    }
    
}
- (void)setSelectBtn:(UIButton*)selectBtn{
    
    UIButton *oldSelectButton = (UIButton*)[_scrollView viewWithTag:(1000 + _selectedIndex)];
    [oldSelectButton setSelected:NO];
    
    [selectBtn setSelected:YES];
    _selectedIndex = selectBtn.tag - 1000;
    
    NSInteger selectBtnOriginX = 0;
    for (int i=0; i<_selectedIndex; i++) {
        selectBtnOriginX += [[_titleWidthArray objectAtIndex:i] integerValue];
    }
    
    //处理边界
    CGFloat selectBtnWidth = [[_titleWidthArray objectAtIndex:_selectedIndex] integerValue];
    CGFloat distanceFromCenter = selectBtnOriginX + (selectBtnWidth - self.bounds.size.width) *0.5 ;
    CGFloat scrollOffset = MIN(_scrollViewContentWidth - self.bounds.size.width, MAX(0, distanceFromCenter));
    
    [_scrollView setContentOffset:CGPointMake(scrollOffset, 0) animated:YES];
    
    [UIView animateWithDuration:0.1 animations:^{
        _selectedLine.frame = CGRectMake(selectBtnOriginX, _selectedLine.frame.origin.y, selectBtnWidth, _selectedLine.frame.size.height);
    }];
    
}
- (void)setTitleBtnIndex:(NSInteger)index {
    UIButton *selectBtn = [_scrollView viewWithTag:(1000 + index)];
    [self setSelectBtn:selectBtn];
}
@end
