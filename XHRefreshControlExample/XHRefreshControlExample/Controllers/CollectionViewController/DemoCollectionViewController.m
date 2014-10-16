//
//  DemoCollectionViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-10-16.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "DemoCollectionViewController.h"

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@end

@implementation CollectionViewCell

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end

@interface DemoCollectionViewController ()

@end

@implementation DemoCollectionViewController

- (void)loadDataSource {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.requestCurrentPage > 0) {
            [self.dataSource addObjectsFromArray:@[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""]];
            [self.collectionView reloadData];
            [self endLoadMoreRefreshing];
            
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    collectionViewCell.label.text = @"askldjlaksjdl";
    
    return collectionViewCell;
}

@end
