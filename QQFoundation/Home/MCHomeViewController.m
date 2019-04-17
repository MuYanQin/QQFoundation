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
#import "MCAllTextCell.h"
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
    self.tabManager[@"MCAllTextItem"] = @"MCAllTextCell";
    self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    [self iniUI];
    [self getrequest];
    
}
- (void)iniUI
{
    QQWeakSelf;
    QQTableViewSection *section = [QQTableViewSection section];
    section.indexTitle = @"A";
    section.sectionTitle = @"A";
    section.sectionHeight = 20;
    QQTableViewSection *section1 = [QQTableViewSection section];
    section1.indexTitle = @"B";
    section1.sectionHeight = 20;
    section1.sectionTitle = @"B";
    
    
    MCTextFieldItem *TextFieldItem = [[MCTextFieldItem alloc]init];
    TextFieldItem.leftText = @"商品价格";
    TextFieldItem.placeholderText = @"输入价格";
    [section addItem:TextFieldItem];
    
    //自适应文字高度
    MCAllTextItem *text = [[MCAllTextItem alloc]init];
    text.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightBold)];
    text.text = @"在总书记讲话精神的指引下，一年间海南省推出一系列重要举措，优化营商环境、支持人才引进、加强科技创新，坚持以制度创新为抓手，推动海南自贸区高标准、高质量建设，涌现出许多有亮点有特色的典型案例，央视网带您一图了解！";
    [section addItem:text];
    
    MCEmptyItem *empty1 = [[MCEmptyItem alloc]initWithHeight:10];
    empty1.bgColor = getColorWithHex(@"f8f8f8");
    [section addItem:empty1];
    /**
     自适应文字高度 详细的使用  参见文件中的autoCellHeight方法
     */
    MCAllTextItem *text1 = [[MCAllTextItem alloc]init];
    text1.font = [UIFont systemFontOfSize:18 weight:(UIFontWeightRegular)];
    text1.text = @"在总书记讲话精神的指引下，一年间海南省推出一系列重要举措，优化营商环境、支持人才引进、加强科技创新，坚持以制度创新为抓手，推动海南自贸区高标准、高质量建设，涌现出许多有亮点有特色的典型案例，央视网带您一图了解！在总书记讲话精神的指引下，一年间海南省推出一系列重要举措，优化营商环境、支持人才引进、加强科技创新，坚持以制度创新为抓手，推动海南自贸区高标准、高质量建设，涌现出许多有亮点有特色的典型案例，央视网带您一图了解！";
    [section addItem:text1];
    
    MCLableItem *lableItem = [[MCLableItem alloc]init];
    lableItem.leftText = @"视图弹出";
    lableItem.rightText = @"点击弹出视图";
    lableItem.selcetCellHandler = ^(id item) {

    };
    lableItem.slideCellHandler = ^(id item, NSInteger index) {
        NSLog(@"====%ld",(long)index);
    };
    [section addItem:lableItem];
    
    MCLableItem *slide = [[MCLableItem alloc]init];
    slide.leftText = @"侧滑我";
    slide.rightText = @"侧滑";
    slide.allowSlide = YES;
    NSArray *texta = @[@"删除",@"收藏"];
    slide.slideTextArray =texta ;
    slide.slideColorArray = @[[UIColor redColor],[UIColor blueColor]];
    slide.slideCellHandler = ^(id item, NSInteger index) {
        NSLog(@"===点了%@",texta[index]);
    };
    [section addItem:slide];
    
    
    MCLableItem *contentView = [[MCLableItem alloc]init];
    contentView.leftText = @"侧滑视图";
    contentView.rightText = @"";

//    [items addObject:contentView];
    
    MCLableItem *alertView = [[MCLableItem alloc]init];
    alertView.leftText = @"自定义alertView";
    alertView.rightText = @"";
    alertView.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:alertView];
    
    
    MCLableItem *QRCode = [[MCLableItem alloc]init];
    QRCode.leftText = @"二维码生成、扫描";
    QRCode.rightText = @"";
    QRCode.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:QRCode];
    
    MCLableItem *FMDB = [[MCLableItem alloc]init];
    FMDB.leftText = @"数据库操作集";
    FMDB.rightText = @"";
    FMDB.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:FMDB];
    
    MCLableItem *download = [[MCLableItem alloc]init];
    download.leftText = @"NSURLSession下载工具";
    download.rightText = @"";
    download.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:download];
    
    MCLableItem *netWork = [[MCLableItem alloc]init];
    netWork.leftText = @"网络请求工具";
    netWork.rightText = @"";
    netWork.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:netWork];
    
    MCLableItem *tableView = [[MCLableItem alloc]init];
    tableView.leftText = @"QQTableView使用";
    tableView.rightText = @"";
    tableView.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:tableView];
    
    
    MCLableItem *button = [[MCLableItem alloc]init];
    button.leftText = @"QQButton使用";
    button.rightText = @"";
    button.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:button];
    
    MCLableItem *QQDateFormatter = [[MCLableItem alloc]init];
    QQDateFormatter.leftText = @"QQDateFormatter缓存";
    QQDateFormatter.rightText = @"";
    QQDateFormatter.selcetCellHandler = ^(id item) {
        
    };
    [section addItem:QQDateFormatter];
    
    
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
    [section1 addItem:mcpickerView];
    
    
    MCLableItem *PageView = [[MCLableItem alloc]init];
    PageView.leftText = @"MCPageView使用";
    PageView.rightText = @"";
    PageView.selcetCellHandler = ^(id item) {
        [weakSelf.navigationController pushViewController:[MCPageViewViewController new] animated:YES];
    };
    [section1 addItem:PageView];
    
    MCEmptyItem *empty2 = [[MCEmptyItem alloc]initWithHeight:40];
    empty2.bgColor = getColorWithHex(@"f8f8f8");
    [section1 addItem:empty2];
    
    [self.tabManager replaceSectionsWithSectionsFromArray:@[section,section1]];
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
