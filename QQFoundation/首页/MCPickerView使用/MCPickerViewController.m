//
//  MCPickerViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/13.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCPickerViewController.h"
#import "MCPickerView.h"
#import "MCPickerModel.h"
#import <MJExtension.h>
#import "NSObject+MB.h"
#import "MCPushMediator.h"
#import "UIView+MCPopView.h"
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
- (void)MCPickerView:(MCPickerView *)MCPickerView completeArray:(NSMutableArray<MCPickerModel *> *)comArray completeStr:(NSString *)comStr
{
    
}
- (NSMutableArray<MCPickerModel *> *)MCPickerView:(MCPickerView *)MCPickerView didSelcetedTier:(NSInteger)tier selcetedValue:(MCPickerModel *)value
{
    __block NSMutableArray *tempTown = [NSMutableArray array];
    [value.child enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempTown addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
    }];
    return tempTown;
}
- (void)click2One
{
    self.picker  =[[MCPickerView alloc]initWithFrame:self.view.bounds];
    self.picker.delegate = self;
    self.picker.titleText = @"选择区域";
    self.picker.dataArray = self.pro;
    [self.view addSubview:self.picker];
//    [self.picker showType:(viewShowTypeBounceInFromBottom) dissType:(viewDissTypeBounceOutFromBottom) positionType:(viewPositionTypeBottom) dismissOnBackgroundTouch:NO];
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
