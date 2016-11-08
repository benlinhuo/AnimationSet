//
//  HomeViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewControllerDelegate <NSObject>

- (void)goBack;

@end

@interface HomeViewController : UIViewController

@property (nonatomic, weak) id<HomeViewControllerDelegate> delegate;

@end
