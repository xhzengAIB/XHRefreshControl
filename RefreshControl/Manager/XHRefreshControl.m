//
//  XHRefreshControl.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHRefreshControl.h"

#import "XHRefreshCircleContainerView.h"
#import "XHRefreshActivityIndicatorContainerView.h"
#import "XHLoadMoreView.h"

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

#define kXHDefaultRefreshTotalPixels 60

#define kXHAutoLoadMoreRefreshedCount 5

#define kXHDefaultDisplayAutoLoadMoreRefreshedMessage @"点击显示下10条"

@interface XHRefreshControl ()

@property (nonatomic, weak) id <XHRefreshControlDelegate> delegate;

// getter
@property (nonatomic, strong) XHRefreshCircleContainerView *refreshCircleContainerView;
@property (nonatomic, strong) XHRefreshActivityIndicatorContainerView *refreshActivityIndicatorContainerView;
@property (nonatomic, strong) UIView *customRefreshView;

@property (nonatomic, strong) XHLoadMoreView *loadMoreView;
@property (nonatomic, assign) BOOL isPullDownRefreshed;
@property (nonatomic, assign) BOOL isLoadMoreRefreshed;
@property (nonatomic, assign) CGFloat refreshTotalPixels;
@property (nonatomic, assign) NSInteger autoLoadMoreRefreshedCount;
@property (nonatomic, assign) XHRefreshViewLayerType refreshViewLayerType;
@property (nonatomic, assign) XHPullDownRefreshViewType pullDownRefreshViewType;

// recoder
@property (nonatomic, readwrite) CGFloat originalTopInset;
@property (nonatomic, readwrite) CGFloat originalBottomInset;

// target scrollview
@property (nonatomic, strong) UIScrollView *scrollView;

// target state
@property (nonatomic, assign) XHRefreshState refreshState;

// controll the loading and auto loading
@property (nonatomic, assign) NSInteger loadMoreRefreshedCount;
@property (nonatomic, assign) BOOL pullDownRefreshing;
@property (nonatomic, assign) BOOL loadMoreRefreshing;

@property (nonatomic, assign) BOOL noMoreDataForLoaded;

// preload more distanse
@property (nonatomic, assign) CGFloat preloadValue;

// Handle Network Error
@property (nonatomic, assign) BOOL handleNetworkError;

@property (nonatomic, assign) BOOL shouldNeedControlAutoPullDownPixel;

@end

@implementation XHRefreshControl

#pragma mark - Pull Down Refreshing Method

- (void)startControlPixelPullDownRefreshing {
    self.shouldNeedControlAutoPullDownPixel = YES;
    [self startPullDownRefreshing];
}

- (void)startPullDownRefreshing {
    if (self.isPullDownRefreshed) {
        self.pullDownRefreshing = YES;
        
        [self setupRefreshTime];
        
        self.refreshState = XHRefreshStatePulling;
        
        self.refreshState = XHRefreshStateLoading;
    }
}

