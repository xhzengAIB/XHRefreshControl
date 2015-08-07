//
//  XHRefreshControlHeader.h
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-7-3.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#ifndef XHRefreshControlExample_XHRefreshControlHeader_h
#define XHRefreshControlExample_XHRefreshControlHeader_h

typedef NS_ENUM(NSInteger, XHRefreshViewLayerType) {
    XHRefreshViewLayerTypeOnSuperView = 0,
    XHRefreshViewLayerTypeOnScrollViews = 1,
};

typedef NS_ENUM(NSInteger, XHPullDownRefreshViewType) {
    XHPullDownRefreshViewTypeCircle = 0,
    XHPullDownRefreshViewTypeActivityIndicator = 1,
    XHPullDownRefreshViewTypePinterest = 2,
    XHPullDownRefreshViewTypeCustom = 3,
};

typedef NS_ENUM(NSInteger, XHRefreshState) {
    XHRefreshStatePulling   = 0,
    XHRefreshStateNormal    = 1,
    XHRefreshStateLoading   = 2,
    XHRefreshStateStopped   = 3,
};

#endif
