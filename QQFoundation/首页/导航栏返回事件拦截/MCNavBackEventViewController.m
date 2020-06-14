//
//  MCNavBackEventViewController.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/14.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "MCNavBackEventViewController.h"
#import "QQNavigationController.h"
@interface MCNavBackEventViewController ()<QQNavigationNavBackDelegate>

@end

@implementation MCNavBackEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"获取点击事件";
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((QQNavigationController *)self.navigationController).navBackDelegate = self;
}
- (UIViewController *)backItemClickEvent
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定返回嘛？" preferredStyle:(UIAlertControllerStyleAlert)];
    QQWeakSelf
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
    return self;
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
