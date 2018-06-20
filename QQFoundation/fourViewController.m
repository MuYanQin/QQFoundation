//
//  fourViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fourViewController.h"
#import "threeViewController.h"
#import "QQFileManage.h"
#import "QQButton.h"
#import "MCDownloadManager.h"
@interface fourViewController ()

@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"four";
    self.view.backgroundColor = [UIColor purpleColor];
    QQButton *start = [QQButton buttonWithFrame:CGRectMake(100, 64, 100, 40) title:@"开始" ClickBlock:^(QQButton *myButton) {
        [[MCDownloadManager defaultManager]startDownloadWith:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V6.0.1.dmg"];
        [[MCDownloadManager defaultManager]startDownloadWith:@"https://mp4.1sj.tv/mp4/78b31daf2731ea0d491af530b6f4bde7.mp4"];
        [[MCDownloadManager defaultManager]startDownloadWith:@"https://vd1.bdstatic.com/mda-hiqmm8s10vww26sx/mda-hiqmm8s10vww26sx.mp4"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSArray *te = @[@"1"];
//            NSLog(@"%@",te[3]);
//        });
    }];
    [self.view addSubview:start];
    
    QQButton *pause = [QQButton buttonWithFrame:CGRectMake(100, 120, 100, 40) title:@"暂停" ClickBlock:^(QQButton *myButton) {
        [[MCDownloadManager defaultManager] PauseAllTask];
        
    }];
    [self.view addSubview:pause];
    
    QQButton *resume = [QQButton buttonWithFrame:CGRectMake(100, 170, 100, 40) title:@"恢复" ClickBlock:^(QQButton *myButton) {
        [[MCDownloadManager defaultManager] resumeTaskWith:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V6.0.1.dmg"];
        
    }];
    [self.view addSubview:resume];
    
    QQButton *clean = [QQButton buttonWithFrame:CGRectMake(100, 220, 100, 40) title:@"清空" ClickBlock:^(QQButton *myButton) {
        [[MCDownloadManager defaultManager] cleanDisk];
        
    }];
    [self.view addSubview:clean];
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
