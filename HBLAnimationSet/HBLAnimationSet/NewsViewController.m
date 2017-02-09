//
//  NewsViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/11/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCollectionViewDataSourceManager.h"
#import "NewsCollectionViewCell.h"
#import "ChildNewsViewController.h"

@interface NewsViewController ()<ChildNewsViewControllerDelegate, UIGestureRecognizerDelegate>  {
    NewsCollectionViewDataSourceManager *_manager;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentChildIndex;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareNavigationItemByCollectionView];
    
    [self prepareAllChildControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [super viewWillDisappear:animated];
}

- (void)prepareNavigationItemByCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(64, 44);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NewsCellIdentifier];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    
    self.navigationItem.titleView = _collectionView;
    [self.navigationItem setHidesBackButton:YES];
    _manager = [[NewsCollectionViewDataSourceManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    _manager.didSelectItemAtIndexPathBlock = ^(NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        if (indexPath.item == strongSelf.currentChildIndex) {
            return;
        }
        
        ChildNewsViewController *fromChildVC = strongSelf.childViewControllers[strongSelf.currentChildIndex];
        ChildNewsViewController *toChildVC = strongSelf.childViewControllers[indexPath.item];
        
        CGFloat xStartOfFromChildVC, xEndOfFromChildVC;
        CGFloat xStartOfToChildVC, xEndOfToChildVC;
        
        if (indexPath.item > strongSelf.currentChildIndex) { // 往左滑
            xStartOfFromChildVC = 0;
            xEndOfFromChildVC = -fromChildVC.view.frame.size.width;
            
            xStartOfToChildVC = toChildVC.view.frame.size.width;
            xEndOfToChildVC = 0;
            
        } else if (indexPath.item < strongSelf.currentChildIndex) {
            xStartOfFromChildVC = 0;
            xStartOfFromChildVC = fromChildVC.view.frame.size.width;
            
            xStartOfToChildVC = -toChildVC.view.frame.size.width;
            xEndOfToChildVC = 0;
        }
        // 只是横向变化
        toChildVC.view.frame = CGRectMake(xStartOfToChildVC, CGRectGetMinY(toChildVC.view.frame), toChildVC.view.frame.size.width, toChildVC.view.frame.size.height);
        
        _currentChildIndex = indexPath.item;
        
        // options 可以指定很多种动画形式
        [strongSelf transitionFromViewController:fromChildVC
                          toViewController:toChildVC
                                  duration:0.5f
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{
                                    fromChildVC.view.frame = CGRectMake(xEndOfFromChildVC,  CGRectGetMinY(fromChildVC.view.frame), fromChildVC.view.frame.size.width, fromChildVC.view.frame.size.height);
                                    
                                    toChildVC.view.frame = CGRectMake(xEndOfToChildVC, CGRectGetMinY(toChildVC.view.frame), toChildVC.view.frame.size.width, toChildVC.view.frame.size.height);
        
                                } completion:^(BOOL finished) {
                                    [strongSelf.view bringSubviewToFront:strongSelf.collectionView];
                                }];
    };
    
    self.collectionView.dataSource = _manager;
    self.collectionView.delegate = _manager;
}

- (void)prepareAllChildControllers
{
    for (NSString *title in _manager.titles) {
        ChildNewsViewController *childVC = [[ChildNewsViewController alloc] init];
        childVC.title = title;
        childVC.delegate = self;
        [self addChildViewController:childVC];
    }
    
    _currentChildIndex = 0;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentChildIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    // childViewControllers 属性是 parentViewController 提供的
    // 对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。
    [self.view insertSubview:self.childViewControllers[_currentChildIndex].view belowSubview:self.collectionView];
}


#pragma mark - ChildNewsViewControllerDelegate
// 手指左右滑动 childViewController ，也应该能滑动上方 navigationItem 部分item
- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)sender
{
    NSInteger index = 0;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            if (_currentChildIndex < (_manager.titles.count - 1)) {
               index = _currentChildIndex + 1;
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            if (_currentChildIndex > 0) {
                index = _currentChildIndex - 1;
            }
        }
            break;
        default:
            return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    if (_manager.didSelectItemAtIndexPathBlock) {
        _manager.didSelectItemAtIndexPathBlock(indexPath);
    }
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
