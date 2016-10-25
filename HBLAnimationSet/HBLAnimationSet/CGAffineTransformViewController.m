//
//  CGAffineTransformViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/24.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "CGAffineTransformViewController.h"

@interface CGAffineTransformViewController ()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation CGAffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.demoView];
}


-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"缩放",@"旋转",@"组合1",@"组合2",@"反转",@"点应用", @"区域应用",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self scaleAnimation];
            break;
        case 2:
            [self rotateAnimation];
            break;
        case 3:
            [self combinationAnimation1];
            break;
        case 4:
            [self combinationAnimation2];
            break;
        case 5:
            [self invertAnimation];
        case 6:
            [self pointApplyAnimation];
        case 7:
            [self sizeApplyAnimation];
            break;
        default:
            break;
    }
}

#pragma mark - 动画方法
// 所有的动画之前都要先归位才行

- (void)positionAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    // 这也可以采用 CAAnimation 那种写法，但这种更简单
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
    
    // 判断两个转换是否相等的含义
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(100, 100);
    CGAffineTransform t2 = CGAffineTransformMakeTranslation(100, 100);
    NSLog(@"t1是否等于t2：%d", CGAffineTransformEqualToTransform(t1, t2));
}

- (void)scaleAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    // 这也可以采用 CAAnimation 那种写法，但这种更简单
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)rotateAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    // 这也可以采用 CAAnimation 那种写法，但这种更简单
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI / 2);// 旋转 90 度
    }];
}

- (void)combinationAnimation1
{
    // 三种叠加效果
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        _demoView.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
}

- (void)combinationAnimation2
{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform t1 = CGAffineTransformMakeRotation(M_PI / 2);
        CGAffineTransform t2 = CGAffineTransformMakeScale(0.5, 0.5);
        _demoView.transform = CGAffineTransformConcat(t1, t2);
    }];
}

- (void)invertAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    // 这也可以采用 CAAnimation 那种写法，但这种更简单
    [UIView animateWithDuration:1.0f animations:^{
        // 我们指定放大2倍，CGAffineTransformInvert 表示，从2倍状态缩放到正常大小，即反向动画，之前从正常状态到2倍大小是不管的
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}

- (void)pointApplyAnimation
{
    // 把变化应用到一个点上
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(100, 100);
        CGPoint point = CGPointApplyAffineTransform(CGPointMake(50, 50), t1);
        NSLog(@"point.x = %f, point.y = %f", point.x, point.y);
    }];
    
}

- (void)sizeApplyAnimation
{
    // 把变化应用到一个区域上
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform t1 = CGAffineTransformMakeScale(2, 2);
        CGSize size = CGSizeApplyAffineTransform(CGSizeMake(50, 50), t1);
        NSLog(@"size.width = %f, size.height = %f", size.width, size.height);
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

@end
