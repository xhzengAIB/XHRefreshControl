//
//  XHSegmentViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-7-10.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
