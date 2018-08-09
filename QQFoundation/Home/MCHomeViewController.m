//
//  MCHomeViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCHomeViewController.h"
#import "MCTextFieldCell.h"
@interface MCHomeViewController ()

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabManager[@"MCTextFieldItem"] = @"MCTextFieldCell";
    [self iniUI];
}
- (void)iniUI
{
    NSMutableArray *items = [NSMutableArray array];
    
    MCTextFieldItem *TextFieldItem = [[MCTextFieldItem alloc]init];
    TextFieldItem.leftText = @"商品价格";
    TextFieldItem.rightText = @"输入价格";
    [items addObject:TextFieldItem];
    
    [self.tabManager replaceSectionsWithSectionsFromArray:items];
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
