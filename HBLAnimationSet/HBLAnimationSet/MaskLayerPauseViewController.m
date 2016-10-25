//
//  MaskLayerPauseViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/25.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "MaskLayerPauseViewController.h"


static const CGFloat kImgViewWidth = 160;


@interface MaskLayerPauseViewController () {
    BOOL isAnimating; // 是否正在发生动画
    CAShapeLayer *maskLayer;
}

@property (weak, nonatomic) IBOutlet UIImageView *downImgview;
@property (weak, nonatomic) IBOutlet UIImageView *upImgview;

@end

@implementation MaskLayerPauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downImgview.layer.masksToBounds = YES;
    self.downImgview.layer.cornerRadius = kImgViewWidth / 2;
    self.upImgview.layer.masksToBounds = kImgViewWidth / 2;
    self.upImgview.layer.cornerRadius = 80;
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kImgViewWidth, kImgViewWidth)].CGPath;
    
    // mask是个遮罩，只有透明度信息有用，颜色信息是被忽略的，你设置它的颜色没有意义
    self.upImgview.layer.mask = maskLayer;
    
}

- (IBAction)startAnimation:(id)sender
{
    isAnimating = YES;
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kImgViewWidth, kImgViewWidth)];
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kImgViewWidth, 0)];
    
    [maskLayer removeAllAnimations]; // 动画前清空之前动画
    // 初始状态
    maskLayer.speed = 1; // 设置速度

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (id)(startPath.CGPath);
    animation.toValue = (id)(toPath.CGPath);
    animation.duration = 5.f;
    [maskLayer addAnimation:animation forKey:@"pathAnimation"];
}

- (IBAction)pauseAnimation:(id)sender
{
    isAnimating = NO;
    
    // 将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为localtime
    CFTimeInterval pausedTime = [maskLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 设置layer的timeOffset, 在继续操作也会使用到
    maskLayer.timeOffset = pausedTime;
    
    // localtime与parenttime的比例为0, 意味着localtime暂停了
    maskLayer.speed = 0;
}

- (IBAction)resumeAnimation:(id)sender
{
    // 正在动画，就不管
    if (isAnimating) {
        return;
    }
    
    isAnimating = YES;
    // 获取之前暂停时时间点
    CFTimeInterval pausedTime = maskLayer.timeOffset; // 这句话必须在设置 speed 和 timeOffset 之前，否则获取到的 pausedTime 不准
    
    // 又有速度了，接着动画
    maskLayer.speed = 1;
    // 取消之前的设置
    maskLayer.timeOffset = 0;
    
    // 这句话必须要有，否则当“暂停”和“恢复”来回切换的话会出现，可能出现不顺滑的现象
    maskLayer.beginTime = 0; // beginTime是相对于父级对象的开始时间
    
    // 计算暂停时间
    CFTimeInterval intervalTime = [maskLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    // local time相对于parent time世界的beginTime
    maskLayer.beginTime = intervalTime; // 设置开始时间为之前间隔的时间
}

@end
