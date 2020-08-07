//
//  QYArticleEditViewController.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QYArticleEditViewController.h"
#import "QYArticleTextCell.h"
#import "QYEmptyCell.h"
#import "QYArticleImgCell.h"
#import "CCTZImgPickerTool.h"
@interface QYArticleEditViewController ()
@property (nonatomic , strong) CCTZImgPickerTool *imgTool;
@property (nonatomic , strong) QQTableViewSection *section;
@end

@implementation QYArticleEditViewController
{
    QYEmptyItem *em;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self nav_RightDraftWithArr:@[@"下一步",@"排序"] Selector:@selector(nextStep) Selector1:@selector(paixu)];
    self.tabManager[@"QYArticleTextItem"] = @"QYArticleTextCell";
    self.tabManager[@"QYEmptyItem"] = @"QYEmptyCell";
    self.tabManager[@"QYArticleImgItem"] = @"QYArticleImgCell";
    
    self.title = @"发布文章";
    [self iniList];
}
- (void)iniList{
    self.section = [QQTableViewSection section];
    [self.BaseMutableArray addObject:self.section];
    
    em = [[QYEmptyItem alloc]initWithHeight:10];
    [self.section addItem:em];
    
    QQWeakSelf
    QYArticleTextItem *text =  [[QYArticleTextItem alloc]init];
    text.cellHeight = 60;
    text.selectImgBlock = ^{
        [weakSelf addimgItem];
    };
    text.addTextItemBlock = ^{
        [weakSelf addTextItem];
    };
    [self.section addItem:text];
    
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)addimgItem{
    QQWeakSelf
    self.imgTool = [[CCTZImgPickerTool alloc]init];
    self.imgTool.maxCount = 1;
    [self.imgTool showSelectStyle];
    self.imgTool.selectImges = ^(NSArray * _Nonnull images, NSArray * _Nonnull assets) {
        UIImage *image = images[0];
        
        QYArticleImgItem *article = [[QYArticleImgItem alloc]init];
        article.image = image;
        CGFloat bili  = image.size.height/ image.size.width;
        article.cellHeight = bili *(KScreenWidth - 30) + 5;
        [weakSelf.section addItem:article];
        [weakSelf.tabManager replaceWithSectionsFromArray:weakSelf.BaseMutableArray];
    };
}
- (void)addTextItem{
    QQWeakSelf
    QYArticleTextItem *text =  [[QYArticleTextItem alloc]init];
    text.cellHeight = 60;
    text.selectImgBlock = ^{
        [weakSelf addimgItem];
    };
    text.addTextItemBlock = ^{
        [weakSelf addTextItem];
    };
    [self.section addItem:text];
    [weakSelf.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)nextStep
{
    
}
- (void)paixu
{
    
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
