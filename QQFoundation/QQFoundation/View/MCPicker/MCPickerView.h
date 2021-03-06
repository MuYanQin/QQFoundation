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
 点击Cell的回调  返回下一个视图需要的数据数组
 @param MCPickerView MCPickerView description
 @param tier 点击的第几层
 @param value 点击那一列的数据
 */
- (NSMutableArray<MCPickerModel *> *)MCPickerView:(MCPickerView *)MCPickerView didSelcetedTier:(NSInteger)tier  selcetedValue:(MCPickerModel *)value;


/**
 完成时候的回调

 @param MCPickerView MCPickerView description
 @param complete 完成时候返回拼接的字符串
 */
@required
- (void)MCPickerView:(MCPickerView *)MCPickerView completeArray:(NSMutableArray<NSString *> *)comArray completeStr:(NSString *)comStr ;

@end


@interface MCPickerView : UIView

@property (nonatomic , weak) id<MCPickerViewDelegate>  delegate;

/**
 选择窗的title
 */
@property (nonatomic , copy) NSString * titleText;

/**
 每一层的数据数组 用点击的代理给也是可以的
 */
@property (nonatomic , strong) NSArray<MCPickerModel *> *dataArray;

/**
 适用于有默认选择地址的时候。要一次性给全数据
 如：
 @param dataArray 数据源
 @param model 已有的model
 */
- (void)setData:(NSArray<MCPickerModel *> *)dataArray  selectModel:(MCPickerModel *)model;

@end
