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
//
//  QQFileManage.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/18.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFileManage : NSObject
/**
 获取App文件的目录
 
 @return 返回app的位置
 */
+ (NSString *)GetAppHomePath;

/**
 获取Document的路径
 
 @return 路径的字符串
 */
+ (NSString *)GetDocumentsPath;


/**
 获取Caches文件的目录
 
 @return Caches
 */
+ (NSString *)GetCachesPath;

/**
 获取路径下面所有文件的（包括文件夹）的url

 @param path 路径
 @return 内容
 */
+ (NSArray *)GetContentUrlWith:(NSString *)path;

/**
 是否存在文件
 @param path 路径
 @return 结果
 */
+ (BOOL)isContainAtPath:(NSString *)path;
/**
 创建文件夹
 
 @param path   文件路径
 @param name   文件夹的名称
 @param result 返回的结果
 */
+ (void)CreateFolderWithPath:(NSString *)path FolderName:(NSString *)name  Success:(void(^)(NSString * Path,NSError *error))result;
@end
