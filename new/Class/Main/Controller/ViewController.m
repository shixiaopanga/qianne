//
//  ViewController.m
//  new
//
//  Created by lzd on 2017/3/21.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "ViewController.h"
#import "XPAPI.h"
#import "WaveView.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    param[@"type"] = @"top";
//    param[@"key"] = @"400a40e5b5a7a7dbb6bb597a781e6360";
//    [XPAPI get:@"http://v.juhe.cn/toutiao/index" parameters:param needCache:YES succeed:^(BOOL needCache,XPResponseModel *model){
//        
//        NSLog(@"%@", model);
//    }fail:^(id error) {
//    }];

    WaveView *vi = [[WaveView alloc]initWithFrame:CGRectMake(0, 0, 375, 200) waveColor:[UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:0.6]];
    [self.view addSubview:vi];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
