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
+ (void)showView:(UIView *)containView
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
    if (dissType == viewDissTypeFadeOut) {
        PopupDismissType = KLCPopupDismissTypeFadeOut;
    }else if (dissType == viewDissTypeGrowOut){
        PopupDismissType = KLCPopupDismissTypeGrowOut;
    }else if (dissType == viewDissTypeShrinkOut){
        PopupDismissType = KLCPopupDismissTypeShrinkOut;
    }else if (dissType == viewDissTypeBounceOut){
        PopupDismissType = KLCPopupDismissTypeBounceOut;
    }else if (dissType == viewDissTypeSlideOutFromTop){
        PopupDismissType = KLCPopupDismissTypeSlideOutToTop;
    }else if (dissType == viewDissTypeSlideOutFromBottom){
        PopupDismissType = KLCPopupDismissTypeSlideOutToBottom;
    }else if (dissType == viewDissTypeBounceOutFromTop){
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
