//
//  MainTabBarController.m
//  new
//
//  Created by lzd on 2017/3/25.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"
#import "WeChatTableViewController.h"
#import "MineViewController.h"
#import "XPAPI.h"
#import "ONESEssayModel.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControl];
}
- (void)initControl
{
    self.tabBar.tintColor = ThemeColor;
    HomeViewController *home = [[HomeViewController alloc]init];
    [self setupChildViewController:home title:@"首 页" imageName:@"tab_home" selectedImage:@"tab_home_sl"];
    
    WeChatTableViewController *photo = [[WeChatTableViewController alloc]init];
    [self setupChildViewController:photo title:@"公众号" imageName:@"tab_photo" selectedImage:@"tab_photo_sl"];
    
    UIViewController *video = [[UIViewController alloc]init];
    [self setupChildViewController:video title:@"视 频" imageName:@"tab_video" selectedImage:@"tab_video_sl"];
    
     MineViewController *mineVc = [[MineViewController alloc]init];
    [self setupChildViewController:mineVc title:@"我 的" imageName:@"tab_mine" selectedImage:@"tab_mine_sl"];
    
}
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage {
    
    //设置控制器属性
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //包装一个导航控制器
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