- (void)animationRefreshCircleView {
    switch (self.pullDownRefreshViewType) {
        case XHPullDownRefreshViewTypeCircle: {
            if (self.refreshCircleContainerView.circleView.offsetY != kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight) {
                self.refreshCircleContainerView.circleView.offsetY = kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight;
            }
            // 先去除所有动画
            [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
            // 添加旋转的动画
            [self.refreshCircleContainerView.circleView.layer addAnimation:[XHCircleView repeatRotateAnimation] forKey:@"rotateAnimation"];
            break;
        }
        case XHPullDownRefreshViewTypeActivityIndicator: {
            [self.refreshActivityIndicatorContainerView.activityIndicatorView beginRefreshing];
            break;
        }
        case XHPullDownRefreshViewTypeCustom: {
            if ([self.delegate respondsToSelector:@selector(customPullDownRefreshViewWillStartRefresh:)]) {
                [self.delegate customPullDownRefreshViewWillStartRefresh:[self pullDownCustomRefreshView]];
            }
            break;
        }
        default:
            break;
    }
}

- (void)callBeginPullDownRefreshing {
    [self setScrollViewContentInsetForNoLoadMore];
    
    self.loadMoreRefreshedCount = 0;
    self.noMoreDataForLoaded = NO;
    
    if (self.pullDownRefreshViewType == XHPullDownRefreshViewTypeCustom) {
        if ([self.delegate respondsToSelector:@selector(customPullDownRefreshViewDidStartRefresh:)]) {
            [self.delegate customPullDownRefreshViewDidStartRefresh:[self pullDownCustomRefreshView]];
        }
    }
    
    [self.delegate beginPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    self.shouldNeedControlAutoPullDownPixel = NO;
    if (self.isPullDownRefreshed) {
        [self setupRefreshTime];
        
        self.pullDownRefreshing = NO;
        self.refreshState = XHRefreshStateStopped;
        
        [self resetScrollViewContentInset];
    }
    
    if (self.pullDownRefreshViewType == XHPullDownRefreshViewTypeCustom) {
        if ([self.delegate respondsToSelector:@selector(customPullDownRefreshViewWillEndRefresh:)]) {
            [self.delegate customPullDownRefreshViewWillEndRefresh:[self pullDownCustomRefreshView]];
        }
    }
}

#pragma mark - Load More Refreshing Method

- (void)startLoadMoreRefreshing {
    if (self.loadMoreRefreshing)
        return;
    [self callLoadMoreStatus];
    if ([self.delegate respondsToSelector:@selector(startLoadMoreForAutoTrigger)]) {
        [self.delegate startLoadMoreForAutoTrigger];
    }
}

- (void)callLoadMoreStatus {
    self.loadMoreRefreshing = YES;
    self.handleNetworkError = NO;
    self.loadMoreRefreshedCount ++;
    self.refreshState = XHRefreshStateLoading;
    [self.loadMoreView startLoading];
}

- (void)callBeginLoadMoreRefreshing {
    if (self.loadMoreRefreshing)
        return;
    if (self.loadMoreRefreshedCount < self.autoLoadMoreRefreshedCount && !self.handleNetworkError) {
        [self callLoadMoreStatus];
        [self.delegate beginLoadMoreRefreshing];
    } else {
        [self.loadMoreView configuraManualStateWithMessage:[self displayAutoLoadMoreRefreshedMessage]];
    }
}

- (void)endLoadMoreRefresing {
    self.loadMoreRefreshing = NO;
    self.handleNetworkError = NO;
    self.refreshState = XHRefreshStateNormal;
    [self.loadMoreView endLoading];
}

- (void)loadMoreButtonClciked:(UIButton *)sender {
    [self callBeginLoadMoreRefreshing];
}

- (void)endMoreOverWithMessage:(NSString *)message {
    [self endLoadMoreRefresing];
    self.noMoreDataForLoaded = YES;
    self.handleNetworkError = NO;
    self.loadMoreView.hidden = NO;
    [self.loadMoreView configuraNothingMoreWithMessage:message];
    [self setScrollViewContentInsetForNoLoadMore];
}

- (void)endMoreOverWithMessageTipsView:(UIView *)messageTipsView {
    self.noMoreDataForLoaded = YES;
    self.handleNetworkError = NO;
    self.loadMoreView.hidden = NO;
    [self.loadMoreView configuraNothingMoreWithMessageView:messageTipsView];
    [self setScrollViewContentInsetForNoLoadMore];
}

/**
 *  重置是否有更多翻页数据要加载
 */
- (void)resetLoadMoreStatue:(BOOL)noMoreDataForLoaded {
    self.noMoreDataForLoaded = noMoreDataForLoaded;
}

- (void)handleLoadMoreError {
    [self endLoadMoreRefresing];
    [self.loadMoreView configuraManualStateWithMessage:[self displayAutoLoadMoreRefreshedMessage]];
    self.handleNetworkError = YES;
}

- (BOOL)isLoading {
    return self.pullDownRefreshing;
}

#pragma mark - Refresh Time Helper Method

- (void)setupRefreshTime {
    if ([self.delegate respondsToSelector:@selector(lastUpdateTimeString)]) {
        NSString *dateString = [self.delegate lastUpdateTimeString];
        if ([dateString isKindOfClass:[NSString class]] || dateString) {
            self.refreshCircleContainerView.timeLabel.text = dateString;
        }
    }
}

#pragma mark - Scroll View

- (void)resetScrollViewContentInset {
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.top = self.originalTopInset;
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentInset:contentInset];
    } completion:^(BOOL finished) {
        
        self.refreshState = XHRefreshStateNormal;
        
        switch (self.pullDownRefreshViewType) {
            case XHPullDownRefreshViewTypeCircle: {
                self.refreshCircleContainerView.circleView.offsetY = 0;
                
                if (self.refreshCircleContainerView.circleView) {
                    [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
                }
                break;
            }
            case XHPullDownRefreshViewTypeActivityIndicator: {
                [self.refreshActivityIndicatorContainerView.activityIndicatorView endRefreshing];
                break;
            }
            case XHPullDownRefreshViewTypeCustom: {
                if ([self.delegate respondsToSelector:@selector(customPullDownRefreshViewDidEndRefresh:)]) {
                    [self.delegate customPullDownRefreshViewDidEndRefresh:[self pullDownCustomRefreshView]];
                }
                break;
            }
            default:
                break;
        }
    }];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [self setScrollViewContentInset:contentInset completion:NULL];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset completion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion(YES);
                         }
                         if (finished && self.refreshState == XHRefreshStateStopped) {
                             if (!self.scrollView.isDragging)
                                 self.refreshState = XHRefreshStateNormal;
                             
                             if (self.refreshCircleContainerView.circleView) {
                                 [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
                             }
                         }
                     }];
}

