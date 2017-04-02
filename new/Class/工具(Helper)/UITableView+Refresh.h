//
//  UITableView+Refresh.h
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Refresh)
- (void)addPullToRefreshTarget:(id _Nonnull)target refreshingAction:(SEL _Nonnull)refreshingAction loadMoreAction:(SEL _Nonnull)loadMoreAction;
- (void)endRefreshing ;
@end
