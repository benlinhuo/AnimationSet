//
//  UIViewTransitionViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/24.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "UIViewTransitionViewController.h"

@interface UIViewTransitionViewController ()

@property (nonatomic, strong) UIView *demoView;
@property (nonatomic, strong) UIView *toView;

@end

@implementation UIViewTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.demoView];
    
    NSLog(@"origin.x = %f, origin.y = %f", self.demoView.bounds.origin.x, self.demoView.bounds.origin.y);
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"单视图",@"双视图",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self singleViewTransition];
            break;
        case 1:
            [self doubleViewTransition];
            break;
        default:
            break;
    }
}

- (void)singleViewTransition
{
    [UIView transitionWithView:self.demoView duration:1.f options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlDown) animations:^{
        [UIView animateWithDuration:0.5 animations:^{
            self.demoView.alpha = 0.4;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.f animations:^{
                self.demoView.alpha = 1.0;
            }];
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"动画完成!");
    }];
}

- (void)doubleViewTransition
{
    [UIView transitionFromView:self.demoView toView:self.toView duration:1.f options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlDown) completion:^(BOOL finished) {
        NSLog(@"动画结束啦啦啦！");
    }];
}

#pragma mark - getter
- (UIView *)demoView
{
    if (!_demoView) {
        _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 100, 100, 100)];
        _demoView.backgroundColor = [UIColor redColor];
    }
    return _demoView;
}

- (UIView *)toView
{
    if (!_toView) {
        _toView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 60, 60)];
        _toView.backgroundColor = [UIColor blueColor];
    }
    return _toView;
}

@end
