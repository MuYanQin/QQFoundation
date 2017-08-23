//
//  UIButton+Cache.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "UIButton+Cache.h"

#import "UIButton+WebCache.h"
@implementation UIButton (Cache)

- (void)setButtonImgWithUrl:(NSString *)url forState:(UIControlState)state{
    [self sd_setImageWithURL:[NSURL URLWithString:url] forState:state placeholderImage:[UIImage imageNamed:@"1"]];
}

@end
