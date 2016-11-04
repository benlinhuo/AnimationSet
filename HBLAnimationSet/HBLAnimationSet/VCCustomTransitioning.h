//
//  VCCustomTransitioning.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/27.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePush = 1,
    TransitionTypePop,
    TransitionTypePresent,
    TransitionTypeDimissed
};

@interface VCCustomTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithType:(TransitionType)type;

@end
