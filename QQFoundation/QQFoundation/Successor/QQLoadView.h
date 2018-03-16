//
//  QQLoadView.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>
/*类型不够用的话 可自定义*/
typedef NS_ENUM(NSInteger,QQLoadViewType) {
    QQLoadViewNone = 0,///<消失
    QQLoadViewEmpty = 1,///<空数据界面
    QQLoadViewErrornetwork = 2,///<网络错误界面
};
/*点击图片时候调用的Block*/
typedef void(^ImageClick)();
@interface QQLoadView : UIScrollView
/*展示的类型*/
@property (nonatomic,assign) QQLoadViewType LoadType;
/*图片的名称*/
@property (nonatomic,copy) NSString *ImageName;
/*展示的文字*/
@property (nonatomic,copy) NSString *ShowString;

@property (nonatomic,copy) ImageClick ImageClick;
@end
