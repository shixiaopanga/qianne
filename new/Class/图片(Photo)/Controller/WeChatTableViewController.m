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
#import "WeChatEssayList.h"
#import "WeChatEssayModel.h"
#import "GloablTransitionAnimation.h"
#import "MineViewController.h"

@interface WeChatTableViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, copy) NSMutableArray *weChatEssayList;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation WeChatTableViewController
static NSString * const  cellIdentifier = @"WeChatTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
}
- (void)setupTableView {
    self.navigationItem.title = @"微信精选文章";
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    _weChatEssayList = [[NSMutableArray alloc]init];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"WeChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"WeChatTableViewCell"];
    self.tableView.backgroundColor = BackgroundColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 400;
    [self.tableView addPullToRefreshTarget:self refreshingAction:@selector(pullLoad) loadMoreAction:@selector(pushLoad)];
}
- (void)pullLoad{
    _pageIndex = 1;
    [self loadMoreData];
}
-(void)pushLoad {
    _pageIndex += 10;
    [self loadMoreData];
}
- (void)loadMoreData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"channelid"] = [NSString stringWithFormat:@"%d",1];
    params[@"start"] = [NSString stringWithFormat:@"%ld",_pageIndex];
    params[@"appkey"] = @"80b2ac506f71f10a";
    
    __weak __typeof(self)wself = self;
    [XPAPI getWeChatEssayWithParameters:params needCache:YES succeed:^(BOOL fromCache,XPResponseModel *model){
    NSError *erroe;
        if (!fromCache) {
            [wself.tableView endRefreshing];
        }
//        wself.weChatEssayList
        WeChatEssayList *listModel = [[WeChatEssayList alloc]initWithDictionary:model.result error:&erroe];
        NSArray *list = listModel.list;
        if (wself.pageIndex > 1 && fromCache) {
            return;
        }
        if (list.count >0) {
            if (wself.pageIndex == 1) {
                [wself.weChatEssayList removeAllObjects];
            }
            for (WeChatEssayModel *model in list) {
                [wself.weChatEssayList addObject:model];
            }
        }
        if (listModel.start < listModel.total) {
            [wself.tableView addPushToRefreshTarget:self loadMoreAction:@selector(pushLoad)];
        }else {
            [wself.tableView removePush];
        }
        [wself.tableView reloadData];
        
    }fail:^(id error) {
        [wself.tableView endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _weChatEssayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    __weak __typeof(self)weakSelf = self;
    [cell updataForEssayModel:[_weChatEssayList  objectAtIndex:indexPath.section] reloadCompleted:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    let vc = ChooseAccountBookController()
//    let navi = UINavigationController(rootViewController: vc)
//    navi.modalPresentationStyle = .custom
//    navi.transitioningDelegate  = self
//    present(navi, animated: true, completion: nil)
    
    MineViewController *vcv = [[MineViewController alloc]init];
    vcv.transitioningDelegate = self;
    vcv.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vcv animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [GloablTransitionAnimation transitionWithTransitionType:TransitionAnimationTypePresent scadeRect:CGRectMake(0, 300, UI_SCREEN_WIDTH, 300)];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [GloablTransitionAnimation transitionWithTransitionType:TransitionAnimationTypeDismiss scadeRect:CGRectMake(0, 300, UI_SCREEN_WIDTH, 300)];
}
@end
