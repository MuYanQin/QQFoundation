//
//  MCSearchViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCSearchViewController.h"
#import "MCPickerView.h"
#import "MCPickerModel.h"
@interface MCSearchViewController ()<MCPickerViewDelegate>

@end

@implementation MCSearchViewController
{
    MCPickerView *picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    __block NSMutableArray *models = [NSMutableArray array];
    
    for (int i=0; i<5; i++) {
        MCPickerModel *model = [[MCPickerModel alloc]init];
        model.name = @"安徽省";
        model.pid = @"123";
        [models addObject:model];
    }
    picker = [[MCPickerView alloc]initWithFrame:self.view.bounds];
    picker.dataArray = models;
    picker.delegate = self;
    picker.totalLevel = 3;//共有3层数据
    picker.titleText = @"选择地区";
    [self.view addSubview:picker];
}
- (void)MCPickerView:(MCPickerView *)MCPickerView complete:(NSString *)complete
{
    NSLog(@"===%@",complete);
}
- (void)MCPickerView:(MCPickerView *)MCPickerView didSelcetedRow:(NSInteger)Row value:(MCPickerModel *)value
{
    if (Row == 0) {
        __block NSMutableArray *models = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            MCPickerModel *model = [[MCPickerModel alloc]init];
            model.name = @"合肥市";
            model.pid = @"123";
            [models addObject:model];
        }
        picker.dataArray = models;
    }else if(Row == 1){
        __block NSMutableArray *models = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            MCPickerModel *model = [[MCPickerModel alloc]init];
            model.name = @"蜀山区";
            model.pid = @"123";
            [models addObject:model];
        }
        picker.dataArray = models;
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
