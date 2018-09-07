//
//  MVPickerView.h
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPickerView;
@class MCPickerModel;
@protocol MCPickerViewDelegate<NSObject>

/**
 点击回调的代理时间

 @param MCPickerView MCPickerView description
 @param Row 点击的第一个视图
 @param value 点击那一列的数据
 */
- (void)MCPickerView:(MCPickerView *)MCPickerView didSelcetedRow:(NSInteger)Row  value:(MCPickerModel *)value;

- (void)MCPickerView:(MCPickerView *)MCPickerView complete:(NSString *)complete;
@end
@interface MCPickerView : UIView
@property (nonatomic , weak) id<MCPickerViewDelegate>  delegate;
@property (nonatomic , assign) NSInteger  totalLevel;//总共有几层结束 必须设置
@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic , copy) NSString * titleText;
@end
