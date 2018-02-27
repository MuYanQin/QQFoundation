//
//  DefaultAnimation.m
//  QQFoundation
//
//  Created by Maybe on 2018/1/23.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "DefaultAnimation.h"
#import "QQAlertController.h"
@implementation DefaultAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    QQAlertController *toVC = (QQAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toVC || !fromVC) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toVC.isBeingPresented) {
        // 2
        [containerView addSubview:toVC.view];
        toVC.view.frame = CGRectMake(0.0, 0.0, containerView.frame.size.width, containerView.frame.size.height);
        [UIView animateWithDuration:duration animations:^{
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else if (fromVC.isBeingDismissed) {
        // 3
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end
