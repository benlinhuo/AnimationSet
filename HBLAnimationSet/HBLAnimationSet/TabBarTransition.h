//
//  TabBarTransition.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabBarTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithFromVC:(UIViewController *)fromVC ToVC:(UIViewController *)toVC;

@end
