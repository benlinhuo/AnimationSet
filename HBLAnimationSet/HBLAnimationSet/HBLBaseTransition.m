//
//  HBLBaseTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLBaseTransition.h"

@implementation HBLBaseTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .5f;
}

// 因为添加一个 UIViewController 使用的方式是 Present 方式，所以如下这个代理方法就只需要处理 present 和 dismiss 两种即可
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    _containerView = [transitionContext containerView];
    
    
    // present 过程中 fromVC 是 UINavigationController。dismiss 过程中，toVC 是 UINavigationController
    _fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // iOS 8 之后才有
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        _fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        _toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
    } else {
        _fromView = _fromVC.view;
        _toView = _toVC.view;
    }
    
    if (_showType == HBLShowViewControllerTypePresent) {
        [self transitionPresent];
        
    } else if (_showType == HBLShowViewControllerTypeDismiss) {
        [self transitionDismiss];
    }
}

// 让父类覆盖实现
- (void)transitionPresent
{

}

- (void)transitionDismiss
{

}


@end
