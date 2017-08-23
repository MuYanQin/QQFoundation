//
//  QQTabBarController.m
//  Teacher
//
//  Created by tlt on 16/7/25.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTabBarController.h"
#import "QQNavigationController.h"
//#import "JYSlideSegmentController.h"
//#import "QQNavigationController.h"
//#import "BTCircleClassUnit.h"///<圈子
//#import "BTCircleSchoolUnit.h"///<圈子
//#import "BTContactsViewController.h"///<通讯录
//#import "BTHomeViewController.h"///<首页
//#import "BTMoreViewController.h"///<更多
//#import "BTMIneViewController.h"///<我的

static CGFloat standOutHeight = 12;

@interface QQTabBarController ()<UITabBarControllerDelegate>
@end

@implementation QQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
//    BTHomeViewController *home = [[BTHomeViewController alloc]init];
//    BTMIneViewController *mine = [[BTMIneViewController alloc]init];
//    BTMoreViewController *more = [[BTMoreViewController alloc]init];
//    BTContactsViewController *Contacts = [[BTContactsViewController alloc]init];
//    
//    BTCircleClassUnit   * CircleClass = [[BTCircleClassUnit alloc]init];
//    CircleClass.title = @"班级圈";
//    BTCircleSchoolUnit *CircleSchool = [BTCircleSchoolUnit new];
//    CircleSchool.title = @"校园圈";
//
//    JYSlideSegmentController *SlideSegment = [[JYSlideSegmentController alloc] initWithViewControllers:@[CircleClass,CircleSchool]];
//    SlideSegment.title = @"圈子";
//    SlideSegment.delegate = self;
//    SlideSegment.isShowRightBtn = YES;
//    SlideSegment.indicatorInsets = UIEdgeInsetsMake(0, 8, 0, 8);
//    
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
//    self.viewControllers = @[
//                            [self AddVC:home Title:@"首页" Image:[UIImage imageNamed:@"tabbar-unselected-icon"] andSelectImage:[self removeRendering:[UIImage imageNamed:@"tabbar-selected-icon"]]],
//                            [self AddVC:SlideSegment Title:@"圈子" Image:[UIImage imageNamed:@"tabbar_circle"] andSelectImage:[self removeRendering:[UIImage imageNamed:@"tabbar_circleHL"]]],
//                            [self AddVC:more Title:@"" Image:[self removeRendering:[UIImage imageNamed:@"tabbar_more"]] andSelectImage:[self removeRendering:[UIImage imageNamed:@"tabbar_moreHL"]]],
//                            [self AddVC:Contacts Title:@"通讯录" Image:[UIImage imageNamed:@"tabbar_contacts"] andSelectImage:[self removeRendering:[UIImage imageNamed:@"tabbar_contactsHL"]]],
//                             [self AddVC:mine Title:@"我" Image:[UIImage imageNamed:@"tabbar_mine"] andSelectImage:[self removeRendering:[UIImage imageNamed:@"tabbar_mineHL"]]]
//                            ];
    self.tabBar.tintColor = [UIColor colorWithRed:86.0/255.0 green:141.0/255.0 blue:216.0/255.0 alpha:1];///<如果图片不变只是改个颜色 就用着直接改。

    //在tabbar 上加一个绘线的imageview
    [self.tabBar insertSubview:[self drawTabbarBgImageView] atIndex:0];
    self.tabBar.opaque = YES;
    //第几个Item器偏移
    UITabBarItem *tabBarItem = (UITabBarItem *)self.tabBar.items[2];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, 5, 0)];
    /** 设置默认状态 中间的字体大小 颜色 */
    NSMutableDictionary *norDict = @{}.mutableCopy;
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
//    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:86/255.0 green:141/255.0 blue:216/255.0 alpha:1]} forState:UIControlStateSelected];
}
- (void)slideSegment:(UICollectionView *)segmentBar didSelectedViewController:(UIViewController *)viewController
{
//    if ([viewController isKindOfClass:[BTCircleClassUnit  class]]) {
//        BTCircleClassUnit *class = (BTCircleClassUnit*)viewController;
//        [class startAction];
//    }else if ([viewController isKindOfClass:[BTCircleSchoolUnit  class]]){
//        BTCircleSchoolUnit *class = (BTCircleSchoolUnit*)viewController;
//        [class startAction];
//    }
}
- (UIImage *)removeRendering:(UIImage *)image
{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (UIImage *)addRendering:(UIImage *)image
{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (UINavigationController *)AddVC:(UIViewController *)VC  Title:(NSString *)title Image:(UIImage *)image  andSelectImage:(UIImage *)selectImage
{
    
    QQNavigationController *nav = [[QQNavigationController alloc]initWithRootViewController:VC];
    VC.title = title;
    VC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[self removeRendering:image] selectedImage:selectImage ];
    //调整文字与图片的距离
    VC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-3);
    return nav;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImageView *)drawTabbarBgImageView
{
    //    NSLog(@"tabBarHeight：  %f" , tabBarHeight);// 设备tabBar高度 一般49
    CGFloat radius = 25;// 圆半径
    CGFloat allFloat= (pow(radius, 2)-pow((radius-standOutHeight), 2));// standOutHeight 突出高度 12
    CGFloat ww = sqrtf(allFloat);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -standOutHeight,[UIScreen mainScreen].bounds.size.width , 49 +standOutHeight)];// ScreenW设备的宽
    //    imageView.backgroundColor = [UIColor redColor];
    CGSize size = imageView.frame.size;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width/2 - ww, standOutHeight)];
//    NSLog(@"ww: %f", ww);
//    NSLog(@"ww11: %f", 0.5*((radius-ww)/radius));
    CGFloat angleH = 0.5*((radius-standOutHeight)/radius);
//    NSLog(@"angleH：%f", angleH);
    CGFloat startAngle = (1+angleH)*((float)M_PI); // 开始弧度
    CGFloat endAngle = (2-angleH)*((float)M_PI);//结束弧度
    // 开始画弧：CGPointMake：弧的圆心  radius：弧半径 startAngle：开始弧度 endAngle：介绍弧度 clockwise：YES为顺时针，No为逆时针
    [path addArcWithCenter:CGPointMake((size.width)/2, radius) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    // 开始画弧以外的部分
    [path addLineToPoint:CGPointMake(size.width/2+ww, standOutHeight)];
    [path addLineToPoint:CGPointMake(size.width, standOutHeight)];
    [path addLineToPoint:CGPointMake(size.width,size.height)];
    [path addLineToPoint:CGPointMake(0,size.height)];
    [path addLineToPoint:CGPointMake(0,standOutHeight)];
    [path addLineToPoint:CGPointMake(size.width/2-ww, standOutHeight)];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;// 整个背景的颜色
    layer.strokeColor = [UIColor colorWithWhite:0.765 alpha:1.000].CGColor;//边框线条的颜色
    layer.lineWidth = 0.7;//边框线条的宽
    // 在要画背景的view上 addSublayer:
    [imageView.layer addSublayer:layer];
    return imageView;
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
