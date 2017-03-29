//
//  GloablTransitionAnimation.m
//  new
//
//  Created by lzd on 2017/3/29.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "GloablTransitionAnimation.h"

@implementation GloablTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 5;
}
+ (instancetype)transitionWithTransitionType:(TransitionAnimationType)type scadeRect:(CGRect)rect {
    return [[self alloc]initWithTransitionType:type scadeRect:rect];
    
}

- (instancetype)initWithTransitionType:(TransitionAnimationType)type scadeRect:(CGRect)rect{
    self = [super init];
    if (self) {
        _animationType = type;
        _rect = rect;
    }
    return self;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    switch (_animationType) {
        case TransitionAnimationTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case TransitionAnimationTypeDismiss:
//            [self dismissAnimation:transitionContext];
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    
    UIView *shadeView = [[UIView alloc]initWithFrame:_rect];
    shadeView.backgroundColor = [UIColor redColor];
    
    
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    [containerView addSubview:shadeView];
    
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
//    toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
    //开始动画吧，使用产生弹簧效果的动画API
    
    [UIView animateWithDuration:0.5 delay:1 options:0 animations:^{
        
        tempView.transform = CGAffineTransformMakeScale(0.99, 0.99);
        tempView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            shadeView.frame = toVC.view.bounds;
        }];
    }];
//    [UIView animateWithDuration:25 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
//        shadeView.frame = toVC.view.bounds;
//        tempView.alpha = 0;
//        shadeView.alpha = 0;
//    } completion:^(BOOL finished) {
//        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        //转场失败后的处理
//        if ([transitionContext transitionWasCancelled]) {
//            //失败后，我们要把vc1显示出来
//            fromVC.view.hidden = NO;
//            //然后移除截图视图，因为下次触发present会重新截图
//            [tempView removeFromSuperview];
//            [shadeView removeFromSuperview];
//        }
//    }];
}
@end
