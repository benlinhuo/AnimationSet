//
//  TransitionListViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TransitionListViewController.h"
#import "vcTransitionViewController.h"
#import "TransitionFirstViewController.h"
#import "MyTabBarViewController.h"
#import "TabBarTransition.h"

@interface TransitionListViewController ()<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>

@property (nonatomic, strong) UITableView *tblView;

@end

@implementation TransitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"各类转场动画";
    [self.view addSubview:self.tblView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            vcTransitionViewController *vc = [vcTransitionViewController new];
            vc.showType = ShowTypePush;
            vc.title = @"push/pop 转场动画";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            vcTransitionViewController *vc = [vcTransitionViewController new];
            vc.showType = ShowTypePresent;
            vc.title = @"present/dismiss 转场动画";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        {
            TransitionFirstViewController *firstVC = [[TransitionFirstViewController alloc] init];
            firstVC.transitionType = indexPath.row;
            [self.navigationController pushViewController:firstVC animated:YES];
        }
            break;
        case 6:
        {
            MyTabBarViewController *myTabController = [[MyTabBarViewController alloc] init];
            myTabController.delegate = self;
            [self presentViewController:myTabController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dequeueIdentifier = @"dequeueIdentifierTransition";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueIdentifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"push/pop 转场动画";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"present/dismiss 转场动画";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Bubble"; // 以水波动画的方式扩撒出去
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"HalfPresent"; // 只展示一半页面，背景是上一个页面的缩影
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"RevealLeft"; // 类似于QQ，左侧是个人中心
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"LeftTopPresent"; // 从左上角present展示
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"tabbarcontroller 切换转场动画"; // 从左上角present展示
        }
            break;
        default:
            break;
    }
    
    return cell;
}


- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC
{
    return [[TabBarTransition alloc] initWithFromVC:fromVC ToVC:toVC];
}

- (UITableView *)tblView
{
    if (!_tblView) {
        _tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tblView.backgroundColor = [UIColor whiteColor];
        _tblView.delegate = self;
        _tblView.dataSource = self;
        _tblView.sectionHeaderHeight = 45;
    }
    return _tblView;
}

@end
