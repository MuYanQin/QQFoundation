//
//  QQBarItemViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBarItemViewController.h"
//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0
//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface QQBarItemViewController ()

@end

@implementation QQBarItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - navbar添加button
- (void)addRightBtnWithStr:(NSString *)str andSelector:(SEL)sel
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, WGiveWidth(-6), 0, WGiveWidth(6))];
}

-(void)addNaviRightBtnWithStr:(NSString *)str andTintColor:(UIColor *)tintColor andSelector:(SEL)sel {
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}

-(void)addNaviRightBtnWithStr:(NSString *)str andTintColor:(UIColor *)tintColor andFontSize:(CGFloat)size andSelector:(SEL)sel {
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:str style:(UIBarButtonItemStyleDone) target:self action:sel];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
}

- (void)addLeftBtnWithStr:(NSString *)str andSelector:(SEL)sel
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)addRightBtnWithImgName:(NSString *)imgName andSelector:(SEL)sel
{
    //iOS 9
    UIButton *leftCustomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftCustomButton.widthAnchor constraintEqualToConstant:20].active = YES;
    [leftCustomButton.heightAnchor constraintEqualToConstant:20].active = YES;
    [leftCustomButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [leftCustomButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftCustomButton];
    self.navigationItem.rightBarButtonItem = leftButtonItem;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
