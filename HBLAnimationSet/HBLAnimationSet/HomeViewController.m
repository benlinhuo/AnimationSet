//
//  HomeViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)goBack:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}

@end
