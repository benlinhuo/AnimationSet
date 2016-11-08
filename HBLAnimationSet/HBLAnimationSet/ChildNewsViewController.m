//
//  ChildNewsViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "ChildNewsViewController.h"
#import "DetailViewController.h"

@interface ChildNewsViewController ()

@end

@implementation ChildNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSwipeGesture:)]) {
        [self.delegate actionSwipeGesture:gesture];
    }
}

- (IBAction)gotoDetailViewController:(id)sender
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)goBack:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}

@end
