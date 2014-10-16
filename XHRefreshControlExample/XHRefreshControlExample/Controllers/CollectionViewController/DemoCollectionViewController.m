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
        [self endPullDownRefreshing];
    });
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.pullDownRefreshed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    collectionViewCell.label.text = @"askldjlaksjdl";
    
    return collectionViewCell;
}

@end
