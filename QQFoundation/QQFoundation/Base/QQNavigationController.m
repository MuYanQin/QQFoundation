//
//  QQNavigationController.m
//  Customer
//
//  Created by 秦慕乔 on 16/5/16.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQNavigationController.h"
#import "QQNetManager.h"
#import "UIColor+Hexadecimal.h"
@interface QQNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    UIViewController *tempVC;///栈顶的控制器
}
@property (assign, nonatomic) BOOL isSwitching;//判断push动作有没有完成  没有完成则忽略 下一次push
@end

@implementation QQNavigationController

+ (void)initialize{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加系统自带的手势返回
    self.delegate = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }

    self.view.backgroundColor = [UIColor whiteColor];
   //设置透明度  相差64像素  YES会有蒙层
    self.navigationBar.translucent = YES;
    //设置颜色
    self.navigationBar.barTintColor =[UIColor colorWithR:0 G:122 B:255 A:1];


    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
        //如应用中出现seachbar的跳动，视图位置出现问题，有可能是这里引起的
        self.edgesForExtendedLayout = UIRectEdgeNone;//视图控制器，四条边不指定

        self.extendedLayoutIncludesOpaqueBars = NO;//不透明的操作栏
        //设置view的位置
        self.modalPresentationCapturesStatusBarAppearance = NO;
       /* [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                          forBarPosition:UIBarPositionTop
                                              barMetrics:UIBarMetricsDefault];*/
        //设置navi透明需要translucent = yes,设置图片，barMetrics（更改类型得到不同的效果）
    }
    //nav下面的横线消失
    self.navigationBar.shadowImage = [UIImage new];
    
}

/**
 这里为什么用self.viewControllers.lastObject 而不是用popViewControllerAnimated返回的VC
 因为当你push进一个界面及时返回的时候  那么popViewControllerAnimated返回的是nil
 - (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.
答：：：因为如果你是pop Animated设置为Yes的时候 界面返回了back走了  但是因为动画还没有结束所以返回的是nil
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
#warning 这里可以设置返回手势的开关
//推送的视图将要出现时将侧滑返回设置为真
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1){
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        if(self.CanSlider ){
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    //获取栈顶的Vc
    tempVC = navigationController.viewControllers.lastObject;
    self.isSwitching = NO; // 3. 还原状态

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    id<UIViewControllerTransitionCoordinator> tc = navigationController.topViewController.transitionCoordinator;
    [tc notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //手势返回  成功取消
        if (![context isCancelled]) {
            //这里打印的是栈顶的VC   所以要tempVC中间过渡
            [[QQNetManager defaultManager] deleteConnectionVC:tempVC];
            NSLog(@"全屏手势返回");
        }
    }];
}

//配合修改状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.isSwitching) {
        return [super popToViewController:viewController animated:animated];
    } else {
        return nil;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (!self.isSwitching) {
        //返回调用此方法取消请求  如果是请求完成则从数组中去除本子请求
        [[QQNetManager defaultManager] deleteConnectionVC:self.viewControllers.lastObject];
        return [super popViewControllerAnimated:animated];
    } else {
        //        [self enqueuePopViewController:nil animate:animated];
        return nil;
    }
}

// 重载 push 方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //防止在push的过程中触发返回的时间导致崩溃
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.isSwitching) {
        return; // 1. 如果是动画，并且正在切换，直接忽略
    }
    self.isSwitching = YES; // 2. 否则修改状态
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = CGRectMake(0, 0, 70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}

// 为了解决与scroll的手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        //        [_scrollView.panGestureRecognizer requireGestureRecognizerToFail:screenEdgePanGestureRecognizer];
        return NO;
    }else{
        return  YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
