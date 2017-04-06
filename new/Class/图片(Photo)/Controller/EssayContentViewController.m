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
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"文章鉴赏";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navi_cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
    _contentView = [[UIWebView alloc]initWithFrame: CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [self loadData];
    
}
- (void)leftBarButtonClick:(UIBarButtonItem *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loadData {
    if (!_contentModel) {
        _contentModel = [[EssayContentModel alloc]init];
    }
    __weak __typeof(self)weakSelf = self;
    [XPAPI getOnesEssayContentFromEssayID:_essayID needCache:YES succeed:^(BOOL fromCache, ONESBaseModel *onesModel) {
        NSError *error;
        _contentModel = [[EssayContentModel alloc]initWithDictionary:onesModel.data error:&error];
        [weakSelf updataWebView];
    } fail:^(NSError *error) {
        
    }];
}
- (void)updataWebView {
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 10px; background-color: %@;\">", @"#ffffff", @"#ffffff"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 23px; font-weight: bold; margin-top: 34px; margin-left: 15px;\">%@</p>", @"#3b3b3b", _contentModel.title]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章作者 --><p style=\"color: %@; font-size: 16px; font-weight: bold; margin-left: 15px; margin-top: -15px;\">文 | %@</p><p></p>", @"#3b3b3b", _contentModel.author]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", @"#696969", _contentModel.content]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章责任编辑 --><p style=\"color: %@; font-size: 15px;  margin-top: 30px; margin-left: 15px;\">%@</p>", @"#333333", _contentModel.editor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章版权所有 --><p style=\"color: %@; font-size: 12px;  margin-left: 15px; margin-right: 15px; \">%@</p></div></body>", @"#333333", @"*本文数据由 PANGREAD 采集自 ONE，所有权归ONE所有"]];
    [_contentView loadHTMLString:HTMLContent baseURL:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
