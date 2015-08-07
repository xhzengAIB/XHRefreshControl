//
//  PinterestDemoRefreshTableViewController.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/8/7.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "PinterestDemoRefreshTableViewController.h"

@implementation PinterestDemoRefreshTableViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startPullDownRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i ++) {
            [dataSource addObject:@"请问你现在在哪里啊？我在广州天河"];
        }
        
        NSMutableArray *indexPaths;
        if (self.requestCurrentPage) {
            indexPaths = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
            [dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSource.count + idx inSection:0]];
            }];
        }
        sleep(4);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.requestCurrentPage) {
                if (self.requestCurrentPage == arc4random() % 10) {
                    [self endMoreOverWithMessage:@"段子已加载完"];
                } else {
                    
                    [self.dataSource addObjectsFromArray:dataSource];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                    [self endLoadMoreRefreshing];
                }
            } else {
                if (rand() % 3 > 1) {
                    self.loadMoreRefreshed = NO;
                }
                
                self.dataSource = dataSource;
                [self.tableView reloadData];
                [self endPullDownRefreshing];
            }
        });
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    
    return cell;
}

@end
