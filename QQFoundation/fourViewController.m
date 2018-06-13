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
@interface fourViewController ()

@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"four";
    self.view.backgroundColor = [UIColor purpleColor];
    if ([QQFileManage isContainAtPath:[NSString stringWithFormat:@"%@%@",[QQFileManage GetCachesPath],@"/MCDownload"]]) {
        NSLog(@"123");
    }else{
        NSLog(@"456");
    }
    [QQFileManage CreateFolderWithPath:[QQFileManage GetCachesPath] FolderName:@"MCDownload" Success:^(NSString *Path, NSError *error) {
        if (!error) {
            NSLog(@"%@",Path);
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[threeViewController new] animated:YES];
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
