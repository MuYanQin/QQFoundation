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
}
- (void)iniUI
{
    NSMutableArray *items = [NSMutableArray array];
    
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
    lableItem.selcetCellHandler = ^(id item) {
        
    };
    [items addObject:lableItem];
    
    
    MCLableItem *contentView = [[MCLableItem alloc]init];
    contentView.leftText = @"侧滑视图";
    contentView.rightText = @"";
    contentView.selcetCellHandler = ^(id item) {
        
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
    
    MCEmptyItem *empty1 = [[MCEmptyItem alloc]initWithHeight:15];
    empty1.bgColor = getColorWithHex(@"f8f8f8");
    [items addObject:empty1];
    
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
