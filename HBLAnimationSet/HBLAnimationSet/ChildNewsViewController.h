//
//  ChildNewsViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChildNewsViewControllerDelegate <NSObject>

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)sender;
- (void)goBack;

@end

@interface ChildNewsViewController : UIViewController

@property (nonatomic, weak) id<ChildNewsViewControllerDelegate> delegate;

@end
