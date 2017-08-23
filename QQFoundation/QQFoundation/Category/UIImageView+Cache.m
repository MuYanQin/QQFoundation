//
//  UIImageView+Cache.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@implementation UIImageView (Cache)
- (void)setImageWith:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed];
}
- (void)setImageWith:(NSString *)url andPlaceHolderImg:(UIImage *)img
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:img options:SDWebImageRetryFailed];
}
//用处不是太多
- (void)setItemWith:(NSDictionary *)dic andPlaceHolderImg:(UIImage *)img
{
    //    UIImage *placeholder = [UIImage imageNamed:@"placeholderImage"];
    // 从内存\沙盒缓存中获得原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:dic[@"originalImage"]];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        //这里之所以没有直接将image给imageview是为了解决cell的复用问题
        [self sd_setImageWithURL:[NSURL URLWithString:dic[@"originalImage"]] placeholderImage:img];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:dic[@"originalImage"]] placeholderImage:img];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            //     用户的配置项假设利用NSUserDefaults存储到了沙盒中
            //    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
            //    [[NSUserDefaults standardUserDefaults] synchronize];
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            //这里自己写了设置才行 没设置就是下载缩略图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:dic[@"originalImage"]] placeholderImage:img];
            } else { // 下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbnailImage"]] placeholderImage:img];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:dic[@"thumbnailImage"]];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                [self sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbnailImage"]] placeholderImage:img];
            } else {
                [self sd_setImageWithURL:nil placeholderImage:img];
            }
        }
    }
}
@end
