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
            [self dismissAnimation:transitionContext];
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *blackView = [[UIView alloc]initWithFrame:tempView.bounds];
    blackView.backgroundColor = RGBA(0, 0, 0, 0);
    [tempView addSubview:blackView];
    fromVC.view.hidden = YES;
    
    UIView *shadeView = [[UIView alloc]initWithFrame:_rect];
    shadeView.backgroundColor = [UIColor whiteColor];
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView addSubview:shadeView];
    
    [UIView animateWithDuration:0.5 animations:^{
        tempView.transform = CGAffineTransformMakeScale(0.95, 0.95);
        blackView.backgroundColor = RGBA(0, 0, 0, 0.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            shadeView.frame = toVC.view.bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                fromVC.view.hidden = NO;
                [tempView removeFromSuperview];
            }else {
                [containerView addSubview:toVC.view];
                [shadeView removeFromSuperview];
            }
            
            
        }];
    }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *tempView = [transitionContext containerView].subviews[0];
    [UIView animateWithDuration:0.5 animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(0, UI_SCREEN_HEIGHT);
        tempView.transform = CGAffineTransformIdentity;
        tempView.subviews[1].backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        if ([transitionContext transitionWasCancelled]) {
            toVC.view.hidden = NO;
//            [tempView removeFromSuperview];
//        }else {
//            [containerView addSubview:toVC.view];
//            [shadeView removeFromSuperview];
//        }
    }];
}
@end
