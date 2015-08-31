//
//  FooterView.m
//  UpRefreshDemo
//
//  Created by Colin on 15-9-1.
//  Copyright (c) 2015年 CH. All rights reserved.
//

#import "FooterView.h"
#import "UIView+AdjustFrame.h"

@implementation FooterView

+ (FooterView *)refreshFooterView
{
    FooterView *refreshFooterView = [[self alloc] init];
    
    refreshFooterView.width = [UIScreen mainScreen].bounds.size.width;
    refreshFooterView.height = 35;
    
    return refreshFooterView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.opaque = YES;
    }
    
    return self;
}

#pragma mark - 设置子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /* 提示文字 */
    UILabel *label = [[UILabel alloc] init];
    
    // 位置位置和尺寸
    label.x = 0;
    label.y = 0;
    label.width = self.width;
    label.height = self.height;
    
    // 设置文字样式
    label.text = @"正在加载更多数据";
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 获取文字宽度
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = label.font;
    CGFloat textWidth = [label.text sizeWithAttributes:attr].width;
    
    [self addSubview:label];
    
    /* 菊花 */
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activity.width = label.height;
    activity.height = label.height;
    activity.y = 0;
    activity.x = (label.width + textWidth) * 0.5;
    
    [activity startAnimating];
    
    [self addSubview:activity];
}


@end
