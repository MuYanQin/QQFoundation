//
//  QQBarItemViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBarItemViewController.h"
@interface QQBarItemViewController ()

@end

@implementation QQBarItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - navbar添加button
/**
 *  添加nav上右按钮，图片
 */
- (void)nav_RightItemWithImg:(NSString *)imgName Selector:(SEL)sel{
    UIButton *rightCustomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightCustomButton.widthAnchor constraintEqualToConstant:20].active = YES;
    [rightCustomButton.heightAnchor constraintEqualToConstant:20].active = YES;
    [rightCustomButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [rightCustomButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [rightCustomButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    UIBarButtonItem * rightCustomItem =[[UIBarButtonItem alloc] initWithCustomView:rightCustomButton];
    self.navigationItem.rightBarButtonItem = rightCustomItem;
}

/**
 *  添加nav上右按钮，字符串
 */
- (void)nav_RightItemWithStr:(NSString *)str Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = rightitem;
}


/**
 *  添加nav上右按钮，字符串, 字体颜色
 */
- (void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:tintColor,NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = rightitem;
}
- (void)nav_RightDraftWithArr:(NSArray *)strs Selector:(SEL)sel Selector1:(SEL)sel1{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:strs[0] style:(UIBarButtonItemStyleDone) target:self action:sel];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:getColorWithHex(@"333333"),NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    
    UIBarButtonItem *rightitem1 = [[UIBarButtonItem alloc] initWithTitle:strs[1] style:(UIBarButtonItemStyleDone) target:self action:sel1];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:getColorWithHex(@"#855A09"),NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem1 setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [rightitem1 setTitleTextAttributes:dic1 forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItems = @[rightitem,rightitem1];
}
/**
 *  添加nav上右按钮，字符串, 字体颜色, 字体大小
 */
-(void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor FontSize:(CGFloat)size Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:tintColor,NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = rightitem;
}

/**
 *  添加nav上左按钮，字符串
 */
- (void)nav_LeftItemWithStr:(NSString *)str Selector:(SEL)sel{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
