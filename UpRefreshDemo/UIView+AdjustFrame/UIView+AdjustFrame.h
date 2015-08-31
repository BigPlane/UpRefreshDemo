//
//  UIView+AdjustFrame.h
//  Tools
//
//  Created by Colin on 15-1-6.
//  Copyright (c) 2015年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AdjustFrame)
/** 控件的x值 */
@property (nonatomic, assign) CGFloat x;

/** 控件的y值 */
@property (nonatomic, assign) CGFloat y;

/** 控件中心点的X值 */
@property (nonatomic, assign) CGFloat centerX;

/** 控件中心点的Y值 */
@property (nonatomic, assign) CGFloat centerY;

/** 控件的width值 */
@property (nonatomic, assign) CGFloat width;

/** 控件的height值 */
@property (nonatomic, assign) CGFloat height;

/** 控件的origin值 */
@property (nonatomic, assign) CGPoint origin;

/** 控件的size值 */
@property (nonatomic, assign) CGSize size;

@end
