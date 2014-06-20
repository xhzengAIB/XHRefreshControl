//
//  XHRootTableViewController.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHRootTableViewController.h"

#import "XHDemoTableViewController.h"

#import "XHSystemTableViewController.h"

@interface XHRootTableViewController ()

@end

@implementation XHRootTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:@"网易新闻样式有导航条的", @"网易新闻样式没有导航条的", @"iOS7的系统样式，自定义出来啦！", @"系统级别的UITableViewController使用组件", @"用户高级自定义样式", nil];
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
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;
    if (!indexPath.row) {
        viewController = [[XHDemoTableViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 1) {
        viewController = [[XHDemoTableViewController alloc] init];
        
        [self presentViewController:viewController animated:YES completion:NULL];
    } else if (indexPath.row == 2) {
        XHDemoTableViewController *demoTableViewController = [[XHDemoTableViewController alloc] init];
        demoTableViewController.refreshViewType = XHPullDownRefreshViewTypeActivityIndicator;
        viewController = demoTableViewController;
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 3) {
        viewController = [[XHSystemTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        XHDemoTableViewController *demoTableViewController = [[XHDemoTableViewController alloc] init];
        demoTableViewController.refreshViewType = XHPullDownRefreshViewTypeCustom;
        viewController = demoTableViewController;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
