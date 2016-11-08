//
//  MyViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewControllerDelegate <NSObject>

- (void)goBack;

@end

@interface MyViewController : UIViewController

@property (nonatomic, weak) id<MyViewControllerDelegate> delegate;

@end
