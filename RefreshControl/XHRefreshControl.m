//
//  XHRefreshControl.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHRefreshControl.h"

#import "XHRefreshView.h"
#import "XHLoadMoreView.h"

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

#define kXHDefaultRefreshTotalPixels 64

#define kXHAutoLoadMoreRefreshedCount 5


typedef NS_ENUM(NSInteger, XHRefreshState) {
    XHRefreshStatePulling   = 0,
    XHRefreshStateNormal    = 1,
    XHRefreshStateLoading   = 2,
    XHRefreshStateStopped   = 3,
};

@interface XHRefreshControl ()

@property (nonatomic, strong) XHRefreshView *refreshView;

@property (nonatomic, strong) XHLoadMoreView *loadMoreView;

@property (nonatomic, assign) BOOL isPullDownRefreshed;

@property (nonatomic, assign) BOOL isLoadMoreRefreshed;

@property (nonatomic, assign) CGFloat refreshTotalPixels;

@property (nonatomic, assign) NSInteger autoLoadMoreRefreshedCount;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) XHRefreshState refreshState;

@property (nonatomic, assign) NSInteger loadMoreRefreshedCount;

@property (nonatomic, assign) BOOL wasTriggeredByUser;

@end

@implementation XHRefreshControl

#pragma mark - Public Method

- (void)startPullDownRefreshing {
    NSDate *date = [self.delegate lastUpdateTime];
    if (date || [date isKindOfClass:[NSDate class]]) {
        self.refreshView.timeLabel.text = [NSString stringWithFormat:@"上次刷新：%@", @"10小时前"];
    }
    
    
    //    // 自动滚动UIScrollView到一定位置
    //    [self.scrollView setContentInset:UIEdgeInsetsMake(-self.scrollView.contentOffset.y, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right)];
    //    //解决画面会闪一下的问题
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [UIView animateWithDuration:0.3f animations:^{
    //            UIEdgeInsets contentInset = self.scrollView.contentInset;
    //            contentInset.top = CGRectGetHeight(self.refreshView.bounds);
    //            [self.scrollView setContentInset:contentInset];
    //        }];
    //    });
    
    self.refreshState = XHRefreshStatePulling;
    
    [self setScrollViewContentInsetForLoading];
    
    if(fequalzero(self.scrollView.contentOffset.y)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -self.scrollView.frame.size.height) animated:YES];
        self.wasTriggeredByUser = NO;
    } else {
        self.wasTriggeredByUser = YES;
    }
    
    [self animationRefreshCircleView];
    
    self.refreshState = XHRefreshStateLoading;
}

- (void)animationRefreshCircleView {
    if (self.refreshView.refreshCircleView.offsetY != HEIGHT_BEGIN_TO_REFRESH - HEIGHT_BEGIN_TO_DRAW_CIRCLE) {
        self.refreshView.refreshCircleView.offsetY = HEIGHT_BEGIN_TO_REFRESH - HEIGHT_BEGIN_TO_DRAW_CIRCLE;
        [self.refreshView.refreshCircleView setNeedsDisplay];
    }
    // 先去除所有动画
    [self.refreshView.refreshCircleView.layer removeAllAnimations];
    // 添加旋转的动画
    [self.refreshView.refreshCircleView.layer addAnimation:[XHRefreshCircleView repeatRotateAnimation] forKey:@"rotateAnimation"];
    
    [self callBeginPullDownRefreshing];
}

- (void)callBeginPullDownRefreshing {
    [self.delegate beginPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    self.refreshState = XHRefreshStateStopped;
    
    if(!self.wasTriggeredByUser && self.scrollView.contentOffset.y < -0)
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -0) animated:YES];
    
    [self resetScrollViewContentInset];
}

- (void)startLoadMoreRefreshing {
    if (self.loadMoreRefreshedCount < self.autoLoadMoreRefreshedCount) {
        [self callBeginLoadMoreRefreshing];
    }
}

- (void)callBeginLoadMoreRefreshing {
    self.loadMoreRefreshedCount ++;
    self.refreshState = XHRefreshStateLoading;
    [self.loadMoreView startLoading];
    [self.delegate beginLoadMoreRefreshing];
}

- (void)endLoadMoreRefresing {
    [self.loadMoreView endLoading];
}

- (void)loadMoreButtonClciked:(UIButton *)sender {
    [self callBeginLoadMoreRefreshing];
}

#pragma mark - Scroll View

- (void)resetScrollViewContentInset {
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right)];
    } completion:^(BOOL finished) {
        
        self.refreshState = XHRefreshStateNormal;
        
        if (self.refreshView.refreshCircleView) {
            [self.refreshView.refreshCircleView.layer removeAllAnimations];
        }
    }];
}

- (void)setScrollViewContentInsetForLoading {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.refreshTotalPixels;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:^(BOOL finished) {
                         if (self.refreshState == XHRefreshStateStopped) {
                             self.refreshState = XHRefreshStateNormal;
                             
                             if (self.refreshView.refreshCircleView) {
                                 [self.refreshView.refreshCircleView.layer removeAllAnimations];
                             }
                         }
                     }];
}

