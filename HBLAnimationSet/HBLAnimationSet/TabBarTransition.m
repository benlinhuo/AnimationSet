//
//  TabBarTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TabBarTransition.h"

@interface TabBarTransition ()

@property (nonatomic, strong) UIViewController *fromVC;
@property (nonatomic, strong) UIViewController *toVC;

@end

@implementation TabBarTransition

- (instancetype)initWithFromVC:(UIViewController *)fromVC ToVC:(UIViewController *)toVC
{
    self =  [super init];
    if (self) {
        self.fromVC = fromVC;
        self.toVC = toVC;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

// 因为添加一个 UIViewController 使用的方式是 Present 方式，所以如下这个代理方法就只需要处理 present 和 dismiss 两种即可
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    // 每一个 ViewController 切换的时候，都是从右往左平滑
    CGFloat xStartOfToVC = SCREEN_WIDTH;
    CGFloat xEndOfToVC = 0;
    
    [containerView addSubview:self.toVC.view];
    
    self.toVC.view.frame = CGRectMake(xStartOfToVC, CGRectGetMinY(self.toVC.view.frame), CGRectGetWidth(self.toVC.view.frame), CGRectGetHeight(self.toVC.view.frame));
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        self.toVC.view.frame = CGRectMake(xEndOfToVC, CGRectGetMinY(self.toVC.view.frame), CGRectGetWidth(self.toVC.view.frame), CGRectGetHeight(self.toVC.view.frame));
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

@end
