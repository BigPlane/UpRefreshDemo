//
//  ViewController.m
//  UpRefreshDemo
//
//  Created by Colin on 15-8-31.
//  Copyright (c) 2015年 CH. All rights reserved.
//

#import "ViewController.h"
#import "FooterView.h"
#import "UIView+AdjustFrame.h"

#define kRandomNumber arc4random_uniform(1024)
#define kOrignalData [NSString stringWithFormat:@"初始数据---%d", kRandomNumber]
#define kMoreData [NSString stringWithFormat:@"更多数据---%d", kRandomNumber]

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/** 模拟数据 */
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (NSMutableArray *)datas
{
    if (!_datas)
    {
        self.datas = [NSMutableArray array];
        
        for (int i = 0; i < 15; i++)
        {
            [_datas addObject:kOrignalData];
        }
    }
    
    return _datas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setupUpRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUpRefresh
{
    FooterView *refreshFooterView = [FooterView refreshFooterView];
    refreshFooterView.hidden = YES;
    self.tableView.tableFooterView = refreshFooterView;
}

/**
 *  加载更多数据
 */
- (void)loadMoreDatas
{
    for (int i = 0; i < 2; i++)
    {
        [self.datas addObject:kMoreData];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新状态, 隐藏FooterView
        self.tableView.tableFooterView.hidden = YES;
    });
}

#pragma mark － UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    
    return cell;
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前contentView滑动的位置(对应contentSize)
    CGFloat contenOffsetY = scrollView.contentOffset.y;
    
    // 如果tableView还没有数据或footerView在显示时, 直接返回
    if (self.datas.count == 0 || self.tableView.tableFooterView.hidden == NO)
    {
        return;
    }
    
    // 最后一个Cell显示时contentOffSetY应该在的最小位置(内容高度 + 边框 - 显示窗口高度 - footrerView高度)
    CGFloat targetContentOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
    // 若滑动位置在目标位置下(显示到最后一个Cell)时
    if (contenOffsetY >= targetContentOffsetY)
    {
        // 显示footerView
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多数据
        [self loadMoreDatas];
    }
}

@end
