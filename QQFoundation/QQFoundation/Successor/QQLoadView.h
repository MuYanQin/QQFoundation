//
//  QQLoadView.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,QQLoadViewType) {
    QQLoadViewNone = 0,///<消失
    QQLoadViewEmpty = 1,///<空数据界面
    QQLoadViewErrornetwork = 2,///<网络错误界面
};
typedef void(^ImageClick)();
@interface QQLoadView : UIScrollView
@property (nonatomic,assign) QQLoadViewType LoadType;///<展示的类型
@property (nonatomic,copy) NSString *ImageName;//图片的名称
@property (nonatomic,copy) NSString *ShowString;//展示的文字
@property (nonatomic,copy) ImageClick ImageClick;
@end
