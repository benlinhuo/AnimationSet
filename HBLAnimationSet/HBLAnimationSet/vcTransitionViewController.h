//
//  vcTransitionViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/26.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleViewController.h"

@interface vcTransitionViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UITableView *tblView;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, assign) ShowType showType;

@end
