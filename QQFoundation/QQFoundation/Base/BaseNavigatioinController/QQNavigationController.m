//
//  QQNavigationController.m
//  Customer
//
//  Created by Yuan er on 16/5/16.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import "QQNavigationController.h"
#import "QQNetManager.h"
#import "MCFactory.h"
#import "AppDelegate.h"
@interface QQNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
{
    UIViewController *tempVC;///<栈顶的控制器
}

/**
 判断push动作有没有完成  没有完成则忽略 下一次push
 */
@property (assign, nonatomic) BOOL isSwitching;
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
    
   //设置透明度  相差64像素  YES会有蒙层
    //YES (0,0)->(0,0)  NO(0.64) - >(0,0)
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = getColorWithAlpha(0, 122, 255, 1);
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
        self.edgesForExtendedLayout = UIRectEdgeNone;//视图控制器，四条边不指定
        
        //如应用中出现seachbar的跳动，视图位置出现问题，有可能是这里引起的
        self.extendedLayoutIncludesOpaqueBars = NO;//不透明的操作栏
        //设置状态栏的不隐藏
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    //nav下面的横线消失
    self.navigationBar.shadowImage = [UIImage new];
    //iOS 10 设置backBarButtonItem颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

/**
 这里为什么用self.viewControllers.lastObject 而不是用popViewControllerAnimated返回的VC
 因为当你push进一个界面及时返回的时候  那么popViewControllerAnimated返回的是nil
 - (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.
答：：：因为如果你是pop Animated设置为Yes的时候 界面返回了back走了  但是因为动画还没有结束所以返回的是nil
 */

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1){
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        if(self.forbidSlider){
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            navigationController.interactivePopGestureRecognizer.enabled = YES;
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
            
        }
    }];
    ///设置隐藏 nav 如果遵循代理且viewController 同一个就隐藏
    if ([self.navHiddenDelegate respondsToSelector:@selector(needHiddenNav)] && viewController == [self.navHiddenDelegate needHiddenNav]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        ///如果出来的是图片选择的 则不做处理
        if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
            return;
        }
        [navigationController setNavigationBarHidden:NO animated:YES];
        ///及时将代理设置为空 否则代理存在 但是界面pop之后会引起空指针
        self.navHiddenDelegate = nil;
    }
    
}
#pragma mark - UINavigationBarDelegate

//是否能pop到上一个界面
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    /**
     手势返回时候打印
     po navigationBar.items
     <__NSArrayI 0x2834f62a0>(
     <UINavigationItem: 0x117e05520> title='案例使用1' backBarButtonItem=0x117d8e290,
     <UINavigationItem: 0x117e8abd0>
     )
     
     po self.viewControllers
     <__NSSingleObjectArrayI 0x2836b4b10>(
     <MCHomeViewController: 0x117e0dc90>
     )
     
     点击返回按钮打印
     po self.viewControllers
     <__NSArrayI 0x280a5ec80>(
     <MCHomeViewController: 0x1037103c0>,
     <MCCollectionViewController: 0x103870f10>
     )
     */
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    //响应代理 栈顶VC相同 则返回NO
    if ([self.navBackDelegate respondsToSelector:@selector(backItemClickEvent)]) {
        if(self.topViewController == [self.navBackDelegate backItemClickEvent] ){
            [self.navBackDelegate backItemClickEvent];
            return NO;
        }
    }
  if( ([[[UIDevice currentDevice] systemVersion] doubleValue] <13.0)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    
    return YES;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(nonnull UINavigationItem *)item
{
    self.navBackDelegate = nil;
}
//MARK: 重载 popTo 方法
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.isSwitching) {
        return [super popToViewController:viewController animated:animated];
    } else {
        return nil;
    }
}
//MARK: 重载 pop 方法
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {

    if (!self.isSwitching) {
        
        
        //界面pop将代理置空
        return [super popViewControllerAnimated:animated];
    } else {
        //        [self enqueuePopViewController:nil animate:animated];
        return nil;
    }
}

//MARK: 重载 push 方法
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
    //界面push将代理置空
    self.navBackDelegate = nil;
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = getFontRegular(14);
    [backItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [backItem setTintColor:[UIColor whiteColor]];
    viewController.navigationItem.backBarButtonItem = backItem;
    [super pushViewController:viewController animated:animated];
}

//MARK:-- 为了解决与scroll的手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        return YES;
    }else{
        return NO;
    }
}
//MARK:-- 配合修改状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
