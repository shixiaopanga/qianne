//
//  HomeViewController.m
//  new
//
//  Created by lzd on 2017/3/27.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "HomeViewController.h"
#import "SlumpCollectionViewFlowLayout.h"
#import "SlumpCollectionViewCell.h"
#import "SlumpBar.h"
#import "NewsBaseViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SlumpBarDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) SlumpBar *titleSlumpBar;
@property(nonatomic, strong) NSMutableArray *childViewControllerArray;
@end

@implementation HomeViewController
static NSString * const SlumpCollectionIndentifier = @"SlumpCollectionIndentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}
- (void)setSubView {
    _titleSlumpBar = [[SlumpBar alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-32, 44)];
    [_titleSlumpBar setSlumpTitles:@[@"头条",@"社会",@"国内",@"国外",@"娱乐",@"军事",@"科技",@"财经"]];
    _titleSlumpBar.delegate = self;
    self.navigationItem.titleView = _titleSlumpBar;
    
    _childViewControllerArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<8; i++) {
        NewsType type = NewsTypeTop + i;
        NewsBaseViewController *newVC = [[NewsBaseViewController alloc]init];
        newVC.type = type;
        [self addChildViewController:newVC];
        [_childViewControllerArray addObject:newVC];

    }
    [self.view addSubview:self.collectionView];
}
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        SlumpCollectionViewFlowLayout *layout = [[SlumpCollectionViewFlowLayout alloc]init:CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-113)];
        CGRect frame = CGRectMake(0, 0, UI_SCREEN_WIDTH+5, UI_SCREEN_HEIGHT);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        // 注册
        [_collectionView registerClass:[SlumpCollectionViewCell class] forCellWithReuseIdentifier:SlumpCollectionIndentifier];
    }
    
    return _collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <SlumpBarDelegate>
- (void)SlumpBar:(SlumpBar *)slumBar didSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    SlumpCollectionViewCell *cell = (SlumpCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) {
        [_collectionView reloadData];
        [_collectionView layoutIfNeeded];
        cell = (SlumpCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    }
    [cell layoutSubviews];
}
#pragma mark - <UIScrollViewDelegate>

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//
//    *targetContentOffset = scrollView.contentOffset;
//    float pageWidth = (float)_collectionView.bounds.size.width;
//    int minSpace = 5;
//    
//    int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5;
//    if (cellToSwipe < 0) {
//        cellToSwipe = 0;
//    } else if (cellToSwipe >= _childViewControllerArray.count) {
//        cellToSwipe = _childViewControllerArray.count - 1.0;
//    }
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    [_titleSlumpBar setTitleBtnIndex:cellToSwipe];
//
//}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _childViewControllerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SlumpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SlumpCollectionIndentifier forIndexPath:indexPath];
    NewsBaseViewController *vc = (NewsBaseViewController *)[_childViewControllerArray objectAtIndex:indexPath.row];
    cell.showView = vc.view;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}
@end
