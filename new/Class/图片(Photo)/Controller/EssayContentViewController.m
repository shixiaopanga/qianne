//
//  EssayContentViewController.m
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "EssayContentViewController.h"
#import "XPAPI.h"
#import "EssayContentModel.h"

@interface EssayContentViewController ()
@property (nonatomic,strong) UIWebView *contentView;
@property (nonatomic,strong) EssayContentModel *contentModel;
@end

@implementation EssayContentViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [super viewDidLoad];
    
}

- (void)loadData {
    if (!_contentModel) {
        _contentModel = [[EssayContentModel alloc]init];
    }
    __weak __typeof(self)weakSelf = self;
    [XPAPI getOnesEssayContentFromEssayID:@"2153" needCache:YES succeed:^(BOOL fromCache, ONESBaseModel *onesModel) {
        NSError *error;
        _contentModel = [[EssayContentModel alloc]initWithDictionary:onesModel.data error:&error];
        [weakSelf updataWebView];
    } fail:^(NSError *error) {
        
    }];
}
- (void)updataWebView {
    _contentView = [[UIWebView alloc]initWithFrame: CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [self.view addSubview:_contentView];
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 10px; background-color: %@;\">", @"#ffffff", @"#ffffff"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 34px; margin-left: 15px;\">%@</p>", @"#5A5A5A", _contentModel.title]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章作者 --><p style=\"color: %@; font-size: 14px; font-weight: bold; margin-left: 15px; margin-top: -15px;\">%@</p><p></p>", @"#5A5A5A", @"小胖"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", @"#333333", _contentModel.content]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章责任编辑 --><p style=\"color: %@; font-size: 15px; font-style: oblique; margin-left: 15px;\">%@</p></div></body>", @"#333333", _contentModel.editor]];
    NSLog(@"%@",_contentModel.content)
    [_contentView loadHTMLString:HTMLContent baseURL:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
