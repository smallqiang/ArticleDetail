//
//  DetailViewController.m
//  ArticleDetail
//
//  Created by ChenYaoqiang on 14-10-13.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import "DetailViewController.h"
#import "UIView+SC.h"
#import "CommentsTableViewCell.h"

#define iOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue]-7.0>=0)

#define NAVIGATION_STATUSBAR ((iOS7) ? (64.0f) : (0.0f))
#define TABLEVIEW_HEIGHT ((iOS7) ? (0.0f) : (64.0f))

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章详情";
    
    _webView.scrollView.delegate = self;
    _webScrollView = _webView.scrollView;
    _webScrollView.scrollEnabled = NO;
    
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com"]];
    [_webView loadRequest:request];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,_webView.bounds.size.height, self.view.width, self.view.height - 64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollsToTop = NO;
    _tableView.scrollEnabled = NO;
    [_webScrollView addSubview:_tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    
    _tableViewHeight = _tableView.height + TABLEVIEW_HEIGHT;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self calculateWebHeight];
    if (!_isShowComments) {
        [_tableView setTop:_contentHeight];
        [self setScrollViewStatusIsWeb:YES];
    }
    [_webScrollView setContentSize:CGSizeMake(0, _contentHeight+_tableViewHeight)];
}

//计算webView读取的内容高度
- (void)calculateWebHeight
{
    float content_height = [[_webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] floatValue];
    
    float offset_height= [[_webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] floatValue] + 20;
    
    if (offset_height < _webView.height) {
        _contentHeight = offset_height;
    } else {
        _contentHeight = content_height;
    }
}

//设置webView和scrollView的可滚动状态和点击状态栏滚到顶部
- (void)setScrollViewStatusIsWeb:(BOOL)isWeb
{
    if (isWeb) {
        _webScrollView.scrollsToTop = YES;
        _tableView.scrollsToTop = NO;
        
        _webScrollView.scrollEnabled = YES;
        _tableView.scrollEnabled = NO;
    } else {
        _webScrollView.scrollsToTop = NO;
        _tableView.scrollsToTop = YES;
        
        _webScrollView.scrollEnabled = NO;
        _tableView.scrollEnabled = YES;
    }
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentsTableViewCell";
    
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:@"CommentsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_contentHeight <= 0.0) {
        return;
    }
    
    if (scrollView == _webScrollView) {
        [_webScrollView setContentSize:CGSizeMake(0, _contentHeight+_tableViewHeight)];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_contentHeight <= 0.0) {
        return;
    }
    
    float offsetY = scrollView.contentOffset.y;
    if (scrollView == _webScrollView) {
        //判断scrollView超过webview
        if (offsetY >= (_contentHeight - NAVIGATION_STATUSBAR)) {
            [scrollView setContentOffset:CGPointMake(0, (_contentHeight - NAVIGATION_STATUSBAR)) animated:NO];
            [self setScrollViewStatusIsWeb:NO];
        }
    } else if (scrollView == _tableView) {
        if (offsetY < 0) {
            if (!_isShowComments) {
                [_tableView setContentOffset:CGPointMake(0, 0)];
                [self setScrollViewStatusIsWeb:YES];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
