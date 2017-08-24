//
//  UIImage+Manage.m
//  ManageAttributedString
//
//  Created by daisuke on 2016/7/18.
//  Copyright © 2016年 dse12345z. All rights reserved.
//

#import "UIImage+Manage.h"
#import <objc/runtime.h>

typedef NSMutableAttributedString * (^AttributedString)(id input);

@implementation UIImage (Manage)
@dynamic bounds;
@dynamic attributedString;

#pragma mark - instance attributes method

- (NSMutableAttributedString *(^)(CGRect bounds))bounds {
    __weak typeof(self) weakSelf = self;
    return ^NSMutableAttributedString *(CGRect bounds) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = weakSelf;
        textAttachment.bounds = bounds;
        NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:imageAttributedString];
        return mutableString;
    };
}

- (NSMutableAttributedString *(^)(void))attributedString {
    __weak typeof(self) weakSelf = self;
    return ^NSMutableAttributedString *(void) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = weakSelf;
        NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:imageAttributedString];
        return mutableString;
    };
}

@end
