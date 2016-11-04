//
//  vcTransitionViewController.m
//  HBLAnimationSet
//
//  Created by benlinhuo on 16/10/26.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "vcTransitionViewController.h"
#import "VCCustomTransitioning.h"

@interface vcTransitionViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *movieList;
    NSArray *titleList;
}

@end

@implementation vcTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    movieList = @[@"movie1", @"movie2", @"movie3", @"movie4", @"movie5", @"movie6"];
    titleList = @[@"永不回头", @"机械师", @"魔法精灵", @"惊天破", @"湄公河行动", @"育婴室"];
    [self.view addSubview:self.tblView];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[VCCustomTransitioning alloc] initWithType:TransitionTypePresent];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[VCCustomTransitioning alloc] initWithType:TransitionTypeDimissed];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier]; 
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:movieList[indexPath.row] ofType:@"jpg"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
    cell.textLabel.text = titleList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SingleViewController *singleVC = [SingleViewController new];
    singleVC.imgName = movieList[indexPath.row];
    self.currentIndexPath = indexPath;
    singleVC.showType = self.showType;
    
    if (self.showType == ShowTypePush) {
        // 也可以把这个 delegate 设置为 self，不过这个设置对self.navigationController 下所有的 viewControllers 都起作用，不过我们可以在 viewWillDisappear 中把 self.navigationController.delegate = nil;
        self.navigationController.delegate = singleVC; // UINavigationController 切换效果
        [self.navigationController pushViewController:singleVC animated:YES];
        
    } else if (self.showType == ShowTypePresent) {
        singleVC.transitioningDelegate = self; // UIViewController 切换动画
        [self presentViewController:singleVC animated:YES completion:nil];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableView *)tblView
{
    if (!_tblView) {
        _tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tblView.delegate = self;
        _tblView.dataSource = self;
    }
    return _tblView;
}



@end
