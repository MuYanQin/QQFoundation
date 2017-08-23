//
//  QQAlertcontroller.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "QQAlertcontroller.h"

@implementation QQAlertcontroller

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)alertmessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con SureBlock:(AlertBlcok)block;

{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:title message:Message preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * Sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }];
    
    //    [AlertControler addAction:Cancel];
    [AlertControler addAction:Sure];
    [con presentViewController:AlertControler animated:YES completion:nil];
    
}
+ (void)AlertMessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con   SureBlock:(void(^)())Sureblock
{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:title message:Message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * Sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (Sureblock) {
            Sureblock();
        }
    }];
    
    [AlertControler addAction:Cancel];
    [AlertControler addAction:Sure];
    [con presentViewController:AlertControler animated:YES completion:nil];
}
/**
 最传统的alert提示 双回调
 
 
 @param Message     提示信息
 @param title       标题
 @param con         附着在那个viewcontroller
 @param Sureblock   确定回调
 @param CanCelBlocl 取消回调
 */
+ (void)AlertMessage:(NSString *)Message  Title:(NSString *)title controller:(UIViewController *)con   Sureblock:(void(^)())Sureblock  Cancel:(void(^)())CanCelBlocl
{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:title message:Message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (CanCelBlocl) {
         CanCelBlocl();
        }
    }];
    UIAlertAction * Sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (Sureblock) {
            Sureblock();
        }
    }];
    [AlertControler addAction:Cancel];
    [AlertControler addAction:Sure];
    [con presentViewController:AlertControler animated:YES completion:nil];
}
+ (void)alertmessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con Now:(void(^)())NowBlock  Moment:(void(^)())MomentBlock  andIgnore:(void(^)())IgoreBlock
{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:title message:Message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * Now = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NowBlock();
    }];
    UIAlertAction * Moment = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NowBlock();
        
    }];
    UIAlertAction * Igore = [UIAlertAction actionWithTitle:@"忽略此版本" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        IgoreBlock();
        
    }];
    [AlertControler addAction:Now];
    [AlertControler addAction:Moment];
    [AlertControler addAction:Igore];
    
    [con presentViewController:AlertControler animated:YES completion:nil];
}
@end
