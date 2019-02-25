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
    UIButton *leftCustomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftCustomButton.widthAnchor constraintEqualToConstant:20].active = YES;
    [leftCustomButton.heightAnchor constraintEqualToConstant:20].active = YES;
    [leftCustomButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [leftCustomButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftCustomButton];
    self.navigationItem.rightBarButtonItem = leftButtonItem;
}

/**
 *  添加nav上右按钮，字符串
 */
- (void)nav_RightItemWithStr:(NSString *)str Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
}


/**
 *  添加nav上右按钮，字符串, 字体颜色
 */
- (void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
}

/**
 *  添加nav上右按钮，字符串, 字体颜色, 字体大小
 */
-(void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor FontSize:(CGFloat)size Selector:(SEL)sel{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
}

/**
 *  添加nav上左按钮，字符串
 */
- (void)nav_LeftItemWithStr:(NSString *)str Selector:(SEL)sel{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
