//
//  TransitionSecondViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TransitionSecondViewController.h"

@interface TransitionSecondViewController ()

@end

@implementation TransitionSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
