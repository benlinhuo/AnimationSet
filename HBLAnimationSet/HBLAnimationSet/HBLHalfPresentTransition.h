//
//  HBLHalfPresentTransition.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/3.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLBaseTransition.h"

typedef void(^HBLHalfPresentSnapDismissBlock)(void);

@interface HBLHalfPresentTransition : HBLBaseTransition

@property (nonatomic, copy) HBLHalfPresentSnapDismissBlock dismissBlock;

@end
