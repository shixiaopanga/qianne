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



@interface WeChatTableViewController ()
@property (nonatomic, copy) NSArray *weChatEssayList;
@end

@implementation WeChatTableViewController
static NSString * const  cellIdentifier = @"WeChatTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
}
- (void)setupTableView {
    self.navigationItem.title = @"微信精选文章";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"WeChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"WeChatTableViewCell"];
    self.tableView.backgroundColor = BackgroundColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 400;
    [self.tableView addPullToRefreshTarget:self refreshingAction:@selector(loadMoreData) loadMoreAction:@selector(loadmore)];
}
- (void) loadMoreData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"channelid"] = [NSString stringWithFormat:@"%d",8];
    params[@"start"] = [NSString stringWithFormat:@"%d",1];
    params[@"num"] = [NSString stringWithFormat:@"%d",10];
    params[@"appkey"] = @"80b2ac506f71f10a";
    __weak __typeof(self)wself = self;
    [XPAPI getWeChatEssayWithParameters:params needCache:YES succeed:^(BOOL needCache,XPResponseModel *model){
    NSError *erroe;
        wself.weChatEssayList = [[WeChatEssayList alloc]initWithDictionary:model.result error:&erroe].list;
        [wself.tableView reloadData];
        [wself.tableView endRefreshing];
    }fail:^(id error) {
        [wself.tableView endRefreshing];
    }];
}
-(void) loadmore {
    NSLog(@"loadmore");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return _weChatEssayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    __weak __typeof(self)wself = self;
    [cell updataForEssayModel:[_weChatEssayList  objectAtIndex:indexPath.section] reloadCompleted:^{
        [wself.tableView reloadData];
    }];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
