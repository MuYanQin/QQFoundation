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

@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"two";
    [self convertDateToStringUsingNewDateFormatter];
    [self convertDateToStringUsingBTNSDateFormatterFactoryFormatter];
}
#define ITERATIONS (1024*10)
static double then, now;

#pragma test for costs time
- (void)convertDateToStringUsingNewDateFormatter
{
    then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < ITERATIONS; i++) {
        NSDateFormatter *newDateForMatter = [[NSDateFormatter alloc] init];
        [newDateForMatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [newDateForMatter setDateFormat:@"YYYY-MM-dd"];
        self.dateAsString = [newDateForMatter stringFromDate:[NSDate date]];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using NSDateFormatter costs time: %f seconds!\n", now - then);
}

- (void)convertDateToStringUsingBTNSDateFormatterFactoryFormatter
{
    then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < ITERATIONS; i++) {
        self.dateAsString = [NSDate GetNowDate:@"YYYY-MM-dd"];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using BTNSDateFormatterFactory Formatter costs time: %f seconds!\n", now - then);
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
