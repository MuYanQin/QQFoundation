//
//  MMCommentInputView.h
//  MomentKit
//
//  Created by LEA on 2019/3/25.
//  Copyright © 2019 LEA. All rights reserved.
//
//  朋友圈动态 > 输入评论
//

#import <UIKit/UIKit.h>

@interface MMCommentInputView : UIView

// 监听容器高度(包含监听键盘)
@property (nonatomic, copy) void (^MMContainerWillChangeFrameBlock)(CGFloat keyboardHeight);
// 评论文本
@property (nonatomic, copy) void (^MMCompleteInputTextBlock)(NSString *commentText);
// 容器高度
@property (nonatomic, assign) CGFloat ctTop;


// 显示
- (void)show;

@end
