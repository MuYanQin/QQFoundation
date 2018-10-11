//
//  MCPickerViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/13.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPickerViewController.h"
#import "MCPickerView.h"
#import "MCPickerModel.h"
#import <MJExtension.h>
#import "UIView+MBProgress.h"
@interface MCPickerViewController ()<MCPickerViewDelegate>
@property (nonatomic , strong) MCPickerView *picker ;
@property (nonatomic , strong) NSMutableArray * pro;
@end

@implementation MCPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择地址";
    self.pro = [NSMutableArray array];
    QQWeakSelf
    NSString *path = [[NSBundle mainBundle]pathForResource:@"addr" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];    
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.pro addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"方式1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(click2One) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:button];

}
- (void)MCPickerView:(MCPickerView *)MCPickerView complete:(NSString *)complete
{
    
}
- (void)MCPickerView:(MCPickerView *)MCPickerView didSelcetedTier:(NSInteger)Tier  value:(MCPickerModel *)value
{
    if (Tier == 0) {
        __block NSMutableArray *tempCity = [NSMutableArray array];
        [value.child enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempCity addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
        }];
        self.picker.dataArray = tempCity;

    }else if (Tier ==1){
        __block NSMutableArray *tempTown = [NSMutableArray array];
        [value.child enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempTown addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
        }];
        self.picker.dataArray = tempTown;
    }
}
- (void)click2One
{
    [self.view message:@"哈哈哈"];
//    [self.navigationController popViewControllerAnimated:YES];
    return;
    self.picker  =[[MCPickerView alloc]initWithFrame:self.view.bounds];
    self.picker.delegate = self;
    self.picker.totalTier = 3;
    self.picker.titleText = @"选择区域";
    self.picker.dataArray = self.pro;
    [self.view addSubview:self.picker];
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
