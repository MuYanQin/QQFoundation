//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
#import "QQButton.h"
@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIActivityViewController";

    QQButton *button = [QQButton buttonWithFrame:CGRectMake(100, 100, 50, 40) title:@"click" andBlock:^(UIButton *myButton) {
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@"我的"];
//        [items addObject:[UIImage imageNamed:@"1"]];
        [items addObject:@"https://www.baidu.com"];
        
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        NSMutableArray *excludedActivityTypes =  [NSMutableArray arrayWithArray:@[UIActivityTypeAirDrop, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeMail, UIActivityTypePostToTencentWeibo, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypePostToTwitter]];//不展示内容
        activityViewController.excludedActivityTypes = excludedActivityTypes;
        [self presentViewController:activityViewController animated:YES completion:nil];
        activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            NSLog(@"%@  ----   %@", activityType, returnedItems);
        };

    }];
    [self.view addSubview:button];

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
