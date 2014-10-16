//
//  CollectionViewFlowLayout.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-10-16.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(150, 150);
        self.minimumLineSpacing = 5;
    }
    return self;
}

@end
