//
//  DemoCollectionViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-10-16.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "DemoCollectionViewController.h"

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation CollectionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"奥迪.jpg"];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 30, CGRectGetWidth(self.bounds), 30)];
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end

@interface DemoCollectionViewController ()

@property (nonatomic, strong) UIImageView *messageTipsView;

@end

@implementation DemoCollectionViewController

- (void)loadDataSource {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.requestCurrentPage > 0) {
            
            [self.dataSource addObjectsFromArray:@[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""]];
            [self.collectionView reloadData];
            [self endLoadMoreRefreshing];
            
            if (self.requestCurrentPage == 5) {
                [self endMoreOverWithMessageTipsView:self.messageTipsView];
                return ;
            }
        } else {
            self.dataSource = [@[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""] mutableCopy];
            [self.collectionView reloadData];
            [self endPullDownRefreshing];
        }
    });
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.pullDownRefreshed = YES;
        self.loadMoreRefreshed = YES;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.dataSource.count) {
        [self startPullDownRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:251/255.0 alpha:1.0];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Propertys

- (UIImageView *)messageTipsView {
    if (!_messageTipsView) {
        _messageTipsView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 50)];
        _messageTipsView.image = [UIImage imageNamed:@"nothing_more_tips"];
    }
    return _messageTipsView;
}

#pragma mark - XHRefreshControl Delegate

- (UIButton *)customLoadMoreButton {
    UIButton *_loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 10)];
    [_loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loadMoreButton setBackgroundColor:[UIColor colorWithRed:248/255.0 green:249/255.0 blue:251/255.0 alpha:1.0]];
    return _loadMoreButton;
}

#pragma mark - CollectionView Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    collectionViewCell.label.text = @"askldjlaksjdl";
    
    return collectionViewCell;
}

@end
