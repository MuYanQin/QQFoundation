//
//  twoViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "twoViewController.h"
#import "NSDate+QQCalculate.h"
@interface twoViewController ()
@property (nonatomic,copy) NSString *dateAsString;
@property (nonatomic , strong) UIImageView * BackGroudImageview;
@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"two";
    self.view.backgroundColor = [UIColor yellowColor];

    [self nav_RightItemWithStr:@"Done" Selector:@selector(click)];
    self.BackGroudImageview = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.BackGroudImageview.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.BackGroudImageview];
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";//KVC的方式来访问属性
//    animation.fromValue = [NSValue valueWithCGSize:self.BackGroudImageview.frame.size];
//    animation.byValue = [NSValue valueWithCGSize:CGSizeMake(self.BackGroudImageview.frame.size.width *2, self.BackGroudImageview.frame.size.height *2)];
    animation.fromValue = @1.0;
    animation.toValue = @0.8;
    animation.duration = 1;//持续时间
    animation.repeatCount = 110;//无限循环
    animation.speed = 1;//速度
    //    animation.repeatDuration = 10;//在多久哪动画有效
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//结束函数
    animation.autoreverses= YES;//回归是否是动画形式
    [self.BackGroudImageview.layer addAnimation:animation forKey:@"frame"];//添加动画
    
    
    return;
    //创建队列的方法
    dispatch_queue_t queue = dispatch_queue_create("qinmqiao", DISPATCH_QUEUE_SERIAL);//串
    dispatch_queue_t queue1 = dispatch_queue_create("qinmqiao", DISPATCH_QUEUE_CONCURRENT);//并
    dispatch_queue_t queue2 = dispatch_get_main_queue();//主队列
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//全剧队列
    //同步执行任务是不开启 线程的 即使是并行队列
    //异步执行任务开启新县城 并发就是并发 串行就是串行
    //栅栏操作 之前的执行完了才会执行栅栏里面的。最后才是栅栏后面的。需要同一个队列的
    dispatch_barrier_sync(queue2, ^{//同步执行任务
        
    });
    dispatch_barrier_async(queue2, ^{//异步执行任务
        
    });
    
    
    //延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
    
    //一次性执行操作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    
    //分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    //这里获取到通知完成。获取主队列进行操作
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
    
    
    
    //Dispatch Semaphore 线程同步
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue4, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);

}
- (void)click
{
    
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
