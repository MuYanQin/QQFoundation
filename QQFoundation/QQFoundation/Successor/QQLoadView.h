//
//  QQLoadView.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,QQLoadViewType) {
    QQLoadViewNone = 0,///<
    QQLoadViewEmpty = 1,///<空数据界面
    QQLoadViewErrornetwork = 2,///<网络错误界面
    QQLoadViewErrorServer = 3,///<服务器导致的出错

};
typedef void(^clickblock)();
@interface QQLoadView : UIScrollView
@property (nonatomic,assign) QQLoadViewType LoadViewType;///<展示的类型
@property (nonatomic,strong) NSString *alertSrtring;///<中间大一点的提示文字
@property (nonatomic,strong) NSString *DetailSrtring;///<下面小的文字
@property (nonatomic,strong) NSString *ImageSrtring;///<展示图片的名称
@property (nonatomic,copy) clickblock clickblock;///<图片的点击事件

@end
