//
//  XHSystemCollectionViewController.h
//  XHRefreshControlExample
//
//  Created by Jiangliyin on 14-9-14.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XHSystemCollectionViewController : UICollectionViewController

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;
//
///**
// *  去除iOS7新的功能api，tableView的分割线变成iOS6正常的样式
// */
//- (void)configuraTableViewNormalSeparatorInset;

///**
// *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
// *
// *  @param tableView 目标tableView
// */
//- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;


@end
