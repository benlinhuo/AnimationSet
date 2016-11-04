//
//  HBLBubbleTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLBubbleTransition.h"

@implementation HBLBubbleTransition

/**
 * 不论是 present 过程还是 dismiss 过程，layerView 都是模拟的secondView
 */


- (void)transitionPresent
{
    // 1. 创建一个 layerView 用于模拟水波扩散的动画效果 [本质上，水波扩散，就是一个小圆慢慢放大的过程]
    UIView *layerView = [UIView new];// 它需要是圆形，以中心点往外扩散
    layerView.backgroundColor = self.toView.backgroundColor;
    CGFloat x = fmax(self.bubbleCenter.x, SCREEN_WIDTH);
    CGFloat y = fmax(self.bubbleCenter.y, SCREEN_HEIGHT);
    CGFloat radius = sqrt(x * x + y * y);
    layerView.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    layerView.layer.masksToBounds = YES;
    layerView.layer.cornerRadius = radius;
    layerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    layerView.center = self.bubbleCenter;
    
    [self.containerView addSubview:layerView];
    
    // 2. toView 也要跟着 layerView 一起运动，因为 layerView 只有toView 的背景色，toView 的内容是没有的
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.toVC];
    CGPoint originCenter = self.toView.center;
    self.toView.center = layerView.center;
    self.toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.toView.alpha = 0;
    [self.containerView addSubview:self.toView]; // 先 layerView 再 toView，因为动画过程也是需要展示 toView 的内容
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
        self.toView.alpha = 1;
        self.toView.transform = CGAffineTransformIdentity;
        self.toView.center = originCenter;
        layerView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
         [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

- (void)transitionDismiss
{
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.toVC];
    [self.containerView insertSubview:self.toView belowSubview:self.fromView]; // fromView 就是 present过程中添加的secondView
    
    // layerView 模拟 fromView
    UIView *layerView = [UIView new];
    layerView.backgroundColor = self.fromView.backgroundColor;
    CGFloat x = fmax(self.bubbleCenter.x, SCREEN_WIDTH);
    CGFloat y = fmax(self.bubbleCenter.y, SCREEN_HEIGHT);
    CGFloat radius = sqrt(x * x + y * y);
    layerView.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    layerView.layer.masksToBounds = YES;
    layerView.layer.cornerRadius = radius;
    layerView.center = self.bubbleCenter;
    
    [self.containerView insertSubview:layerView belowSubview:self.fromView]; // layerView 在 toView之上
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
        layerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.fromView.center = self.bubbleCenter;
        
    } completion:^(BOOL finished) {
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

    }];
}

@end
