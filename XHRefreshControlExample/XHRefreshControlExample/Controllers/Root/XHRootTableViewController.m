//
//  XHRootTableViewController.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHRootTableViewController.h"

#import "XHDemoTableViewController.h"

#import "XHDemoSystemTableViewController.h"

#import "XHCustomLoadMoreButtonDemoTableViewController.h"

#import "DemoCollectionViewController.h"

#import "XHSegueItem.h"

#import "CollectionViewFlowLayout.h"

@interface XHRootTableViewController ()

@end

@implementation XHRootTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"高级下拉组件";
    
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       [XHSegueItem initSegueItemWithTitle:@"京东原版下拉刷新" onClasseName:@"XHJDRefreshDemoTableViewController"],
                       [XHSegueItem initSegueItemWithTitle:@"网易新闻样式有导航栏的" onClasseName:@"XHDemoTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"网易新闻样式没有导航栏的" onClasseName:@"XHDemoTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"模仿网易新闻4.0网络差的情况" onClasseName:@"XHSimulationNetEaseNetworkErrorViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"iOS7的系统样式，自定义出来啦！" onClasseName:@"XHDemoTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"UITableViewController使用我的下拉组件" onClasseName:@"XHDemoSystemTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"用户高级自定义样式" onClasseName:@"XHDemoTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"自定义加载更多的按钮样式" onClasseName:@"XHCustomLoadMoreButtonDemoTableViewController"],
                       
                       [XHSegueItem initSegueItemWithTitle:@"CollectionViewController" onClasseName:@"DemoCollectionViewController"],
                       nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
    }
    if (indexPath.row < self.dataSource.count) {
        XHSegueItem *segueItem = self.dataSource[indexPath.row];
        cell.textLabel.text = segueItem.title;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    XHSegueItem *segueItem = self.dataSource[row];
    
    UIViewController *viewController = nil;
    if (row == 7) {
        viewController = [[DemoCollectionViewController alloc] initWithCollectionViewLayout:[[CollectionViewFlowLayout alloc] init]];
    } else {
        viewController = [[NSClassFromString(segueItem.className) alloc] init];
    }
    
    viewController.title = segueItem.title;
    
    if (row == 1) {
        
        [self presentViewController:viewController animated:YES completion:NULL];
        return;
        
    } else if (row == 3) {
        
        ((XHDemoTableViewController *)viewController).refreshViewType = XHPullDownRefreshViewTypeActivityIndicator;
        
    } else if (row == 5) {
        
        ((XHDemoTableViewController *)viewController).refreshViewType = XHPullDownRefreshViewTypeCustom;
        
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
