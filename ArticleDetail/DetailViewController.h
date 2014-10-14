//
//  DetailViewController.h
//  ArticleDetail
//
//  Created by ChenYaoqiang on 14-10-13.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    float _contentHeight;   //文章内容高度
    float _tableViewHeight;
    
    BOOL _isShowWebView;    //是否正在显示内容
    BOOL _isShowComments;   //是否正在显示评论
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIScrollView *webScrollView;

@property (nonatomic, strong) UITableView *tableView;

@end
