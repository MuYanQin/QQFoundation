//
//  QQAlertcontroller.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertBlcok)();
@interface QQAlertcontroller : UIView

/**
 只有确定按钮 只有确定按钮的回调
 
 @param Message Message description
 @param title   title description
 @param con     con description
 @param block   block description
 */
+ (void)alertmessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con SureBlock:(AlertBlcok)block;


/**
 有 确定、取消按键  但只有确定按钮的回调
 
 
 @param Message   Message description
 @param title     title description
 @param con       con description
 @param Sureblock Sureblock description
 */
+ (void)AlertMessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con   SureBlock:(void(^)())Sureblock;

/**
 有 确定、取消按键  都有回调
 @param Message     提示信息
 @param title       标题
 @param con         附着在那个viewcontroller
 @param Sureblock   确定回调
 @param CanCelBlocl 取消回调
 */
+ (void)AlertMessage:(NSString *)Message  Title:(NSString *)title controller:(UIViewController *)con   Sureblock:(void(^)())Sureblock  Cancel:(void(^)())CanCelBlocl;
/**
 更新使用 呈上下排列装
 
 @param Message     提示信息
 @param title       标题
 @param con         <#con description#>
 @param NowBlock    <#NowBlock description#>
 @param MomentBlock <#MomentBlock description#>
 @param IgoreBlock  <#IgoreBlock description#>
 */
+ (void)alertmessage:(NSString *)Message   Title:(NSString *)title controller:(UIViewController *)con Now:(void(^)())NowBlock  Moment:(void(^)())MomentBlock  andIgnore:(void(^)())IgoreBlock;
@end
