//
//  SingleViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/26.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "SingleViewController.h"
#import "VCCustomTransitioning.h"

@interface SingleViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, nonatomic) UIImageView *backImgView;

@end

@implementation SingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.backImgView];
    [self.view addSubview:self.imgView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    self.backImgView.userInteractionEnabled = YES;
    [self.backImgView addGestureRecognizer:tap];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.imgName ofType:@"jpg"];
    self.imgView.image = [UIImage imageWithContentsOfFile:path];
    
}

- (void)goBack
{
    if (self.showType == ShowTypePresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if (self.showType == ShowTypePush) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    return [[VCCustomTransitioning alloc] initWithType:(operation == UINavigationControllerOperationPush ? TransitionTypePush : TransitionTypePop)];
}

#pragma mark - getter

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 150, 110, 160)];
    }
    return _imgView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        _bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}

- (UIImageView *)backImgView
{
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 10, 20)];
        _backImgView.image = [UIImage imageNamed:@"icon_nav_back"];
    }
    return _backImgView;
}

@end