#pragma mark - Propertys

- (XHRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[XHRefreshView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 60)];
    }
    return _refreshView;
}

- (XHLoadMoreView *)loadMoreView {
    if (!_loadMoreView) {
        _loadMoreView = [[XHLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 44)];
        [_loadMoreView.loadMoreButton addTarget:self action:@selector(loadMoreButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadMoreView;
}

#pragma mark - Getter Method

- (BOOL)isLoading {
    return [self.delegate isLoading];
}

- (BOOL)isPullDownRefreshed {
    if ([self.delegate respondsToSelector:@selector(isPullDownRefreshed)]) {
        return [self.delegate isPullDownRefreshed];
    }
    return NO;
}

- (BOOL)isLoadMoreRefreshed {
    if ([self.delegate respondsToSelector:@selector(isLoadMoreRefreshed)]) {
        return [self.delegate isLoadMoreRefreshed];
    }
    return YES;
}

- (CGFloat)refreshTotalPixels {
    if ([self.delegate respondsToSelector:@selector(pullDownRefreshTotalPixels)]) {
        return [self.delegate pullDownRefreshTotalPixels];
    }
    return kXHDefaultRefreshTotalPixels;
}

- (NSInteger)autoLoadMoreRefreshedCount {
    if ([self.delegate respondsToSelector:@selector(autoLoadMoreRefreshedCountConverManual)]) {
        return [self.delegate autoLoadMoreRefreshedCountConverManual];
    }
    return kXHAutoLoadMoreRefreshedCount;
}

#pragma mark - Setter Method

- (void)setRefreshState:(XHRefreshState)refreshState {
    
    switch (refreshState) {
        case XHRefreshStateNormal: {
            self.refreshView.stateLabel.text = @"下拉刷新";
            break;
        }
        case XHRefreshStateLoading: {
            self.refreshView.stateLabel.text = @"正在加载";
            [self setScrollViewContentInsetForLoading];
            
            if(_refreshState == XHRefreshStatePulling) {
                [self animationRefreshCircleView];
            }
            break;
        }
        case XHRefreshStatePulling:
            self.refreshView.stateLabel.text = @"释放立即刷新";
            break;
        case XHRefreshStateStopped: {
            
            
            self.wasTriggeredByUser = YES;
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
    [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentInset" context:nil];
}

- (void)setup {
    self.refreshState = XHRefreshStateNormal;
    
    [self configuraObserverWithScrollView:self.scrollView];
    
    [self.scrollView addSubview:self.refreshView];
    [self.scrollView addSubview:self.loadMoreView];
}

- (id)initWithScrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [self removeObserverWithScrollView:self.scrollView];
    self.scrollView = nil;
    
    self.refreshView = nil;
    
    self.loadMoreView = nil;
}

#pragma mark - KVO

int _lastPosition;    //A variable define in headfile

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        
        int currentPostion = contentOffset.y;
        if (currentPostion - _lastPosition > 10 && currentPostion > 0) {
            CGRect bounds = self.scrollView.bounds;//边界
            CGSize size = self.scrollView.contentSize;//滚动视图内容区域size
            UIEdgeInsets inset = self.scrollView.contentInset;//视图周围额外的滚动视图区域
            float y = contentOffset.y + bounds.size.height - inset.bottom;
            float h = size.height;
            //判断是否滚动到底部
            if(y > h - CGRectGetHeight(self.loadMoreView.bounds) && self.refreshState != XHRefreshStateLoading && self.isLoadMoreRefreshed) {
                [self startLoadMoreRefreshing];
            }
        }
        _lastPosition = currentPostion;
        
        if(self.refreshState != XHRefreshStateLoading) {
            if (ABS(self.scrollView.contentOffset.y) >= HEIGHT_BEGIN_TO_DRAW_CIRCLE) {
                self.refreshView.refreshCircleView.offsetY = MIN(ABS(self.scrollView.contentOffset.y), HEIGHT_BEGIN_TO_REFRESH) - HEIGHT_BEGIN_TO_DRAW_CIRCLE;
                [self.refreshView.refreshCircleView setNeedsDisplay];
            }
            
            CGFloat scrollOffsetThreshold;
            scrollOffsetThreshold = -self.refreshTotalPixels;
            if(!self.scrollView.isDragging && self.refreshState == XHRefreshStatePulling) {
                self.refreshState = XHRefreshStateLoading;
            } else if(contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging && self.refreshState == XHRefreshStateStopped) {
                self.refreshState = XHRefreshStatePulling;
            } else if(contentOffset.y >= scrollOffsetThreshold && self.refreshState != XHRefreshStateStopped) {
                self.refreshState = XHRefreshStateStopped;
            }
        } else {
            CGFloat offset;
            UIEdgeInsets contentInset;
            offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
            offset = MIN(offset, self.refreshTotalPixels + self.refreshView.bounds.size.height);
            contentInset = self.scrollView.contentInset;
            self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
        }
    }
}

@end
