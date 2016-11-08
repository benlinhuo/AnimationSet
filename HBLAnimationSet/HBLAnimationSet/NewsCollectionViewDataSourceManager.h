//
//  NewsCollectionViewDataSourceManager.h
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NewsCellIdentifier @"NewsCollectionViewCell"

typedef void(^DidSelectItemAtIndexPath)(NSIndexPath *indexPath);

@interface NewsCollectionViewDataSourceManager : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, copy) DidSelectItemAtIndexPath didSelectItemAtIndexPathBlock;

@end
