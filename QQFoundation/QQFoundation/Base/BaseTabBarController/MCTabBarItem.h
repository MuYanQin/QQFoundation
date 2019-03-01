//
//  MCTabBarItem.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/8.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTabBarItem : UIButton

/**默认图片*/
@property (nonatomic , strong) UIImage * defaultImg;
/**选中图片*/
@property (nonatomic , strong) UIImage * selectedImg;
/**下标文字*/
@property (nonatomic , copy) NSString * text;
/**controller*/
@property (nonatomic , strong) UIViewController  *vc;

/**文字与图片的距离*/
@property (nonatomic , assign) CGFloat  margin;
/**图片的大小*/
@property (nonatomic , assign) CGSize  imgSize;

/**是否是大的Item 中间凸起的*/
@property (nonatomic , assign) BOOL  isBigItem;
/**大Item的size 中间凸起的 isBigItem=YES生效*/
@property (nonatomic , assign) CGSize  bigItemSize;
/**大Item的向上的偏移量 为负数 中间凸起的 isBigItem=YES生效*/
@property (nonatomic , assign) CGFloat  offset;
/**设置角标  0 就是一个红点  小于0 消失   大于999  显示999+*/
@property (nonatomic,assign) NSInteger Badge;
/**角标的背景颜色。默认红色*/
@property (nonatomic,strong) UIColor *BadgeBackColor;
/**角标文字颜色。默认白色*/
@property (nonatomic,strong) UIColor *BadgeTextColor;

@end
