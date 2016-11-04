//
//  TransitionFirstViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TransitionFirstViewController.h"
#import "TransitionSecondViewController.h"
#import "HBLBubbleTransition.h"
#import "HBLHalfPresentTransition.h"
#import "HBLRevealLeftTransition.h"
#import "HBLLeftTopPresentTransition.h"

@interface TransitionFirstViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) TransitionSecondViewController *secondVC;

@end

@implementation TransitionFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn.layer.cornerRadius = 35.f;
    self.btn.layer.masksToBounds = YES;
}

- (IBAction)btnClicked:(id)sender
{
    TransitionSecondViewController *secondVC = [TransitionSecondViewController new];
    secondVC.transitioningDelegate = self;
    self.secondVC = secondVC;
    [self presentViewController:secondVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self setAnimationWithTransitionType:_transitionType showType:HBLShowViewControllerTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self setAnimationWithTransitionType:_transitionType showType:HBLShowViewControllerTypeDismiss];
}

- (id <UIViewControllerAnimatedTransitioning>)setAnimationWithTransitionType:(HBLTransitionType)type showType:(HBLShowViewControllerType)showType
{
    switch (_transitionType) {
        case HBLTransitionTypeBubble:
        {
            HBLBubbleTransition *transition = [HBLBubbleTransition new];
            transition.showType = showType;
            transition.bubbleCenter = self.btn.center;
            return transition;
        }
            break;
        case HBLTransitionTypeHalfPresent:
        {
            HBLHalfPresentTransition *transition = [HBLHalfPresentTransition new];
            transition.showType = showType;
            transition.dismissBlock = ^{
                [self.secondVC dismissViewControllerAnimated:YES completion:nil];
            };
            return transition;
        }
            break;
        case HBLTransitionTypeRevealLeft:
        {
            HBLRevealLeftTransition *transition = [HBLRevealLeftTransition new];
            transition.showType = showType;
            transition.offset = 40.f;
            return transition;
        }
            break;
        case HBLTransitionTypeLeftTopPresent:
        {
            HBLLeftTopPresentTransition *transition = [HBLLeftTopPresentTransition new];
            transition.showType = showType;
            return transition;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

@end
