//
//  CAKeyframeViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/9.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "CAKeyframeViewController.h"

@interface CAKeyframeViewController ()<CAAnimationDelegate>

@property (nonatomic , strong) UIView *demoView;

@end

@implementation CAKeyframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CAKeyframeViewController";
}

- (void)initView{
    [super initView];
    [self.view addSubview:self.demoView];
}

#pragma mark - 父类方法重置
- (NSArray *)operateTitleArray
{
    return [NSArray arrayWithObjects:@"关键帧", @"路径", @"抖动", nil];
}

- (void)clickBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
        case 1:
            [self pathAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
        default:
            break;
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"（CAAnimationDelegate）动画代理方法：animationDidStart = %@", anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束啦！！！！");
}

#pragma mark - 各类动画
- (void)keyFrameAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint point0 = CGPointMake(0, SCREEN_HEIGHT / 2 - 50);
    CGPoint point1 = CGPointMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 2 - 50);
    CGPoint point2 = CGPointMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 2 + 50);
    CGPoint point3 = CGPointMake(SCREEN_WIDTH * 2 / 3, SCREEN_HEIGHT / 2 + 50);
    CGPoint point4 = CGPointMake(SCREEN_WIDTH * 2 / 3, SCREEN_HEIGHT / 2 - 50);
    CGPoint point5 = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2 - 50);
    
    CGFloat w = 8;
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(point0.x, point0.y, w, w)];
    view0.backgroundColor = [UIColor greenColor];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(point1.x, point1.y, w, w)];
    view1.backgroundColor = [UIColor redColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(point2.x, point2.y, w, w)];
    view2.backgroundColor = [UIColor redColor];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(point3.x, point3.y, w, w)];
    view3.backgroundColor = [UIColor redColor];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(point4.x, point4.y, w, w)];
    view4.backgroundColor = [UIColor redColor];
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(point5.x, point5.y, w, w)];
    view5.backgroundColor = [UIColor redColor];
    [self.view addSubview:view0];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];

    
    NSValue *value0 = [NSValue valueWithCGPoint:point0];
    NSValue *value1 = [NSValue valueWithCGPoint:point1];
    NSValue *value2 = [NSValue valueWithCGPoint:point2];
    NSValue *value3 = [NSValue valueWithCGPoint:point3];
    NSValue *value4 = [NSValue valueWithCGPoint:point4];
    NSValue *value5 = [NSValue valueWithCGPoint:point5];
    
    NSNumber *keyTime0 = [NSNumber numberWithFloat:0.f];
    NSNumber *keyTime1 = [NSNumber numberWithFloat:.5f];
    NSNumber *keyTime2 = [NSNumber numberWithFloat:.6f];
    NSNumber *keyTime3 = [NSNumber numberWithFloat:.7f];
    NSNumber *keyTime4 = [NSNumber numberWithFloat:.9f];
    NSNumber *keyTime5 = [NSNumber numberWithFloat:1.f];
    
    // 它会从 value0 开始
    animation.values = @[value0, value1, value2, value3, value4, value5];
    // 为对应的关键帧指定对应的时间点，如果不指定，各个关键帧之间的时间是平分的。取值范围[0,1]。各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
    animation.keyTimes = @[keyTime0, keyTime1, keyTime2, keyTime3, keyTime4, keyTime5];
    animation.duration = 10.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    
    // 动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）；而如果指定了动画模式为kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡。其他动画模式还有：kCAAnimationPaced（均匀执行，会忽略keyTimes）、kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑）、kCAAnimationCubicPaced（平滑均匀执行）
//    animation.calculationMode = kCAAnimationCubic; // 默认是 kCAAnimationLinear
    
    
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    
    [_demoView.layer addAnimation:animation forKey:@"keyframeAnimation"];
}

- (void)pathAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    animation.path = path.CGPath;
    animation.duration = 2.f;
    
    [_demoView.layer addAnimation:animation forKey:@"pathAnimation"];
}

- (void)shakeAnimation
{
    // 抖动效果其实就是让 rotation.z 一直来回旋转
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI / 180 * 4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI / 180 * 4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI / 180 * 4];
    anima.values = @[value1,value2,value3];
    
    CAMediaTimingFunction *function1 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAMediaTimingFunction *function2 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *function3 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anima.timingFunctions = @[function1, function2, function3];
    anima.repeatCount = MAXFLOAT;
    
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
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
