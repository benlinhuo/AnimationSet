//
//  SpringAnimationViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/25.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "SpringAnimationViewController.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface SpringAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView *springView;

@end

@implementation SpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.springView.frame = CGRectMake(0, 150, 200, 200);
    self.springView.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
    
    /**
     * usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
     initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果
     */

    [UIView animateWithDuration:1. delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.springView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}


@end
