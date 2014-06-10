![image](https://github.com/xhzengAIB/LearnEnglish/raw/master/Screenshots/XHRefreshControl.gif)
XHRefreshControl
================

XHRefreshControl 是一款高扩展性、低耦合度的下拉刷新、上提加载更多的组件。

## Podfile

[CocosPods](http://cocosPods.org) is the recommended method to install XHRefreshControl, just add the following line to `Podfile`

```
pod 'XHRefreshControl'
```

and run `pod install`, then you're all done!

## How to use
```objc

#import "XHRefreshControl.h"

XHRefreshControl *refreshControl = [[XHRefreshControl alloc] initWithScrollView:self.yourTableView delegate:self];


implementation XHRefreshControl required delegate:

/**
 *  1、这个是用于标识用户是否在加载数据中，所以涉及到业务逻辑的问题，所以就外部传值
 *
 *  @return 如果不实现该delegate方法，所以效果都会实现
 */
- (BOOL)isLoading;

/**
 *  2、将要开始下拉刷新的方法
 */
- (void)beginPullDownRefreshing;

/**
 *  3、将要开始上提加载更多的方法
 */
- (void)beginLoadMoreRefreshing;

/**
 *  4、最后更新数据的时间
 *
 *  @return 返回缓存最后更新某个页面的时间
 */
- (NSDate *)lastUpdateTime;


optional delegate for your design UI layout

/**
 *  1、是否支持下拉刷新
 *
 *  @return 如果没有实现该delegate方法，默认是支持下拉的，为YES
 */
- (BOOL)isPullDownRefreshed;

/**
 *  2、是否支持上提加载更多
 *
 *  @return 如果没有实现该delegate方法，默认是支持上提加载更多的，为YES
 */
- (BOOL)isLoadMoreRefreshed;

/**
 *  3、标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view
 *
 *  @return 如果没有实现该delegate方法，默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
- (XHRefreshViewLayerType)refreshViewLayerType;

/**
 *  4、UIScrollView的控制器是否保留iOS7新的特性，意思是：tablView的内容是否可以穿透过导航条
 *
 *  @return 如果不是先该delegate方法，默认是不支持的
 */
- (BOOL)keepiOS7NewApiCharacter;

/**
 *  5、将自动加载更多的状态转换为手动加载需要的条件，现在是加载更多多少次后，开始转换
 *
 *  @return 如果不实现该delegate方法，默认是5次
 */
- (NSInteger)autoLoadMoreRefreshedCountConverManual;

@end

@interface XHRefreshControl : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <XHRefreshControlDelegate>)delegate;

/**
 *  外部手动启动下拉加载的方法，这个方法不需要手动去拖动UIScrollView
 */
- (void)startPullDownRefreshing;

/**
 *  停止下拉刷新的方法
 */
- (void)endPullDownRefreshing;

/**
 *  停止上提加载更多的方法
 */
- (void)endLoadMoreRefresing;




```


## License

中文: XHRefreshControl 是在MIT协议下使用的，可以在LICENSE文件里面找到相关的使用协议信息。

English: XHRefreshControl is available under the MIT license, see the LICENSE file for more information.     



## 须知       Notes
如果您在您的项目中使用该开源组件,请给我们发[电子邮件](mailto:xhzengAIB@gmail.com?subject=From%20GitHub%20XHRefreshControl)告诉我们您的应用程序的名称，谢谢！主要是为了互推的效果，如果您的app火了，请给予少许的回报，如果您的App不火，或许能通过这个开源库了解到您的App！            
                           
If you use this open source components in your project, please [Email us](mailto:xhzengAIB@gmail.com?subject=From%20GitHub%20XHRefreshControl) to notify us the name of your application(s). Thanks!

