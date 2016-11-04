//
//  VCCustomTransitioning.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/27.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "VCCustomTransitioning.h"
#import "vcTransitionViewController.h"
#import "SingleViewController.h"

@interface VCCustomTransitioning () {
    TransitionType _type;
}

@property (nonatomic, strong) UINavigationController *currentNav;

@end


@implementation VCCustomTransitioning

- (instancetype)initWithType:(TransitionType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case TransitionTypePush:
        {
            [self pushTransition:transitionContext];
        }
            break;
        case TransitionTypePresent:
        {
            [self presentTransition:transitionContext];
        }
            break;
        case TransitionTypePop:
        {
            [self popTransition:transitionContext];
        }
            break;
        case TransitionTypeDimissed:
        {
            [self dismissTransition:transitionContext];
        }
            break;
            
        default:
            break;
    }
}

- (void)pushTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    vcTransitionViewController *fromVC = (vcTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SingleViewController *toVC = (SingleViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self entryTransition:transitionContext FromVC:fromVC toVC:toVC];
}

- (void)popTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    SingleViewController *fromVC = (SingleViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    vcTransitionViewController *toVC = (vcTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self quitTransition:transitionContext FromVC:fromVC toVC:toVC];
}

#pragma mark
- (void)presentTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 因为是 UINavigationController -> UIViewController
    UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    vcTransitionViewController *fromVC = (vcTransitionViewController *)nav.topViewController;
    SingleViewController *toVC = (SingleViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self entryTransition:transitionContext FromVC:fromVC toVC:toVC];
}

- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    SingleViewController *fromVC = (SingleViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.currentNav = nav;
    vcTransitionViewController *toVC = (vcTransitionViewController *)nav.topViewController;
    
    [self quitTransition:transitionContext FromVC:fromVC toVC:toVC];
}

#pragma mark - common
- (void)entryTransition:(id <UIViewControllerContextTransitioning>)transitionContext FromVC:(vcTransitionViewController *)fromVC toVC:(SingleViewController *)toVC
{
    if (![fromVC isKindOfClass:[vcTransitionViewController class]] ||
        ![toVC isKindOfClass:[SingleViewController class]]) {
        return;
    }
    
    // 过渡动画时产生的 containerView ，它在动画结束后会自动消失吗？好像不会
    UIView *containerView = [transitionContext containerView];
    
    UITableViewCell *fromCell = [fromVC.tblView cellForRowAtIndexPath:fromVC.currentIndexPath];
    UIView *tempView = [fromCell.imageView snapshotViewAfterScreenUpdates:YES];
    tempView.frame = [fromCell.contentView convertRect:fromCell.imageView.frame toView:containerView];
    fromCell.hidden = YES;
    
    toVC.view.alpha = 0;
    toVC.imgView.hidden = YES;
    
    // 为了视觉效果，切换动画过程中展示的是 containerView
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // 变化两个部分，一个是透明度，还有就是 frame 值（原来是 fromVC 中frame，后来变成了 toVC 的frame）
        toVC.view.alpha = 1.f;
        tempView.frame = [toVC.view convertRect:toVC.imgView.frame toView:containerView];
        
    } completion:^(BOOL finished) {
        toVC.imgView.hidden = NO;
        // tempView 如果此时隐藏，则退出的时候需要重新获取，如果只是隐藏，则是可以通过 containerView 来获取的
        tempView.hidden = YES;
//        [tempView removeFromSuperview];
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)quitTransition:(id <UIViewControllerContextTransitioning>)transitionContext FromVC:(SingleViewController *)fromVC toVC:(vcTransitionViewController *)toVC
{
    if (![toVC isKindOfClass:[vcTransitionViewController class]] ||
        ![fromVC isKindOfClass:[SingleViewController class]]) {
        return;
    }
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    UITableViewCell *toCell = [toVC.tblView cellForRowAtIndexPath:toVC.currentIndexPath];
    tempView.frame = [fromVC.view convertRect:fromVC.imgView.frame toView:containerView];
    fromVC.imgView.hidden = YES;
    
    // 设置初始状态
    toCell.hidden = NO;
    toCell.imageView.hidden = YES;
    tempView.hidden = NO;
    fromVC.imgView.hidden = YES;
    
    if (_type == TransitionTypePop) {
        [containerView insertSubview:toVC.view atIndex:0];
    } else if (_type == TransitionTypeDimissed) {
        [containerView insertSubview:self.currentNav.view atIndex:0];
    }
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [toCell.contentView convertRect:toCell.imageView.frame toView:containerView];
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if ([transitionContext transitionWasCancelled]) { // 手势取消，保留在 fromVC 上
            tempView.hidden = YES;
            fromVC.imgView.hidden = NO;
            
        } else { // 手势成功
            toCell.imageView.hidden = NO;
            [tempView removeFromSuperview];
            
        }
        
    }];
    
}

@end
