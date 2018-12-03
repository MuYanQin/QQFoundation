//
//  UILabel+MCChained.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UILabel+MCChained.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

static char const actionChar;
static char const ClickChar;
static char const touchSelChar;
static char const touchTargetChar;

typedef UILabel * (^Label)(id input);
@interface UILabel()
@property (nonatomic , assign) NSString  *touchSelString;
@property (nonatomic , weak) id  touchTarget;

@end;
@implementation UILabel (MCChained)
@dynamic Qtext,QtextColor,Qfont;
- (NSArray *)actionArray
{
    return objc_getAssociatedObject(self,  &actionChar);
}
- (void)setActionArray:(NSArray *)actionArray
{
    objc_setAssociatedObject(self, &actionChar, actionArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setTapClick:(void (^)(NSString *, NSRange, NSInteger))tapClick
{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, &ClickChar, tapClick, OBJC_ASSOCIATION_COPY);
}
- (void (^)(NSString *, NSRange, NSInteger))tapClick
{
    return objc_getAssociatedObject(self,  &ClickChar);
}
- (void)setTouchSelString:(NSString *)touchSelString
{
    objc_setAssociatedObject(self, &touchSelChar, touchSelString, OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)touchSelString
{
    return objc_getAssociatedObject(self,  &touchSelChar);
}
- (void)setTouchTarget:(id)touchTarget
{
    objc_setAssociatedObject(self, &touchTargetChar,touchTarget , OBJC_ASSOCIATION_ASSIGN);

}
- (id)touchTarget
{
    return objc_getAssociatedObject(self,  &touchTargetChar);
}
-(UILabel *(^)(id, NSString *))Qclick
{
    return ^UILabel *(id target,NSString * event){
        self.touchSelString = event;
        self.touchTarget = target;
        self.userInteractionEnabled = YES;
        return self;
    };
}
+ (UILabel *)getLabel
{
    return [[self alloc]init];
}
- (UILabel *(^)(UIColor *))QtextColor
{
    return ^UILabel *(id input){
        self.textColor = input;
        return self;
    };
}
- (UILabel *(^)(UIFont *font))Qfont
{
    return ^UILabel *(id input){
        self.font = input;
        return self;
    };
}
- (UILabel *(^)(NSString *))Qtext
{
    return ^UILabel *(id input){
        self.text = input;
        return self;
    };
}
- (UILabel *(^)(CGRect frame))Qframe
{
    return ^UILabel *(CGRect input){
        self.frame = input;
        return self;
    };
}
- (UILabel *(^)(NSMutableAttributedString *QattributedText))QattributedText
{
    return ^UILabel *(id input){
        self.attributedText = input;
        return self;
    };
}
- (UILabel *(^)(NSInteger QnumberOfLines))QnumberOfLines
{
    return ^UILabel *(NSInteger input){
        self.numberOfLines = input;
        return self;
    };
}
- (UILabel *(^)(NSInteger))Qtag
{
    return ^UILabel *(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (UILabel *(^)(QtextAlignment))Qalignment
{
    return ^UILabel *(QtextAlignment Alignment){
        self.textAlignment  = (int)Alignment;
        return self;
    };
}
-(UILabel *(^)(BOOL))Qhidden
{
    return ^UILabel *(BOOL hidden){
        self.hidden  = hidden;
        return self;
    };
}
#pragma mark - touchAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.touchSelString && self.touchTarget) {
        [self.touchTarget performSelector:NSSelectorFromString(self.touchSelString) withObject:nil afterDelay:0];
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak typeof(self) weakSelf = self;
    [self yb_getTapFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        
        if (weakSelf.tapClick) {
            weakSelf.tapClick (string , range , index);
        }
    }];
}
#pragma mark - getTapFrame
- (BOOL)yb_getTapFrameWithTouchPoint:(CGPoint)point result:(void (^) (NSString *string , NSRange range , NSInteger index))resultBlock
{
    //获取 CTFram 的工厂类 framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    //设置coretext 绘制的路径
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    //获取text的frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (self.attributedText.length > range.length) {
        UIFont *font ;
        if ([self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            font = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
        }else if (self.font){
            font = self.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        CGPathRelease(Path);
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        return NO;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = [self yb_transformForCoreText];
    
    CGFloat verticalOffset = 0;
    //有多少行
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGRect flippedRect = [self yb_getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        //AttributeString的style
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        CGFloat lineSpace;
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        //是否存在 rect
        if (CGRectContainsPoint(rect, point)) {
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            //            CGFloat offset;
            //            CTLineGetOffsetForStringIndex(line, index, &offset);
            //            if (offset > relativePoint.x) {
            index = index - 1;
            //            }
            //哪一些是高亮
            NSInteger link_count = self.actionArray.count;
            for (int j = 0; j < link_count; j++) {
                NSString *text = self.actionArray[j];
                NSString *totalStr = self.attributedText.string;
                NSRange link_range = [totalStr rangeOfString:text];
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (text , link_range , (NSInteger)j);
                    }
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    return YES;
                }
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    return NO;
}
- (CGAffineTransform)yb_transformForCoreText
{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}
- (CGRect)yb_getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}

@end
