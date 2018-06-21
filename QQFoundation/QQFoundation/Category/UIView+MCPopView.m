//
//  UIView+MCPopView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/21.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UIView+MCPopView.h"
#import "KLCPopup.h"
@implementation UIView (MCPopView)
+ (void)showOnView:(UIView *)containView
          showType:(viewShowType)showType
          dissType:(viewDissType)dissType
      positionType:(viewPositionType)positionType
dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
{
    KLCPopupLayout  PopupLayout;
    if (positionType == viewPositionTypeCenter) {
        PopupLayout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutCenter);
    }else {
        PopupLayout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutBottom);
    }
    KLCPopupShowType PopupShowType;
    if (showType == viewShowTypeFadeIn) {
        PopupShowType = KLCPopupShowTypeFadeIn;
    }else if (showType == viewShowTypeGrowIn){
        PopupShowType = KLCPopupShowTypeGrowIn;
    }else if (showType == viewShowTypeShrinkIn){
        PopupShowType = KLCPopupShowTypeShrinkIn;
    }else if (showType == viewShowTypeBounceIn){
        PopupShowType = KLCPopupShowTypeBounceIn;
    }else if (showType == viewShowTypeSlideInFromTop){
        PopupShowType = KLCPopupShowTypeSlideInFromTop;
    }else if (showType == viewShowTypeSlideInFromBottom){
        PopupShowType = KLCPopupShowTypeSlideInFromBottom;
    }else if (showType == viewShowTypeBounceInFromTop){
        PopupShowType = KLCPopupShowTypeBounceInFromTop;
    }else {
        PopupShowType = KLCPopupShowTypeBounceInFromBottom;
    }
    KLCPopupDismissType  PopupDismissType;
    if (dissType == viewShowTypeFadeOut) {
        PopupDismissType = KLCPopupDismissTypeFadeOut;
    }else if (dissType == viewShowTypeGrowOut){
        PopupDismissType = KLCPopupDismissTypeGrowOut;
    }else if (dissType == viewShowTypeShrinkOut){
        PopupDismissType = KLCPopupDismissTypeShrinkOut;
    }else if (dissType == viewShowTypeBounceOut){
        PopupDismissType = KLCPopupDismissTypeBounceOut;
    }else if (dissType == viewShowTypeSlideOutFromTop){
        PopupDismissType = KLCPopupDismissTypeSlideOutToTop;
    }else if (dissType == viewShowTypeSlideOutFromBottom){
        PopupDismissType = KLCPopupDismissTypeSlideOutToBottom;
    }else if (dissType == viewShowTypeBounceOutFromTop){
        PopupDismissType = KLCPopupDismissTypeBounceOutToTop;
    }else {
        PopupDismissType = KLCPopupDismissTypeBounceOutToBottom;
    }
    KLCPopup* popup = [KLCPopup popupWithContentView:containView
                                            showType:PopupShowType
                                         dismissType:PopupDismissType
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:shouldDismissOnBackgroundTouch
                               dismissOnContentTouch:NO];
    [popup showWithLayout:PopupLayout];

}
@end
