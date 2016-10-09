//
//  BaseViewController.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleButton.h"

@interface BaseViewController : UIViewController

/**
 *  初始化View
 */
- (void)initView;

/**
 *  按钮操作区的数组元素
 *
 *  @return 数组
 */
- (NSArray *)operateTitleArray;

/**
 *  每个按钮的点击时间
 *
 *  @param btn
 */
- (void)clickBtn : (UIButton *)btn;


@end
