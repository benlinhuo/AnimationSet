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
#import "TransitionListViewController.h"
#import "NewsViewController.h"

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
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        // 基础动画例子
        return 6;
        
    } else {
        // 高级动画
        return 5;
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
            case 3:
            {
                TransitionListViewController *vc = [TransitionListViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                NewsViewController *vc = [NewsViewController new];
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
            case 3:
            {
                cell.textLabel.text = @"各类转场动画";
            }
                break;
            case 4:
            {
                cell.textLabel.text = @"ChildViewController";
            }
            
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
