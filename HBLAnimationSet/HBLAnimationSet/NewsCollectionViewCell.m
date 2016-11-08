//
//  NewsCollectionViewCell.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    
    self.label.layer.cornerRadius = 10;
    self.label.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.label.backgroundColor = [UIColor blueColor];
    } else {
        self.label.backgroundColor = [UIColor clearColor];
    }
}


@end
