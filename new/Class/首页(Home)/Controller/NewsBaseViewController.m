//
//  NewsBaseViewController.m
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "NewsBaseViewController.h"

@interface NewsBaseViewController ()

@end

@implementation NewsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, UI_SCREEN_WIDTH, 40)];
    lab.text = @"sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
    [self.view addSubview:lab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
