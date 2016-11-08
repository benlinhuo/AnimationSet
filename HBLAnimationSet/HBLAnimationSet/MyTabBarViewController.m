//
//  MyTabBarViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "TabBarTransition.h"

@interface MyTabBarViewController ()<HomeViewControllerDelegate, MyViewControllerDelegate>

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    HomeViewController *firstVC = [HomeViewController new];
    firstVC.hidesBottomBarWhenPushed = NO;
    firstVC.title = @"first";
    firstVC.delegate = self;
    
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    UIImage *imgHome = [[UIImage imageNamed:@"icon_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imgHomeS = [[UIImage imageNamed:@"icon_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *firstTab = [[UITabBarItem alloc] initWithTitle:@"首页" image:imgHome selectedImage:imgHomeS];
    [firstTab setImageInsets:UIEdgeInsetsMake(1.0, 0, -1.0, 0)];
    [firstNav setTabBarItem:firstTab];
    
    
    MyViewController *secondVC = [[MyViewController alloc] init];
    secondVC.hidesBottomBarWhenPushed = NO;
    secondVC.title = @"second";
    secondVC.delegate = self;
    
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    UIImage *imgMy = [[UIImage imageNamed:@"icon_account"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imgMyS = [[UIImage imageNamed:@"icon_account_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *secondTab = [[UITabBarItem alloc] initWithTitle:@"我的" image:imgMy selectedImage:imgMyS];
    [secondTab setImageInsets:UIEdgeInsetsMake(1.0, 0, -1.0, 0)];
    [secondNav setTabBarItem:secondTab];
    
    self.viewControllers = @[firstNav, secondNav];
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
