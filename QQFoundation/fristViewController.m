//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
#import "QQButton.h"
#import "threeViewController.h"

@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"副书记肯定会反馈撒";
//    [self addRightBtnWithStr:@"完成" andSelector:@selector(Deon)];
//    [self addNaviRightBtnWithStr:@"馈撒" andTintColor:[UIColor redColor] andSelector:@selector(Deon)];
//    [self addNaviRightBtnWithStr:@"馈撒" andTintColor:[UIColor purpleColor] andFontSize:14 andSelector:@selector(Deon)];
//    [self addRightBtnWithStr:@"@2x" andSelector:@selector(Deon)];
    [self addRightBtnWithImgName:@"barbuttonicon_back" andSelector:@selector(Deon)];
}
- (void)Deon
{
    
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