- (void)setScrollViewContentInsetForLoadingCompletion:(void (^)(BOOL finished))completion {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.refreshTotalPixels;
    [self setScrollViewContentInset:currentInsets completion:completion];
}

- (void)setScrollViewContentInsetForLoadMore {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = kXHLoadMoreViewHeight + self.originalBottomInset;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForNoLoadMore {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = kXHLoadMoreViewHeight + self.originalBottomInset;
    [self setScrollViewContentInset:currentInsets];
}

#pragma mark - Propertys

- (XHRefreshCircleContainerView *)refreshCircleContainerView {
    if (!_refreshCircleContainerView) {
        _refreshCircleContainerView = [[XHRefreshCircleContainerView alloc] initWithFrame:CGRectMake(0, (self.refreshViewLayerType == XHRefreshViewLayerTypeOnScrollViews ? -kXHDefaultRefreshTotalPixels : self.originalTopInset), CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHDefaultRefreshTotalPixels)];
        _refreshCircleContainerView.backgroundColor = [UIColor clearColor];
        _refreshCircleContainerView.circleView.heightBeginToRefresh = kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight;
        _refreshCircleContainerView.circleView.offsetY = 0;
        _refreshCircleContainerView.circleView.refreshViewLayerType = self.refreshViewLayerType;
    }
    return _refreshCircleContainerView;
}

- (XHRefreshActivityIndicatorContainerView *)refreshActivityIndicatorContainerView {
    if (!_refreshActivityIndicatorContainerView) {
        _refreshActivityIndicatorContainerView = [[XHRefreshActivityIndicatorContainerView alloc] initWithFrame:CGRectMake(0, (self.refreshViewLayerType == XHRefreshViewLayerTypeOnScrollViews ? -kXHDefaultRefreshTotalPixels : self.originalTopInset), CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHDefaultRefreshTotalPixels)];
        _refreshActivityIndicatorContainerView.backgroundColor = [UIColor clearColor];
        _refreshActivityIndicatorContainerView.refreshViewLayerType = self.refreshViewLayerType;
    }
    return _refreshActivityIndicatorContainerView;
}

- (XHLoadMoreView *)loadMoreView {
    if (!_loadMoreView) {
        _loadMoreView = [[XHLoadMoreView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame) - [self getAdaptorHeight], CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHLoadMoreViewHeight)];
        if ([self.delegate respondsToSelector:@selector(customLoadMoreButton)]) {
            UIButton *customLoadMoreButton = [self.delegate customLoadMoreButton];
            if (customLoadMoreButton) {
                [customLoadMoreButton addTarget:self action:@selector(loadMoreButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
                [_loadMoreView setupCustomLoadMoreButton:customLoadMoreButton];
            } else {
                [_loadMoreView.loadMoreButton addTarget:self action:@selector(loadMoreButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
            }
        } else {
            [_loadMoreView.loadMoreButton addTarget:self action:@selector(loadMoreButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _loadMoreView;
}

- (void)setHasStatusLabelShowed:(BOOL)hasStatusLabelShowed {
    _hasStatusLabelShowed = hasStatusLabelShowed;
    self.refreshCircleContainerView.hasStatusLabelShowed = hasStatusLabelShowed;
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    self.refreshCircleContainerView.circleView.circleColor = circleColor;
}

- (void)setCircleLineWidth:(CGFloat)circleLineWidth {
    _circleLineWidth = circleLineWidth;
    self.refreshCircleContainerView.circleView.circleLineWidth = circleLineWidth;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.refreshActivityIndicatorContainerView.activityIndicatorView.tintColor = indicatorColor;
    self.loadMoreView.activityIndicatorColor = indicatorColor;
}

#pragma mark - Getter Method

- (BOOL)isPullDownRefreshed {
    BOOL pullDowned = YES;
    if ([self.delegate respondsToSelector:@selector(isPullDownRefreshed)]) {
        pullDowned = [self.delegate isPullDownRefreshed];
        return pullDowned;
    }
    return YES;
}

- (BOOL)isLoadMoreRefreshed {
    BOOL loadMored = YES;
    if ([self.delegate respondsToSelector:@selector(isLoadMoreRefreshed)]) {
        loadMored = [self.delegate isLoadMoreRefreshed];
        return loadMored;
    }
    self.loadMoreView.hidden = !loadMored;
    return loadMored;
}

- (CGFloat)refreshTotalPixels {
    return kXHDefaultRefreshTotalPixels + [self getAdaptorHeight];
}

- (CGFloat)getAdaptorHeight {
    if (self.shouldNeedControlAutoPullDownPixel) {
        return 0;
    }
    return self.originalTopInset;
}

- (NSInteger)autoLoadMoreRefreshedCount {
    if ([self.delegate respondsToSelector:@selector(autoLoadMoreRefreshedCountConverManual)]) {
        return [self.delegate autoLoadMoreRefreshedCountConverManual];
    }
    return kXHAutoLoadMoreRefreshedCount;
}

- (XHRefreshViewLayerType)refreshViewLayerType {
    XHRefreshViewLayerType currentRefreshViewLayerType = XHRefreshViewLayerTypeOnScrollViews;
    if ([self.delegate respondsToSelector:@selector(refreshViewLayerType)]) {
        currentRefreshViewLayerType = [self.delegate refreshViewLayerType];
    }
    return currentRefreshViewLayerType;
}

- (XHPullDownRefreshViewType)pullDownRefreshViewType {
    XHPullDownRefreshViewType currentPullDownRefreshViewType = XHPullDownRefreshViewTypeCircle;
    if ([self.delegate respondsToSelector:@selector(pullDownRefreshViewType)]) {
        currentPullDownRefreshViewType = [self.delegate pullDownRefreshViewType];
    }
    return currentPullDownRefreshViewType;
}

- (UIView *)pullDownCustomRefreshView {
    if (self.customRefreshView) {
        return self.customRefreshView;
    }
    if ([self.delegate respondsToSelector:@selector(customPullDownRefreshView)]) {
        self.customRefreshView = [self.delegate customPullDownRefreshView];
        return self.customRefreshView;
    }
    return nil;
}

- (NSString *)displayAutoLoadMoreRefreshedMessage {
    NSString *message = kXHDefaultDisplayAutoLoadMoreRefreshedMessage;
    if ([self.delegate respondsToSelector:@selector(displayAutoLoadMoreRefreshedMessage)]) {
        message = [self.delegate displayAutoLoadMoreRefreshedMessage];
    }
    return message;
}

- (CGFloat)preloadValue {
    CGFloat currentValue = 0.0;
    if ([self.delegate respondsToSelector:@selector(preloadDistance)]) {
        currentValue = [self.delegate preloadDistance];
    }
    return currentValue;
}

#pragma mark - Setter Method

- (void)setRefreshState:(XHRefreshState)refreshState {
    if ([self.delegate respondsToSelector:@selector(customPullDownRefreshViewRefreshState:)]) {
        [self.delegate customPullDownRefreshViewRefreshState:refreshState];
    }
    switch (refreshState) {
        case XHRefreshStateStopped:
        case XHRefreshStateNormal: {
            switch (self.pullDownRefreshViewType) {
                case XHPullDownRefreshViewTypeCircle:
                    self.refreshCircleContainerView.stateLabel.text = @"下拉刷新";
                    break;
                case XHPullDownRefreshViewTypeActivityIndicator:
                    break;
                case XHPullDownRefreshViewTypeCustom:
                    break;
                default:
                    break;
            }
            break;
        }
        case XHRefreshStateLoading: {
            if (self.pullDownRefreshing) {
                if (self.pullDownRefreshViewType == XHPullDownRefreshViewTypeCircle) {
                    self.refreshCircleContainerView.stateLabel.text = @"正在加载";
                }
                
                __weak typeof(self) weakSelf = self;
                [self setScrollViewContentInsetForLoadingCompletion:^(BOOL finished) {
                    if (finished) {
                        [weakSelf callBeginPullDownRefreshing];
                    }
                }];
                if(_refreshState == XHRefreshStatePulling) {
                    [self animationRefreshCircleView];
                }
            }
            break;
        }
        case XHRefreshStatePulling:
            switch (self.pullDownRefreshViewType) {
                case XHPullDownRefreshViewTypeCircle:
                    self.refreshCircleContainerView.stateLabel.text = @"释放立即刷新";
                    break;
                case XHPullDownRefreshViewTypeActivityIndicator:
                    break;
                case XHPullDownRefreshViewTypeCustom:
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    _refreshState = refreshState;
}

#pragma mark - Life Cycle

- (void)configuraObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

- (void)setup {
    self.originalTopInset = self.scrollView.contentInset.top;
    self.originalBottomInset = self.scrollView.contentInset.bottom;
    
    self.refreshState = XHRefreshStateNormal;
    
    [self configuraObserverWithScrollView:self.scrollView];
    
    if (self.refreshViewLayerType == XHRefreshViewLayerTypeOnSuperView) {
        self.scrollView.backgroundColor = [UIColor clearColor];
        UIView *currentSuperView = self.scrollView.superview;
        
        if (self.isPullDownRefreshed) {
            switch (self.pullDownRefreshViewType) {
                case XHPullDownRefreshViewTypeCircle:
                    [currentSuperView insertSubview:self.refreshCircleContainerView belowSubview:self.scrollView];
                    break;
                case XHPullDownRefreshViewTypeActivityIndicator:
                    [currentSuperView insertSubview:self.refreshActivityIndicatorContainerView belowSubview:self.scrollView];
                    break;
                case XHPullDownRefreshViewTypeCustom: {
                    [currentSuperView insertSubview:[self pullDownCustomRefreshView] belowSubview:self.scrollView];
                    break;
                }
                default:
                    break;
            }
        }
    } else if (self.refreshViewLayerType == XHRefreshViewLayerTypeOnScrollViews) {
        if (self.isPullDownRefreshed) {
            switch (self.pullDownRefreshViewType) {
                case XHPullDownRefreshViewTypeCircle:
                    [self.scrollView addSubview:self.refreshCircleContainerView];
                    break;
                case XHPullDownRefreshViewTypeActivityIndicator:
                    [self.scrollView addSubview:self.refreshActivityIndicatorContainerView];
                    break;
                case XHPullDownRefreshViewTypeCustom: {
                    [self.scrollView addSubview:[self pullDownCustomRefreshView]];
                    break;
                }
                default:
                    break;
            }
        }
    }
    
    
    if (self.isLoadMoreRefreshed) {
        [self.scrollView addSubview:self.loadMoreView];
    }
    
    self.hasStatusLabelShowed = YES;
    
    self.circleColor = [UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1];
    
    self.circleLineWidth = 1.0;
}

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <XHRefreshControlDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.scrollView = scrollView;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
    [self removeObserverWithScrollView:self.scrollView];
    self.scrollView = nil;
    
    [self.refreshCircleContainerView removeFromSuperview];
    self.refreshCircleContainerView = nil;
    
    [self.refreshActivityIndicatorContainerView removeFromSuperview];
    self.refreshActivityIndicatorContainerView = nil;
    
    [self.customRefreshView removeFromSuperview];
    self.customRefreshView = nil;
    
    [self.loadMoreView removeFromSuperview];
    self.loadMoreView = nil;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        // 上提加载更多的逻辑方法
        if (self.isLoadMoreRefreshed) {
            int currentPostion = contentOffset.y;
            
            if (currentPostion > 0) {
                
                CGRect bounds = self.scrollView.bounds;//边界
                
                CGSize size = self.scrollView.contentSize;//滚动视图内容区域size
                
                UIEdgeInsets inset = self.scrollView.contentInset;//视图周围额外的滚动视图区域
                
                float y = currentPostion + bounds.size.height + inset.bottom;
                
                //判断是否滚动到底部
                if(((y - size.height) + self.preloadValue) > kXHLoadMoreViewHeight && self.refreshState != XHRefreshStateLoading && self.isLoadMoreRefreshed && !self.loadMoreRefreshing && !self.noMoreDataForLoaded) {
                    [self callBeginLoadMoreRefreshing];
                }
            }
        }
        
        // 下拉刷新的逻辑方法
        if (self.isPullDownRefreshed) {
            if (!self.loadMoreRefreshing) {
                if(self.refreshState != XHRefreshStateLoading) {
                    // 如果不是加载状态的时候
                    
                    CGFloat pullDownOffset = (MIN(ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]), kXHDefaultRefreshTotalPixels) - kXHRefreshCircleViewHeight);
                    if (ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]) >= kXHRefreshCircleViewHeight) {
                        switch (self.pullDownRefreshViewType) {
                            case XHPullDownRefreshViewTypeCircle: {
                                if (!self.pullDownRefreshing) {
                                    self.refreshCircleContainerView.circleView.offsetY = pullDownOffset;
                                }
                                break;
                            }
                            case XHPullDownRefreshViewTypeActivityIndicator: {
                                if (self.scrollView.contentOffset.y <= -([self getAdaptorHeight] - kXHRefreshCircleViewHeight)) {
                                    CGFloat timeOffset = pullDownOffset / 36.0;
                                    self.refreshActivityIndicatorContainerView.activityIndicatorView.timeOffset = timeOffset;
                                }
                                break;
                            }
                            case XHPullDownRefreshViewTypeCustom: {
                                if ([self.delegate respondsToSelector:@selector(customPullDownRefreshView:withPullDownOffset:)]) {
                                    if ([self pullDownCustomRefreshView]) {
                                        [self.delegate customPullDownRefreshView:[self pullDownCustomRefreshView] withPullDownOffset:pullDownOffset];
                                    }
                                }
                                break;
                            }
                            default:
                                break;
                        }
                    } else {
                        if (self.pullDownRefreshViewType == XHPullDownRefreshViewTypeActivityIndicator) {
                            self.refreshActivityIndicatorContainerView.activityIndicatorView.timeOffset = 0.0;
                        }
                    }
                    
                    
                    CGFloat scrollOffsetThreshold;
                    scrollOffsetThreshold = -(kXHDefaultRefreshTotalPixels + self.originalTopInset);
                    
                    if(!self.scrollView.isDragging && self.refreshState == XHRefreshStatePulling) {
                        if (!self.pullDownRefreshing) {
                            self.pullDownRefreshing = YES;
                            self.refreshState = XHRefreshStateLoading;
                        }
                    } else if (contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging && self.refreshState == XHRefreshStateStopped) {
                        self.refreshState = XHRefreshStatePulling;
                    } else if (contentOffset.y >= scrollOffsetThreshold && self.refreshState != XHRefreshStateStopped) {
                        self.refreshState = XHRefreshStateStopped;
                    }
                } else {
                    if (self.pullDownRefreshing) {
                        CGFloat offset;
                        UIEdgeInsets contentInset;
                        offset = MAX(self.scrollView.contentOffset.y * -1, kXHDefaultRefreshTotalPixels);
                        offset = MIN(offset, self.refreshTotalPixels);
                        contentInset = self.scrollView.contentInset;
                        self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
                    }
                }
            }
        }
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize contentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        if (self.isLoadMoreRefreshed && !self.noMoreDataForLoaded && !self.pullDownRefreshing) {
            CGRect loadMoreViewFrame = self.loadMoreView.frame;
            loadMoreViewFrame.origin.y = contentSize.height;
            self.loadMoreView.frame = loadMoreViewFrame;
            [self setScrollViewContentInsetForLoadMore];
        } else {
//            CGFloat scrollViewHeight = CGRectGetHeight(self.scrollView.frame);
//            CGFloat thubs = scrollViewHeight - [self getAdaptorHeight];
//            if (contentSize.height >= thubs) {
            CGRect loadMoreViewFrame = self.loadMoreView.frame;
            loadMoreViewFrame.origin.y = contentSize.height;
            self.loadMoreView.frame = loadMoreViewFrame;
//            }
        }
    }
}

@end
