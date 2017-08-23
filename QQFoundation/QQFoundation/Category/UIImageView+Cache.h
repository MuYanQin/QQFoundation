//
//  UIImageView+Cache.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)
- (void)setImageWith:(NSString *)url;
- (void)setImageWith:(NSString *)url andPlaceHolderImg:(UIImage *)img;
- (void)setItemWith:(NSDictionary *)dic andPlaceHolderImg:(UIImage *)img;
@end
