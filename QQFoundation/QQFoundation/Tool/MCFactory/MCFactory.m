//
//  MCFactory.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCFactory.h"
@implementation MCFactory
UIColor * getColor(CGFloat red,CGFloat gree, CGFloat blue)
{
    return [UIColor colorWithRed:red/255.f green:gree/255.f blue:blue/255.f alpha:1];
}

UIColor * getColorWithAlpha(CGFloat red,CGFloat gree, CGFloat blue,CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.f green:gree/255.f blue:blue/255.f alpha:alpha];
}

UIColor * getColorWithHex(NSString *hex)
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]||[cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    int r = (hexNum >> 16) & 0xFF;
    int g = (hexNum >> 8) & 0xFF;
    int b = (hexNum) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
UIImage * getColorImage(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



UIFont *getFontThin(NSInteger font)
{
    return [UIFont systemFontOfSize:font weight:UIFontWeightThin];
}

UIFont *getFontLight(NSInteger font)
{
    return [UIFont systemFontOfSize:font weight:UIFontWeightLight];
}

UIFont * getFontRegular(NSInteger font)
{
    return [UIFont systemFontOfSize:font weight:UIFontWeightRegular];
}
UIFont *getFontMedium(NSInteger font)
{
    return [UIFont systemFontOfSize:font weight:UIFontWeightMedium];

}
UIFont *getFontBold(NSInteger font)
{
    return [UIFont systemFontOfSize:font weight:UIFontWeightBold];
}


UIView * getView(UIColor *Bgcolor){
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = Bgcolor;
    return view;
}

QQTextField *getTextField(UIFont *font,UIColor *textColor,textAlignment alignment){
    QQTextField *textField = [[QQTextField alloc]init];
    textField.font = font;
    textField.textColor = textColor;
    textField.textAlignment = (int)alignment;
    return textField;
}

CALayer * getLayer(UIColor *bgcolor,UIImage *image){
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = bgcolor.CGColor;
    layer.contents = (id)image.CGImage;
    return layer;
}
CALayer * getLayerView(UIColor *bgcolor){
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = bgcolor.CGColor;
    return layer;
}

CALayer * getGradientLayer(UIView *view){
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)getColorWithHex(@"1CA3FB").CGColor,(__bridge id)getColorWithHex(@"64CBD7").CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
    
}

UILabel * getLabel(UIFont *font,NSString *text,UIColor *textColor,textAlignment alignment){
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.text = text;
    label.textAlignment =(int)alignment;
    label.textColor = textColor;
    return label;
}

@end
