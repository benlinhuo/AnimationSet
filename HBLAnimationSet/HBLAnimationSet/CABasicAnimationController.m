//
//  CABasicAnimationController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "CABasicAnimationController.h"

@interface CABasicAnimationController () <CAAnimationDelegate>

@property (nonatomic , strong) UIView *demoView;

@end

@implementation CABasicAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CABasicAnimation";
}

- (void)initView{
    [super initView];
    [self.view addSubview:self.demoView];
}

#pragma mark - 父类方法重置
- (NSArray *)operateTitleArray
{
    return [NSArray arrayWithObjects:@"位移",@"透明度",@"缩放",@"旋转",@"背景色", @"移动", nil];
}

- (void)clickBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self opacityAniamtion];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        case 4:
            [self backgroundAnimation];
            break;
        case 5:
            [self translationAnimation];
            break;
            
        default:
            break;
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"（CAAnimationDelegate）动画代理方法：animationDidStart = %@", anim);
}

#pragma mark - 各类动画
/**
 * 有哪些 keyPath 可以使用这个 CABasicAnimation
 */
- (void)positionAnimation
{
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT / 2 -75)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2 - 75)];
    animation.duration = 1.f;// 1 秒
    // fillMode只会在removeOnCompletion设置为NO的时候才会生效
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
   
    animation.beginTime = CACurrentMediaTime() + 1; // 1 秒后执行
    animation.delegate = self;
    [_demoView.layer addAnimation:animation forKey:@"positionYAnimation"]; // 此处的 key 就只是给这个动画命名而已
    
    
////    使用UIView Animation 代码块调用
//        _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
//        [UIView animateWithDuration:1.0f animations:^{
//            _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
//        } completion:^(BOOL finished) {
//            _demoView.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50, 50, 50);
//        }];
//    
////    使用UIView [begin,commit]模式
//        _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:1.0f];
//        _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
//        [UIView commitAnimations];
    
}

- (void)opacityAniamtion
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.1f];
    // 使用 byValue 和 fromValue ，那 toValue=fromValue+byValue。使用 byValue 和 toValue，那 fromValue=toValue - byValue。所以 fromValue、byValue、toValue，只能使用三者之二，不能三者同时使用
    animation.byValue = [NSNumber numberWithFloat:0.5f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2.f;
    animation.repeatCount = 2;
    [_demoView.layer addAnimation:animation forKey:@"opacityAniamtion"];
}

- (void)scaleAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.toValue = [NSNumber numberWithFloat:0.2f]; // 0.2倍
    animation.duration = 1.0f;
    // kCAFillModeBackwards 表示回到动画前的位置
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.autoreverses = YES; // 动画结束时是否执行逆动画。表示动画结束之后，再次执行反方向的动画，此处是先缩小至0.2倍，然后反方向放大到原来倍数（反方向动画）
    
    [_demoView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)rotateAnimation
{
    // 方式一
//        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
//        anima.toValue = [NSNumber numberWithFloat:M_PI];
//        anima.duration = 1.0f;
//        [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    // 方式二
//        //valueWithCATransform3D作用与layer
//        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
//        anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
//        anima.duration = 1.0f;
//        anima.repeatCount = MAXFLOAT;
//        [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    // 方式三
    //CGAffineTransform作用于View
    _demoView.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)backgroundAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue =(id) [UIColor greenColor].CGColor;
    animation.duration = 1.0f;
//    animation.repeatCount = MAXFLOAT;
    [_demoView.layer addAnimation:animation forKey:@"backgroundAnimation"];
}

- (void)translationAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = [NSNumber numberWithFloat:10.f];
    animation.toValue = [NSNumber numberWithFloat:100.f];
    animation.duration = 1.f;
    [_demoView.layer addAnimation:animation forKey:@"translationAnimation"];

}

#pragma mark - getter

- (UIView *)demoView
{
    if (!_demoView) {
        _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 100, 100, 100)];
        _demoView.backgroundColor = [UIColor blueColor];
    }
    return _demoView;
}

@end
