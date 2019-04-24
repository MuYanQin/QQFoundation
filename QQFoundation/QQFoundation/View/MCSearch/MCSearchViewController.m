//
//  MCSearchViewController.m
//  handRent
//
//  Created by qinmuqiao on 2019/1/7.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "MCSearchViewController.h"
#import "MCSearchCleanCell.h"
#import "MCSearchCell.h"
#import "NSString+Manage.h"
#import "NSMutableAttributedString+Manage.h"
#import "QQTool.h"
static NSString *const keyU = @"searchHistory";
@interface MCSearchViewController ()<UITextFieldDelegate>
@property (nonatomic , strong) QQTextField * textField;
@property (nonatomic , strong) NSMutableArray * history;
@end

@implementation MCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleView];
    self.BaseQQTableView.isHasHeaderRefresh = NO;
    [self nav_RightItemWithStr:@"取消" Selector:@selector(cancel)];
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.tabManager[@"MCSearchCleanItem"] = @"MCSearchCleanCell";
    NSArray *tem = [[NSUserDefaults standardUserDefaults] objectForKey:keyU];
    self.history = [NSMutableArray arrayWithArray:tem];
    [self initHistory];
}
- (void)initTitleView
{
    UIView *Nv = [[UIView alloc]init];
//    Nv.frame = CGRectMake(0, 0, 250, 25);
    Nv.backgroundColor = getColorWithAlpha(255, 255, 255, 0.2);
    Nv.layer.cornerRadius = 5;
    Nv.layer.masksToBounds = YES;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hr_search"]];
    [Nv addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Nv.mas_centerY);
        make.left.equalTo(Nv).offset(10);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    self.textField = [[QQTextField alloc]init];
    self.textField.font = getFontMedium(13);
    self.textField.textColor = getColorWithAlpha(255, 255, 255, 1);
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"请输入要搜索的姓名或编号"];
    text.color(getColorWithAlpha(255, 255, 255, 0.5));
    self.textField.attributedPlaceholder = text;
    [self.textField becomeFirstResponder];
    [Nv addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(Nv);
        make.left.equalTo(imageV.mas_right).offset(10);
        make.right.equalTo(Nv.mas_right).offset(-10);
    }];
    
    self.navigationItem.titleView = Nv;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([QQTool isBlank:textField.text]) {
        return NO;
    }
    if ([self.deletegate respondsToSelector:@selector(MCSearchView:searchText:)]) {
        [self.deletegate MCSearchView:self searchText:textField.text];
    }
    
    if (![self.history containsObject:textField.text]) {
        [self.history addObject:textField.text];
        [[NSUserDefaults standardUserDefaults]setObject:self.history forKey:keyU];
        [self initHistory];
        
    }
    return YES;
}
- (void)initHistory
{
    QQWeakSelf;
    [self.BaseMutableArray removeAllObjects];
    
    [self.history enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.text = obj;
        item.del = ^(MCSearchItem * _Nonnull tt) {
            [weakSelf.history removeObject:tt.text];
            [[NSUserDefaults standardUserDefaults]setObject:weakSelf.history forKey:keyU];
            [weakSelf.BaseMutableArray removeObject:tt];
            [tt deleteRowWithAnimation:UITableViewRowAnimationNone];
        };
        item.selcetCellHandler = ^(MCSearchItem * titem) {
            if ([weakSelf.deletegate respondsToSelector:@selector(MCSearchView:searchText:)]) {
                [weakSelf.deletegate MCSearchView:weakSelf searchText:titem.text];
            }
        };
        [weakSelf.BaseMutableArray addObject:item];
    }];
    
    if (self.BaseMutableArray.count>0) {
        MCSearchCleanItem *item = [[MCSearchCleanItem alloc]init];
        item.clean = ^{
            [weakSelf.history removeAllObjects];
            [[NSUserDefaults standardUserDefaults]setObject:weakSelf.history forKey:keyU];
            [weakSelf.BaseMutableArray removeAllObjects];
            [weakSelf.tabManager replaceWithSectionsFromArray:weakSelf.BaseMutableArray];
        };
        [weakSelf.BaseMutableArray addObject:item];
    }
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.navigationItem.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
        make.left.equalTo(self.navigationController.navigationBar).offset(16);
        make.right.equalTo(self.navigationController.navigationBar).offset(-60);
        make.height.mas_equalTo(30);
    }];
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
