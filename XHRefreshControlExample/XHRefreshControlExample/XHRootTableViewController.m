//
//  XHRootTableViewController.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHRootTableViewController.h"

#import "XHDemoTableViewController.h"

@interface XHRootTableViewController ()

@end

@implementation XHRootTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:@"网易新闻样式有导航条的", @"网易新闻样式没有导航条的", @"iOS7的系统样式，自定出来啦！", nil];
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
    XHDemoTableViewController *demoTableViewController = [[XHDemoTableViewController alloc] init];
    if (!indexPath.row) {
        [self.navigationController pushViewController:demoTableViewController animated:YES];
    } else if (indexPath.row == 1) {
        [self presentViewController:demoTableViewController animated:YES completion:NULL];
    } else {
        demoTableViewController.isIOS7Style = YES;
        [self.navigationController pushViewController:demoTableViewController animated:YES];
    }
}

@end
