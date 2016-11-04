//
//  TransitionFirstViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HBLTransitionType) {
    HBLTransitionTypeBubble = 2,
    HBLTransitionTypeHalfPresent,
    HBLTransitionTypeRevealLeft,
    HBLTransitionTypeLeftTopPresent
};

@interface TransitionFirstViewController : UIViewController

@property (nonatomic, assign) HBLTransitionType transitionType;

@end
