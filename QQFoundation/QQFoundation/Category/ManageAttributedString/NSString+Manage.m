//
//  NSString+Manage.m
//  ManageAttributedString
//
//  Created by daisuke on 2015/9/8.
//  Copyright (c) 2015年 dse12345z. All rights reserved.
//

#import "NSString+Manage.h"
#import <objc/runtime.h>

typedef NSMutableAttributedString * (^AttributedString)(id input);

@implementation NSString (Manage)
@dynamic append;

// 字型
@dynamic font;

// 顏色
@dynamic color, backgroundColor, strokeColor, underlineColor, strikethroughColor;

// 特效
@dynamic shadow, link, ligature, strokeWidth, textEffect, obliqueness, expansion, strikethroughStyle, underlineStyle;

// 排版
@dynamic kern, baselineOffset, writingDirection, verticalGlyph;

#pragma mark - instance method

- (NSMutableAttributedString * (^)(id addString))append {
    __weak typeof(self) weakSelf = self;
    
    return ^NSMutableAttributedString *(id input) {
        NSMutableAttributedString *multAttributeString = [[NSMutableAttributedString alloc] init];
        NSAttributedString *oldAttributeString = [[NSAttributedString alloc] initWithString:weakSelf];
        NSAttributedString *newAttributeString;
        if ([input isKindOfClass:[NSString class]]) {
            newAttributeString = [[NSAttributedString alloc] initWithString:input];
        }
        else if ([input isKindOfClass:[NSMutableAttributedString class]]) {
            newAttributeString = [[NSAttributedString alloc] initWithAttributedString:input];
        }
        else if ([input isKindOfClass:[UIImage class]]) {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = (UIImage *)input;
            newAttributeString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        }
        else {
            NSAssert(0, @"add(Obj) 檢查 Obj 是否是 NSString 或 NSMutableAttributedString 類別");
        }
        [multAttributeString appendAttributedString:oldAttributeString];
        [multAttributeString appendAttributedString:newAttributeString];
        return multAttributeString;
    };
}

#pragma mark - instance attributes method

- (NSMutableAttributedString *(^)(UIFont *font))font {
    return [self attributesType:NSFontAttributeName];
}

- (NSMutableAttributedString *(^)(UIColor *color))color {
    return [self attributesType:NSForegroundColorAttributeName];
}

- (NSMutableAttributedString *(^)(UIColor *backgroundColor))backgroundColor {
    return [self attributesType:NSBackgroundColorAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *ligature))ligature {
    return [self attributesType:NSLigatureAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *kern))kern {
    return [self attributesType:NSKernAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *strikethroughStyle))strikethroughStyle {
    return [self attributesType:NSStrikethroughStyleAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *underlineStyle))underlineStyle {
    return [self attributesType:NSUnderlineStyleAttributeName];
}

- (NSMutableAttributedString *(^)(UIColor *strokeColor))strokeColor {
    return [self attributesType:NSStrokeColorAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *strokeWidth))strokeWidth {
    return [self attributesType:NSStrokeWidthAttributeName];
}

- (NSMutableAttributedString *(^)(NSShadow *shadow))shadow {
    return [self attributesType:NSShadowAttributeName];
}

- (NSMutableAttributedString *(^)(NSString *textEffect))textEffect {
    return [self attributesType:NSTextEffectAttributeName];
}

- (NSMutableAttributedString *(^)(NSURL *link))link {
    return [self attributesType:NSLinkAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *baselineOffset))baselineOffset {
    return [self attributesType:NSBaselineOffsetAttributeName];
}

- (NSMutableAttributedString *(^)(UIColor *underlineColor))underlineColor {
    return [self attributesType:NSUnderlineColorAttributeName];
}

- (NSMutableAttributedString *(^)(UIColor *strikethroughColor))strikethroughColor {
    return [self attributesType:NSStrikethroughColorAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *obliqueness))obliqueness {
    return [self attributesType:NSObliquenessAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *expansion))expansion {
    return [self attributesType:NSExpansionAttributeName];
}

- (NSMutableAttributedString *(^)(NSArray *writingDirection))writingDirection {
    return [self attributesType:NSWritingDirectionAttributeName];
}

- (NSMutableAttributedString *(^)(NSNumber *verticalGlyph))verticalGlyph {
    return [self attributesType:NSVerticalGlyphFormAttributeName];
}

#pragma mark - private instance method

- (AttributedString)attributesType:(NSString *)attributesType {
    __weak typeof(self) weakSelf = self;
    
    return ^NSMutableAttributedString *(id input) {
        NSRange range = NSMakeRange(0, weakSelf.length);
        NSMutableAttributedString *multString = [[NSMutableAttributedString alloc] initWithString:weakSelf];
        [multString addAttribute:attributesType value:input range:range];
        return multString;
    };
}

@end
