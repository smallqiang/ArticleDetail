//
//  ViewController.m
//  ArticleDetail
//
//  Created by ChenYaoqiang on 14-10-13.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    detailButton.frame = CGRectMake(100, 100, 120, 50);
    [detailButton setTitle:@"详情页" forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(pushToDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailButton];
}

- (void)pushToDetail
{
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
