//
//  HBLBaseTransition.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HBLShowViewControllerType) {
    HBLShowViewControllerTypePresent,
    HBLShowViewControllerTypeDismiss
};

@interface HBLBaseTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) HBLShowViewControllerType showType;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIViewController *fromVC;
@property (nonatomic, strong) UIViewController *toVC;

@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIView *toView;

@end
