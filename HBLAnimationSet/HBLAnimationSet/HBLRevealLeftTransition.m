//
//  HBLRevealLeftTransition.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLRevealLeftTransition.h"

static const NSInteger imgViewTag = 1001;

@implementation HBLRevealLeftTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)transitionPresent
{
    // 只需要fromView 截图覆盖在 toView 上，toView 不用动
    UIGraphicsBeginImageContextWithOptions(self.fromView.frame.size, YES, 0);
    [self.fromView drawViewHierarchyInRect:self.fromView.frame afterScreenUpdates:YES];
    UIImage *snapImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.fromView.frame];
    imgView.image = snapImage;
    imgView.tag = imgViewTag;
    
    [self.containerView addSubview:imgView];
    
    [self.containerView insertSubview:self.toView belowSubview:imgView];
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{

        imgView.center = CGPointMake(self.fromView.center.x * 3 - self.offset, self.fromView.center.y);
        
    } completion:^(BOOL finished) {
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

- (void)transitionDismiss
{
    // 我们可以从上述 containerView 中添加的截图获取
    UIImageView *originImgView = (UIImageView *)[self.containerView viewWithTag:imgViewTag];
    
    CGPoint desitinationCenter = self.toView.center;
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        originImgView.center = desitinationCenter;
        
    } completion:^(BOOL finished) {
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

@end
