//
//  SimulationNetEaseNetworkErrorViewController.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 15/1/6.
//  Copyright (c) 2015年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHSimulationNetEaseNetworkErrorViewController.h"

@interface XHSimulationNetEaseNetworkErrorViewController ()

@property (nonatomic, assign) BOOL isFrist;

@end

@implementation XHSimulationNetEaseNetworkErrorViewController

- (void)loadDataSource {
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        [dataSource addObject:@"请问你现在在哪里啊？我在广州天河"];
    }
    
    if (!self.isFrist) {
        self.isFrist = YES;
        // 1.模拟1秒的网络加载时间
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.requestCurrentPage) {
                [self endLoadMoreRefreshing];
            } else {
                [self.dataSource removeAllObjects];
                [self endPullDownRefreshing];
            }
            
            [self.dataSource addObjectsFromArray:dataSource];
            [self.tableView reloadData];
            
            // 2.当下拉刷新数据刚完成之后，突然网络断了
            [self handleLoadMoreError];
            
            // 3.断网10秒后，网络突然又好了
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 4.模拟用户点击了一下加载更多的按钮，数据进行刷新了
                [self.dataSource addObjectsFromArray:dataSource];
                [self.tableView reloadData];
                [self endLoadMoreRefreshing];
                
                // 5.这时候，如果没有达到转换为手动加载的情况下，仍然可以有自动加载的机制
            });
        });
        
    } else {
        // 这里是点击加载更多按钮或者网络好的情况下调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataSource addObjectsFromArray:dataSource];
            [self.tableView reloadData];
            [self endLoadMoreRefreshing];
        });
    }
}

#pragma mark - XHRefreshControl Delegate

- (UIButton *)customLoadMoreButton {
    UIButton *_loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 10)];
    [_loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    [_loadMoreButton.layer setMasksToBounds:YES];
    [_loadMoreButton.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    return _loadMoreButton;
}

@end
