//
//  QYArticleTextCell.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QYArticleTextCell.h"
@implementation QYArticleTextItem

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
@end
@implementation QYArticleTextCell
@synthesize item = _item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.accessorV = [[QYArticleAccessoryView alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    QQWeakSelf
    self.accessorV.clickIndex = ^(NSInteger index) {
        if (weakSelf.item.selectImgBlock && index ==1) {
            weakSelf.item.selectImgBlock();
        }else if (weakSelf.item.addTextItemBlock && index ==0){
            weakSelf.item.addTextItemBlock();
        }
    };
    self.textView = [[QQTextView alloc]init];
    self.textView.inputAccessoryView = self.accessorV;
    self.textView.font = getFontRegular(14);
    [self.textView scrollRangeToVisible:self.textView.selectedRange];
    self.textView.delegate = self;
    self.textView.placeholder = @"请输入文字";
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);

        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.item.text = textView.text;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height + 20 >60) {
        self.item.cellHeight = size.height + 20;
        QYEmptyItem *em =  self.item.section.items[0];
        [em reloadRowWithAnimation:(UITableViewRowAnimationNone)];
    }
    
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.textView.text = self.item.text;
}

@end
