//
//  XHSegueItem.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-7-12.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
