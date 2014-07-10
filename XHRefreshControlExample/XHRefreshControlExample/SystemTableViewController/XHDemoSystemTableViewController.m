//
//  XHDemoNormalTableViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-6-17.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHDemoSystemTableViewController.h"

@implementation XHDemoSystemTableViewController

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] initWithObjects:@"请问你现在在哪里啊？我在广州天河", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点进入聊天页面，这里有多种显示样式", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点进入聊天页面，这里有多种显示样式", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", @"点击我查看最新消息，里面有惊喜哦！", nil];
        
        NSMutableArray *indexPaths;
        if (self.requestCurrentPage) {
            indexPaths = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
            [dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSource.count + idx inSection:0]];
            }];
        }
        sleep(1.5);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.requestCurrentPage) {
                if (self.requestCurrentPage == arc4random() % 10) {
                    [self handleLoadMoreError];
                } else {
                    [self endLoadMoreRefreshing];
                    [self.dataSource addObjectsFromArray:dataSource];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                    
                }
            } else {
                [self endPullDownRefreshing];
                self.dataSource = dataSource;
                [self.tableView reloadData];
                
            }
        });
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startPullDownRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configuraTableViewNormalSeparatorInset];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"只是为了看看，我不动";
    
    return cell;
}

@end
