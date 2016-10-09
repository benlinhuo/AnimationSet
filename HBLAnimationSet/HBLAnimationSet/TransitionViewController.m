//
//  TransitionViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/8/22.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController () {
    BOOL isFirstImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    self.imageView.layer.borderWidth = .5f;
    [self setImage];
}


- (IBAction)buttonClicked:(id)sender
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [animation setType:@"rippleEffect"];// rippleEffect
    [animation setSubtype:kCATransitionFromTop];
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    
    [self setImage];
}

- (void)setImage
{
    if (!isFirstImage) {
        isFirstImage = YES;
        // 使用 imageWithContentsOfFile 该方法，他的路径需要使用 NSBundle 才可以拿到正确的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"];
        self.imageView.image = [UIImage imageWithContentsOfFile:path];
        
    } else {
        isFirstImage = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpeg"];
        self.imageView.image = [UIImage imageWithContentsOfFile:path];
    }
}




@end
