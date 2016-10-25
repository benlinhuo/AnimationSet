//
//  ViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/8/22.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import  <CoreGraphics/CoreGraphics.h>
#import "ViewController.h"
#import "TransitionViewController.h"
#import "CABasicAnimationController.h"
#import "CAKeyframeViewController.h"
#import "CAAnimationGroupViewController.h"
#import "CATransitionViewController.h"
#import "CGAffineTransformViewController.h"
#import "UIViewTransitionViewController.h"
#import "MaskLayerPauseViewController.h"
#import "SpringAnimationViewController.h"

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
NSString * const kYAxisTransform = @"transform.rotation.y";



@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画集锦";
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setAnimate];
}

- (void)setAnimate
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //例子发射位置
    snowEmitter.emitterPosition = CGPointMake(120,20);
    //发射源的尺寸大小
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 20, 20);
    //发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    //创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake.birthRate = 1.0;
    snowflake.lifetime = 120.0;
    //粒子速度
    snowflake.velocity =10.0;
    //粒子的速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"DazFlake"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:0.200 green:0.258 blue:0.543 alpha:1.000] CGColor];
    
    //创建星星形状的粒子
    CAEmitterCell *snowflake1 = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake1.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake1.birthRate = 1.0;
    snowflake1.lifetime = 120.0;
    //粒子速度
    snowflake1.velocity =10.0;
    //粒子的速度范围
    snowflake1.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake1.yAcceleration = 2;
    //周围发射角度
    snowflake1.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake1.spinRange = 0.25 * M_PI;
    //粒子的内容和内容的颜色
    snowflake1.contents = (id)[[UIImage imageNamed:@"DazStarOutline"] CGImage];
    snowflake1.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    //粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor redColor] CGColor];
    
    snowEmitter.emitterCells = [NSArray arrayWithObjects:snowflake,snowflake1,nil];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        // 基础动画例子
        return 6;
        
    } else {
        // 高级动画
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"基础动画案例";
    } else {
        return @"高级动画案例";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                CABasicAnimationController *vc = [[CABasicAnimationController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                CAKeyframeViewController *vc = [[CAKeyframeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                CAAnimationGroupViewController *vc = [CAAnimationGroupViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                CATransitionViewController *vc = [CATransitionViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                CGAffineTransformViewController *vc = [CGAffineTransformViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                UIViewTransitionViewController *vc = [UIViewTransitionViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }

    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                [self transitionViewController];
            }
                break;
            case 1:
            {
                MaskLayerPauseViewController *vc = [MaskLayerPauseViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                SpringAnimationViewController *vc = [SpringAnimationViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }

    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dequeueIdentifier = @"dequeueIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueIdentifier];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"CABasicAnimation";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"CAKeyframeAnimation";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"CAAnimationGroup";
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"CATransition";
            }
                break;
            case 4:
            {
                cell.textLabel.text = @"CGAffineTransform";
            }
                break;
            case 5:
            {
                cell.textLabel.text = @"UIView类方法实现转场动画";
            }
                break;
            default:
                break;
        }
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"ViewController 旋转切换";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"动画暂停实例";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"简单的阻尼弹簧动画";
            }
                break;
            default:
                break;
        }
    }
    
    
    return cell;
}

#pragma mark - event

+ (CABasicAnimation *)animationWithKeyPath:(NSString *)keyPath
                                  duration:(CFTimeInterval)duration
                                 fromValue:(id)from
                                   toValue:(id)to{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.fromValue = from;
    animation.toValue = to;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // animation.fillMode = kCAFillModeBackwards;
    return animation;
}

+ (CABasicAnimation *)transformAxisAnimationforLayer:(CALayer *)layer
                                            withAxis:(NSString *)axis
                                         WithDegrees:(CGFloat)degrees
                                     withAnchorPoint:(CGPoint)anchorPoint
                                     withPerspective:(BOOL)isPerspective
{
    if (isPerspective) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        layer.transform = transform;
    }else{
        layer.transform = CATransform3DIdentity;
    }
    
    layer.anchorPoint = anchorPoint;
    CABasicAnimation *animation = [self.class animationWithKeyPath:axis duration:1 fromValue:0 toValue:@(DEGREES_TO_RADIANS(degrees))];
    animation.removedOnCompletion = YES;
    animation.autoreverses = NO;
    return animation;
}


- (void)transitionViewController
{
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = @"oglFlip"; // 页面旋转
    transition.subtype = kCATransitionFromLeft;
    //    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    TransitionViewController *vc = [TransitionViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter / setter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 45;
    }
    return _tableView;
}

@end
