//
//  MCHomeViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCHomeViewController.h"
#import "MCTextFieldCell.h"
#import "MCEmptyCell.h"
#import "MCLableCell.h"
#import "UIView+QQFrame.h"
#import "QQNetManager.h"
#import "MCMineViewController.h"
#import "MCPickerViewController.h"
#import "MCPageViewViewController.h"
#import "MCPushMediator.h"
@interface MCHomeViewController ()

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例使用1";
    self.tabManager[@"MCTextFieldItem"] = @"MCTextFieldCell";
    self.tabManager[@"MCEmptyItem"] = @"MCEmptyCell";
    self.tabManager[@"MCLableItem"] = @"MCLableCell";
    [self iniUI];
    [self getrequest];
    
}
- (void)iniUI
{
    NSMutableArray *items = [NSMutableArray array];
    
    QQWeakSelf
    MCEmptyItem *empty = [[MCEmptyItem alloc]initWithHeight:15];
    empty.bgColor = getColorWithHex(@"f8f8f8");
    [items addObject:empty];
    
    MCTextFieldItem *TextFieldItem = [[MCTextFieldItem alloc]init];
    TextFieldItem.leftText = @"商品价格";
    TextFieldItem.placeholderText = @"输入价格";
    [items addObject:TextFieldItem];
    
    MCLableItem *lableItem = [[MCLableItem alloc]init];
    lableItem.leftText = @"视图弹出";
    lableItem.rightText = @"点击弹出视图";
    lableItem.allowSlide = YES;
    lableItem.slideTextArray = @[@"删除",@"喜欢",@"收藏"];
    lableItem.selcetCellHandler = ^(id item) {

    };
    lableItem.slideCellHandler = ^(id item, NSInteger index) {
        NSLog(@"====%ld",index);
    };
    [items addObject:lableItem];
    
    MCLableItem *slide = [[MCLableItem alloc]init];
    slide.leftText = @"侧滑我";
    slide.rightText = @"侧滑";
    slide.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:slide];
    
    
    MCLableItem *contentView = [[MCLableItem alloc]init];
    contentView.leftText = @"侧滑视图";
    contentView.rightText = @"";
    contentView.selcetCellHandler = ^(id item) {
        [self.navigationController pushViewController: [MCMineViewController new] animated:YES];
    };
    [items addObject:contentView];
    
    MCLableItem *alertView = [[MCLableItem alloc]init];
    alertView.leftText = @"自定义alertView";
    alertView.rightText = @"";
    alertView.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:alertView];
    
    
    MCLableItem *QRCode = [[MCLableItem alloc]init];
    QRCode.leftText = @"二维码生成、扫描";
    QRCode.rightText = @"";
    QRCode.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:QRCode];
    
    MCLableItem *FMDB = [[MCLableItem alloc]init];
    FMDB.leftText = @"数据库操作集";
    FMDB.rightText = @"";
    FMDB.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:FMDB];
    
    MCLableItem *download = [[MCLableItem alloc]init];
    download.leftText = @"NSURLSession下载工具";
    download.rightText = @"";
    download.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:download];
    
    MCLableItem *netWork = [[MCLableItem alloc]init];
    netWork.leftText = @"网络请求工具";
    netWork.rightText = @"";
    netWork.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:netWork];
    
    MCLableItem *tableView = [[MCLableItem alloc]init];
    tableView.leftText = @"QQTableView使用";
    tableView.rightText = @"";
    tableView.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:tableView];
    
    
    MCLableItem *button = [[MCLableItem alloc]init];
    button.leftText = @"QQButton使用";
    button.rightText = @"";
    button.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:button];
    
    MCLableItem *QQDateFormatter = [[MCLableItem alloc]init];
    QQDateFormatter.leftText = @"QQDateFormatter缓存";
    QQDateFormatter.rightText = @"";
    QQDateFormatter.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:QQDateFormatter];
    
    
    MCLableItem *mcpickerView = [[MCLableItem alloc]init];
    mcpickerView.leftText = @"MCPickerView使用";
    mcpickerView.rightText = @"";
    mcpickerView.selcetCellHandler = ^(id item) {
        MCPickerViewController *PickerView = [MCPickerViewController new];
        PickerView.pushCallBack = ^(id data) {
            NSLog(@"=======%@",data);
        };
        [weakSelf.navigationController pushViewController:PickerView animated:YES];
    };
    [items addObject:mcpickerView];
    
    
    MCLableItem *PageView = [[MCLableItem alloc]init];
    PageView.leftText = @"MCPageView使用";
    PageView.rightText = @"";
    PageView.selcetCellHandler = ^(id item) {
        [weakSelf.navigationController pushViewController:[MCPageViewViewController new] animated:YES];
    };
    [items addObject:PageView];
    
    MCEmptyItem *empty1 = [[MCEmptyItem alloc]initWithHeight:40];
    empty1.bgColor = getColorWithHex(@"f8f8f8");
    [items addObject:empty1];
    
    [self.tabManager replaceSectionsWithSectionsFromArray:items];
}
- (void)getrequest{

    

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
