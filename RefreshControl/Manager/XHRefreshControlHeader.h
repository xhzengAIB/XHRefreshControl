//
//  XHRefreshControlHeader.h
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-7-3.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
