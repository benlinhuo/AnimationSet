//
//  NewsCollectionViewDataSourceManager.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "NewsCollectionViewDataSourceManager.h"
#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewDataSourceManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认titles
        self.titles = @[
                        @"萝卜",
                        @"白菜",
                        @"芹菜",
                        @"水果",
                        @"视频",
                        @"图片",
                        @"面包",
                        @"生活",
                        @"启示录",
                        @"树木",
                        @"小草",
                        @"校花"
                        ];
        
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (NewsCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsCollectionViewCell *cell = (NewsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NewsCellIdentifier forIndexPath:indexPath];

    cell.label.text = _titles[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(indexPath);
    }
    
}


@end
