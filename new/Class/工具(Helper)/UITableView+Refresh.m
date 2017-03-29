//
//  UITableView+Refresh.m
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "UITableView+Refresh.h"
#import "MJRefresh.h"

@implementation UITableView (Refresh)
- (void)addPullToRefreshTarget:(id)target refreshingAction:(SEL _Nonnull)refreshingAction loadMoreAction:(SEL _Nonnull)loadMoreAction {
    if (refreshingAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:refreshingAction];
        header.automaticallyChangeAlpha = YES;
        header.stateLabel.font = [UIFont systemFontOfSize:15];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
        header.stateLabel.textColor = [UIColor blackColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
        [header beginRefreshing];
        self.mj_header = header;
    }
}
- (void)addPushToRefreshTarget:(id)target loadMoreAction:(SEL _Nonnull)loadMoreAction {

        if (loadMoreAction && !self.mj_footer) {
    
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreAction];
            footer.automaticallyChangeAlpha = YES;
            footer.automaticallyRefresh = NO;
            self.mj_footer = footer;
        }
}
- (void)removePush {
    self.mj_footer = nil ;
}
- (void)endRefreshing {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}
@end
