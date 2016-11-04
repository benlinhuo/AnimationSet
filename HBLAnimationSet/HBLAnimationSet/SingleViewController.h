//
//  SingleViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/26.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowType) {
    ShowTypePush,
    ShowTypePresent
};

@interface SingleViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *imgName;
@property (strong, nonatomic) UIImageView *imgView;

@property (nonatomic, assign) ShowType showType;

@end
