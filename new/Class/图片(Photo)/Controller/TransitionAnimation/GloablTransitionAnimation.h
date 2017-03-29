//
//  GloablTransitionAnimation.h
//  new
//
//  Created by lzd on 2017/3/29.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitionAnimationType) {
    TransitionAnimationTypePresent = 0,
    TransitionAnimationTypeDismiss
};

@interface GloablTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) TransitionAnimationType animationType;
@property (nonatomic, assign) CGRect rect;
+ (instancetype)transitionWithTransitionType:(TransitionAnimationType)type scadeRect:(CGRect)rect;
- (instancetype)initWithTransitionType:(TransitionAnimationType)type scadeRect:(CGRect)rect;
@end
