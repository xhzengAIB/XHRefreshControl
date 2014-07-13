//
//  XHSegmentViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-7-10.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHSegmentViewController.h"

#import "XHDemoTableViewController.h"

@interface XHSegmentViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSMutableDictionary *viewControllers;

@end

@implementation XHSegmentViewController

- (void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl {
//    UIViewController *viewController = [self.viewControllers objectForKey:[NSString stringWithFormat:@"%d", segmentedControl.selectedSegmentIndex]];
//    if (!viewController) {
//        viewController = [self demoTableViewController];
//    }
//    [UIView transitionFromView:self.view toView:viewController.view duration:0 options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
//        
//    }];
}

#pragma mark - Propertys

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        [_segmentedControl insertSegmentWithTitle:@"News" atIndex:0 animated:NO];
        [_segmentedControl insertSegmentWithTitle:@"Home" atIndex:1 animated:NO];
        [_segmentedControl insertSegmentWithTitle:@"Helper" atIndex:2 animated:NO];
        [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_segmentedControl setSelectedSegmentIndex:0];
    }
    return _segmentedControl;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segmentedControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pull Down View Controller Helper Method

- (XHDemoTableViewController *)demoTableViewController {
    XHDemoTableViewController *demoTableViewController = [[XHDemoTableViewController alloc] init];
    return demoTableViewController;
}

@end
