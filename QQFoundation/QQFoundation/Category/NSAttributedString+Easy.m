//
//  NSAttributedString+Easy.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "NSAttributedString+Easy.h"
#import "MyAttributedStringBuilder.h"
@implementation NSAttributedString (Easy)
+ (NSAttributedString *)SetTextLineOnMindleWith:(NSString *)string
{
    //    MyAttributedStringBuilder *builder = nil;
    //    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    //    [builder includeString:string all:NO].strikethroughStyle = 1;
    //    [builder includeString:string all:NO].strikethroughColor = [UIColor lightGrayColor];
    //
    //    return builder.commit;
    NSUInteger length = [string length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    return attri;
    
}

+ (NSAttributedString *)SetunderlineOneString:(NSString *)string
{
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    [builder includeString:string all:NO].underlineStyle = NSUnderlineStyleSingle;
    [builder includeString:string all:NO].underlineColor = [UIColor redColor];
    return builder.commit;
}

+ (NSAttributedString *)SetTextColor:(UIColor *)TextColor  BackgroundColor:(UIColor *)color  andWithString:(NSString *)string
{
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    builder.allRange.backgroundColor = color;
    builder.allRange.textColor = TextColor;
    return builder.commit;
}

+ (NSAttributedString*)SetNumberColor:(UIColor *)NumberColor NumberFont:(CGFloat)Font andWithString:(NSString *)string
{
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    [builder characterSet:[NSCharacterSet  decimalDigitCharacterSet]].font=[UIFont systemFontOfSize:Font];
    [builder characterSet:[NSCharacterSet  decimalDigitCharacterSet]].textColor =NumberColor;
    return builder.commit;
}
+ (NSAttributedString *)SetTextcolor:(UIColor *)color text:(NSString *)str  andWithString:(NSString *)string;
{
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    builder = [[MyAttributedStringBuilder alloc] initWithString:string];
    [builder includeString:str all:YES].textColor = color;
    return builder.commit;
}
+ (NSAttributedString *)setimage:(UIImage *)image  Bounds:(CGRect)boubds andstring:(NSString *)string
{
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:string];
    
    // 修改富文本中的不同文字的样式
    //    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];
    //    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    
    // 设置数字为红色
    //    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 9)];
    //    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(5, 9)];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds =boubds;
    
    // 创建带有图片的富文本
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attch];
    //    [attri appendAttributedString:str];
    [attri insertAttributedString:str atIndex:0];
    // 用label的attributedText属性来使用富文本
    //    self.AddressLabel.attributedText = attri;
    return attri;
}

+(NSAttributedString *)setImage:(UIImage *)image Bounds:(CGRect)bounds andString:(NSString *)string
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds =bounds;
    
    // 创建带有图片的富文本
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri insertAttributedString:str atIndex:string.length];
    
    return attri;
}

@end
