//
//  MCWebViewViewController.m
//  medicalConsult
//
//  Created by qinmuqiao on 2018/9/22.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCWebViewViewController.h"

#import <WebKit/WebKit.h>
@interface MCWebViewViewController ()
@property (nonatomic , strong) WKWebView * WebView;
@end

@implementation MCWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据详情";
    [self.WebView loadHTMLString:self.contentHtml baseURL:nil];
    [self.view addSubview:self.WebView];
    self.navigationController.navigationBar.barTintColor = getColorWithAlpha(0, 122, 255, 1);
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancel)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (WKWebView *)WebView
{
    if (!_WebView) {
        _WebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, MCNavHeight, KScreenWidth, KScreenHeight  - MCBottomDistance)];
        
    }
    return _WebView;
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
