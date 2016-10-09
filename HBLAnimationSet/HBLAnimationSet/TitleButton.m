//
//  TitleButton.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/8.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

@end
