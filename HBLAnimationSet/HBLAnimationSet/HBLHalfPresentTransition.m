//
//  HBLHalfPresentTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLHalfPresentTransition.h"

@implementation HBLHalfPresentTransition

- (void)transitionPresent
{
    // 对 fromView 进行截屏（因为要保留状态栏等整个屏幕的内容）
    UIView *snapView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    snapView.frame = self.fromView.frame;
    [self.containerView addSubview:snapView];
    
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    snapView.userInteractionEnabled = YES;
    [snapView addGestureRecognizer:dismissTap];
    
    CGRect originFrame = CGRectMake(0, CGRectGetHeight(self.toView.frame), CGRectGetWidth(self.toView.frame), CGRectGetHeight(self.toView.frame));
    CGFloat y = originFrame.origin.y / 2;
    CGRect destinationFrame = originFrame;
    destinationFrame.origin.y = y;
    
    self.toView.frame = originFrame;
    [self.containerView addSubview:self.toView];
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.toView.frame = destinationFrame;
        self.fromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        snapView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        
    } completion:^(BOOL finished) {
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

- (void)transitionDismiss
{
    CGRect destinationFrame = CGRectMake(0, CGRectGetHeight(self.fromView.frame), CGRectGetWidth(self.fromView.frame), CGRectGetHeight(self.fromView.frame));
    
    CGRect originFrame = destinationFrame;
    originFrame.origin.y = destinationFrame.origin.y / 2;
    
    // 获取背景图（firstView）的截图
    // 另一种给被覆盖 View 截图
    UIGraphicsBeginImageContextWithOptions(self.toView.frame.size, YES, 0);
    // 将要截图的 view 的内容渲染到 image context 中
    [self.toView drawViewHierarchyInRect:self.toView.frame afterScreenUpdates:YES];
    UIImage *snapImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapImgView = [[UIImageView alloc] initWithFrame:self.toView.frame];
    snapImgView.image = snapImg;
    [self.containerView addSubview:snapImgView];
    
    snapImgView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    self.toView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [self.containerView addSubview:self.toView];
    [self.containerView addSubview:self.fromView];
    self.fromView.frame = originFrame;
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
        self.fromView.frame = destinationFrame;
        self.toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        snapImgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

- (void)dismissVC
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

@end
