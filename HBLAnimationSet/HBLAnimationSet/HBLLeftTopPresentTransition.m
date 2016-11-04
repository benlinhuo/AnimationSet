//
//  HBLLeftTopPresentTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLLeftTopPresentTransition.h"

@implementation HBLLeftTopPresentTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

// 这种动画效果，操作的就是 toView 的展示，简单
- (void)transitionPresent
{
    self.toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.toView.frame = CGRectZero;
    self.toView.alpha = 0;
    
    [self.containerView addSubview:self.toView];
    
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toView.transform = CGAffineTransformIdentity;
        
        CGRect frame = [self.transitionContext finalFrameForViewController:self.toVC];
        NSLog(@"frame = %f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        self.toView.frame = frame;
        self.toView.alpha = 1.f;
        
        
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

    }];
}

- (void)transitionDismiss
{
    // fromView 是在 present 过程中添加的，所以表明了containerView 在 present之后不会消失然后dismiss重新建立
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
        self.fromView.frame = CGRectZero;
        self.fromView.alpha = 0;
        self.fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

    }];
}

@end
