//
//  MCVerificationCodeView.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/9.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCVerificationCodeView : UIView<UITextFieldDelegate>
@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);
@property (nonatomic , assign) BOOL  isSecret;
@end
