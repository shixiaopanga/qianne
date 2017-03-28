//
//  MineViewController.m
//  new
//
//  Created by lzd on 2017/3/25.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "MineViewController.h"
#import "WaveView.h"

@interface MineViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,WaveViewDelegate> {
    WaveView *titleWave;
    UITableView *mineTableView;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    titleWave = [[WaveView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200) waveColor:[UIColor colorWithRed:0.00 green:0.74 blue:0.55 alpha:0.6]];
    titleWave.delegate = self;
    [self.view addSubview:titleWave];
    
    mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 200)];
    mineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    mineTableView.backgroundColor = BackgroundColor;
    mineTableView.dataSource = self;
    mineTableView.delegate = self;
    mineTableView.scrollEnabled = NO;
    mineTableView.rowHeight = 50;
    [self.view addSubview:mineTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowMine = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowMine animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MineTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"小胖";
    cell.detailTextLabel.text = @"xiaopang";
    cell.imageView.image = [UIImage imageNamed:@"tab_mine"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark - WaveViewDelegate
- (void)editButtonDidClick {
    [titleWave setWithIcon:@"" name:@"sss" state:@"sss"];
}
@end
