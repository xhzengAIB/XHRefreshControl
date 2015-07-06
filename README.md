![image](https://github.com/xhzengAIB/LearnEnglish/raw/master/Screenshots/XHRefreshControl.gif)
XHRefreshControl
================

XHRefreshControl 是一款高扩展性、低耦合度的下拉刷新、上提加载更多的组件。                   

很多朋友反映这个开源用起来并不方便，我暂时想到的解决方案：通过OC的分类特性，使用OC的动态绑定特性来解决这个问题，如果有Block情结的开发者，那是不是可以也加上去呢？当然是比较好的做法。            
总结：使用Category、Runtime以及Block来实现更加方便的使用方法！

## Podfile

[CocosPods](http://cocosPods.org) is the recommended method to install XHRefreshControl, just add the following line to `Podfile`

```
pod 'XHRefreshControl'
```

and run `pod install`, then you're all done!

## Requirements

* Xcode6 or later
* iOS 6.0+ 
* ARC

## To Do:
* 添加外部自定义下拉View和下拉状态-------已经完成

## How to use
```objc
提供两种使用方式：
1、继承UIViewController，自定义TableView。
使用方法很简单
#import "XHPullRefreshTableViewController.h"

继承XHPullRefreshTableViewController，

提供以下多个方法处理加载数据的不同处理方法：
/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL pullDownRefreshed;

/**
 *  是否支持上拉刷新
 */
@property (nonatomic, assign) BOOL loadMoreRefreshed;

/**
 *  下拉刷新的样式
 */
@property (nonatomic, assign) XHPullDownRefreshViewType refreshViewType;

/**
 *  加载数据的页码
 */
@property (nonatomic, assign) NSInteger requestCurrentPage;

/**
 *  自动下拉刷新调用的方法，必须放在viewDidAppear方法内，别把这行代码放到别处，然后导致了错误，那就不好了嘛！
 */
- (void)startPullDownRefreshing;

/**
 *  当下拉加载数据完成后，你必须调用该方法哦！
 */
- (void)endPullDownRefreshing;

/**
 *  当上啦加载数据完成后，你也得调用该方法哦！然后你可能会问，那我要怎么判断是下拉还是上啦啊？requestCurrentPage看这个变量，会跟着变化哦！
 */
- (void)endLoadMoreRefreshing;

/**
 *  当上啦加载数据回调告诉我们，已经没有下一页了，那你可以调用该方法，告诉用户你已经没有数据了哦！
 *
 *  @param message 提示用户的信息
 */
- (void)endMoreOverWithMessage:(NSString *)message;

/**
 *  当网络加载失败的时候，你必须调用该方法，如果你不调用，我也帮不了你了
 */
- (void)handleLoadMoreError;


2、直接使用UITableViewController，提供兼容下拉、上啦刷新的处理。
#import "XHSysatemRefreshTableViewController.h"

提供的内部方法和第一个方式是一样的！


你也可以自己定制一个属于你自己的控制器，至于你要加入其他基础类的方法，那就您好好定制了。以下提供这些方法给您定制下拉、上拉的样式。
#import "XHRefreshControl.h"

XHRefreshControl *refreshControl = [[XHRefreshControl alloc] initWithScrollView:self.yourTableView delegate:self];

以下手动可调用的方法
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

/**
 *  没有更多的数据加载
 */
- (void)endMoreOverWithMessage:(NSString *)message;



以下是delegate方法，用于外部定制
implementation XHRefreshControl required delegate:

@required
/**
 *  1、将要开始下拉刷新的方法
 */
- (void)beginPullDownRefreshing;

/**
 *  2、将要开始上提加载更多的方法
 */
- (void)beginLoadMoreRefreshing;

/**
 *  3、最后更新数据的时间
 *
 *  @return 返回缓存最后更新某个页面的时间
 */
- (NSDate *)lastUpdateTime;

@optional
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
 *  4、下拉刷新使用哪种样式
 *
 *  @return 如果没有实现该delegate方法，默认是网易新闻App的样式
 */
- (XHPullDownRefreshViewType)pullDownRefreshViewType;

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

/**
 *  6、获取用户定义下拉的View
 *
 *  @return 返回用户定义的View
 */
- (UIView *)customPullDownRefreshView;

/**
 *  7、通知外部，下拉的距离，用于定制某个时机的状态
 *
 *  @param refreshView    需要改变状态的View
 *  @param pullDownOffset 下拉的距离
 */
- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset;

/**
 *  8、将要下拉的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下拉的View
 */
- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView;

/**
 *  9、将要停止下啦的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下啦的View
 */
- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView;




```


## License

中文: XHRefreshControl 是在MIT协议下使用的，可以在LICENSE文件里面找到相关的使用协议信息。

English: XHRefreshControl is available under the MIT license, see the LICENSE file for more information.     



## 须知       Notes
如果您在您的项目中使用该开源组件,请给我们发[电子邮件](mailto:xhzengAIB@gmail.com?subject=From%20GitHub%20XHRefreshControl)告诉我们您的应用程序的名称，谢谢！主要是为了互推的效果，如果您的app火了，请给予少许的回报，如果您的App不火，或许能通过这个开源库了解到您的App！            
                           
If you use this open source components in your project, please [Email us](mailto:xhzengAIB@gmail.com?subject=From%20GitHub%20XHRefreshControl) to notify us the name of your application(s). Thanks!

