//
//  MCChainedEnums.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/12/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
/*label的文字位置**/
typedef NS_ENUM(NSInteger,QtextAlignment){
    Qleft = 0,
#if TARGET_OS_IPHONE && !0
    Qcenter    = 1,
    Qright     = 2,
#else
    Qright     = 1,
    Qcenter    = 2,
#endif
    
};
/*button的文字位置 枚举**/
typedef NS_ENUM(NSInteger,QTextPosition){
    Tnone   = 0,//
    Tright  = 1,// 文字文字在右
    Tleft   = 2,//文字在左
    Ttop    = 3,// 文字在上
    Tbottom = 4 // 文字在下
};
/*字体类型的枚举**/
typedef NS_ENUM(NSInteger,QFont){
    QR   = 0,//Regular
    QL  = 1,//Light
    QM   = 2,//Medium
    QB    = 3,//Bold
    QH = 4 // Heavy
};
