//
//  XHSegueItem.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-7-12.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHSegueItem.h"

@implementation XHSegueItem

+ (instancetype)initSegueItemWithTitle:(NSString *)title onClasseName:(NSString *)className {
    XHSegueItem *sugueItem = [[XHSegueItem alloc] init];
    sugueItem.title = title;
    sugueItem.className = className;
    return sugueItem;
}

@end
