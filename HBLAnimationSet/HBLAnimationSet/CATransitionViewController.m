//
//  CATransitionViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/10.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController () {
    NSTimeInterval durationTime;
}

@property (nonatomic , strong) UIView *demoView;
@property (nonatomic , strong) UILabel *demoLabel;
@property (nonatomic , assign) NSInteger index;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CATransition";
    durationTime = 3.f;
}

- (void)initView
{
    [super initView];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 90, SCREEN_HEIGHT / 2 - 200, 180, 260)];
    [self.view addSubview:_demoView];
    
    _demoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_demoView.frame) / 2 - 10, CGRectGetHeight(_demoView.frame) / 2 - 20, 30, 40)];
    _demoLabel.textAlignment = NSTextAlignmentCenter;
    _demoLabel.font = [UIFont systemFontOfSize:40];
    [_demoView addSubview:_demoLabel];
    
    [self changeView:YES];
}

#pragma mark - 覆盖父类方法

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckEffectAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleEffectAnimation];
            break;
        case 8:
            [self pageCurlAnimation];
            break;
        case 9:
            [self pageUnCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
        default:
            break;
    }
}

#pragma mark - 各类动画方法
- (void)fadeAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft; // fade 没有左右之分，所以设置了也看不出效果
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"fadeAnimation"];
}

- (void)moveInAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;// 此时的左右就是必须要指定的方向
    transition.duration = durationTime;
    
    transition.startProgress = 0.3; // 它会一下子切换到0.3的状态
    transition.endProgress = 0.6; // 在实现渐变以后到0.6状态，会立马变成1的状态
    
    [_demoView.layer addAnimation:transition forKey:@"moveInAnimation"];
}

- (void)pushAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"pushAnimation"];
}

- (void)revealAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"revealAnimation"];
}

//-----------------------------private api------------------------------------
/*
	Don't be surprised if Apple rejects your app for including those effects,
	and especially don't be surprised if your app starts behaving strangely after an OS update.
 */
// 虽然时私有 API，但有用过上传 APPStore，审核通过了。所以在需要时可以尝试使用
// 因为是私有 API，所以 type 没有定义好的对外字符串，而是需要自己直接定义

// 立体翻转效果
- (void)cubeAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"cubeAnimation"];
}

- (void)suckEffectAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"suckEffect";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"suckEffectAnimation"];
}

- (void)oglFlipAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"oglFlipAnimation"];
}

- (void)rippleEffectAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"rippleEffectAnimation"];
}

// 翻页效果（翻开）
- (void)pageCurlAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"pageCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"pageCurlAnimation"];
}

// 翻页效果（合上页面）
- (void)pageUnCurlAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"pageUnCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"pageUnCurlAnimation"];
}

- (void)cameraIrisHollowOpenAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"cameraIrisHollowOpen";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"cameraIrisHollowOpenAnimation"];
}

- (void)cameraIrisHollowCloseAnimation
{
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"cameraIrisHollowClose";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = durationTime;
    
    [_demoView.layer addAnimation:transition forKey:@"cameraIrisHollowCloseAnimation"];
}

- (void)changeView:(BOOL)isUp
{
    if (_index>3) {
        _index = 0;
    }
    if (_index<0) {
        _index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    NSArray *titles = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    _demoLabel.text = [titles objectAtIndex:_index];
    if (isUp) {
        _index++;
    }else{
        _index--;
    }
}

@end
