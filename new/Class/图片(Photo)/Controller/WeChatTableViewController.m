//
//  WeChatTableViewController.m
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "WeChatTableViewController.h"
#import "WeChatTableViewCell.h"
#import "UITableView+Refresh.h"
#import "ONESEssayModel.h"
#import "MainNavigationController.h"
#import "GloablTransitionAnimation.h"
#import "EssayContentViewController.h"

@interface WeChatTableViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, copy) NSMutableArray *ONESEssayList;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) CGRect presentRect;
@end

@implementation WeChatTableViewController
static NSString * const  cellIdentifier = @"WeChatTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
}
- (void)setupTableView {
    self.navigationItem.title = @"ONE 精选文章";
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    _ONESEssayList = [[NSMutableArray alloc]init];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"WeChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"WeChatTableViewCell"];
    self.tableView.backgroundColor = BackgroundColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 400;
    [self.tableView addPullToRefreshTarget:self refreshingAction:@selector(pullLoad) loadMoreAction:@selector(pushLoad)];
}
- (void)pullLoad{
    _pageIndex = 0;
    [self loadMoreData];
    [self.tableView endRefreshing];
}
-(void)pushLoad {
    if (_ONESEssayList.lastObject) {
        ONESEssayModel *model = _ONESEssayList.lastObject;
        _pageIndex = model.index;
        [self loadMoreData];
    }
    
    
}
- (void)loadMoreData {
    NSString *index = [NSString stringWithFormat:@"%ld",_pageIndex];
    
    __weak __typeof(self)wself = self;
    [XPAPI getOnesEssayListAtIndex:index needCache:YES succeed:^(BOOL fromCache, ONESBaseModel *onesModel) {
        NSError *erroe;
        if (!fromCache) {
            [wself.tableView endRefreshing];
        }
        NSArray *list = [ONESEssayModel arrayOfModelsFromDictionaries:onesModel.data error:&erroe ];
        if (wself.pageIndex > 1 && fromCache) {
            return;
        }
        if (list.count >0) {
            if (wself.pageIndex == 0) {
                [wself.ONESEssayList removeAllObjects];
            }
            for (ONESEssayModel *model in list) {
                [wself.ONESEssayList addObject:model];
            }
        }
        
        [wself.tableView reloadData];

    } fail:^(NSError *error) {
        [wself.tableView endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _ONESEssayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    __weak __typeof(self)weakSelf = self;
    [cell updataForEssayModel:[_ONESEssayList  objectAtIndex:indexPath.section] reloadCompleted:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _presentRect = [cell convertRect:cell.contentView.frame toView:self.tableView.superview];
    if (_presentRect.origin.y < 64) {
        CGFloat subHeight = _presentRect.origin.y - 64;
        _presentRect.origin.y = 64;
        _presentRect.size.height += subHeight;
    }
    ONESEssayModel *model = [_ONESEssayList  objectAtIndex:indexPath.section];
    EssayContentViewController *vc = [[EssayContentViewController alloc]init];
    vc.essayID = model.essayID;
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:vc];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [GloablTransitionAnimation transitionWithTransitionType:TransitionAnimationTypePresent scadeRect:_presentRect];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [GloablTransitionAnimation transitionWithTransitionType:TransitionAnimationTypeDismiss scadeRect:CGRectMake(0, 300, UI_SCREEN_WIDTH, 300)];
}
@end
