//
//  XHSegueItem.h
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-7-12.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHSegueItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *className;

+ (instancetype)initSegueItemWithTitle:(NSString *)title onClasseName:(NSString *)className;

@end
