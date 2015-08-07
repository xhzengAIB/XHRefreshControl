//
//  BMYCircularProgressView.h
//  BMYPullToRefreshDemo
//
//  Created by Alberto De Bortoli on 15/05/2014.
//  Copyright (c) 2014 Beamly. All rights reserved.
//

#import <UIKit/UIKit.h>

// this code from https://github.com/beamly/BMYCircularProgressPullToRefresh

@interface XHCircularProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (id)initWithFrame:(CGRect)frame
               logo:(UIImage *)logoImage
    backCircleImage:(UIImage *)backCircleImage
   frontCircleImage:(UIImage *)frontCircleImage;

@end
