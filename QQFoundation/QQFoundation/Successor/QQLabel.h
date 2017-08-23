//
//  QQLabel.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQLabel : UILabel
{
    SEL _action;
    id _target;
}
- (void)addtarget:(id)target action:(SEL)action;
@end
