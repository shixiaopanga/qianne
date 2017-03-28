//
//  SlumpCollectionViewCell.m
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "SlumpCollectionViewCell.h"

@implementation SlumpCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:_showView];
    }
    return self;
}
-(void)setShowView:(UIView *)showView {
    [_showView removeFromSuperview];
    _showView = showView;
    [self addSubview:_showView];
}
- (void)layoutSubviews {
    _showView.frame = self.bounds;
    NSLog(@"sss");
}

@end
