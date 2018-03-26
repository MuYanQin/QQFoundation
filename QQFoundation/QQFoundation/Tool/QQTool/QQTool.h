////                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//        ======`-.____`-.___\_____/___.-`____.-*======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//          本宝宝曰:
//                  愿世间再无BUG，祝猿们早日出任CEO，
//                  赢取白富美，走上人生的巅峰！~~~
//        .............................................
//  QQTool.h
//  YYCacheTest
//
//  Created by tlt on 16/12/27.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QQTool : NSObject


/**
 判断字符串是否为空
 */
+ (BOOL)isBlank:(NSString *)string;

/**
 字符串的空、对象、等处理方式
 @param str 传入对象
 @return 字符串
 */
+ (NSString *)strRelay:(id)str;

/**
 转换成价格格式  保留俩位小数
 
 @param str 传入的对象
 @return 字符串
 */
+ (NSString *)strRelayPrice:(id)str;

/**
 是否为手机号
 
 @param mobile 字符串
 @return 布尔值
 */
+ (BOOL)isAvaluebleMobile:(NSString *)mobile;

/**
 是否是数字

 @param string 字符串
 @return 布尔值
 */
+ (BOOL)isNumbers:(NSString *)string;

/**
 运行时交换方法

 @param cls              哪个类
 @param originalSelector 系统方法
 @param swizzledSelector 要交换的方法
 */
void QQ_methodSwizzle(Class cls, SEL originalSelector, SEL swizzledSelector);


/**
 json格式字符串转字典
 
 @param jsonString 传入
 
 @return 返回
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 字典转字符串

 @param dic 传入的字典

 @return 返回的字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 系统级别的复制

 @param content 需要复制的内容
 */
+ (void)SystemPaste:(NSString *)content;

/*
 返回100k以内大小的图片
 */
+(NSData *)imageData:(UIImage *)myimage;


@end
