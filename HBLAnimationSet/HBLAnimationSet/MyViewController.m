//
//  MyViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}

- (IBAction)goBack:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}



@end
