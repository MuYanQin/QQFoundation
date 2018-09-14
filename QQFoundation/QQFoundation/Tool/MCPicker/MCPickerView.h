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
 点击Cell的回调
 @param MCPickerView MCPickerView description
 @param Tier 点击的第几层
 @param value 点击那一列的数据
 */
- (void)MCPickerView:(MCPickerView *)MCPickerView didSelcetedTier:(NSInteger)Tier  value:(MCPickerModel *)value;

/**
 完成时候的回调

 @param MCPickerView MCPickerView description
 @param complete 完成时候返回拼接的字符串
 */
@required
- (void)MCPickerView:(MCPickerView *)MCPickerView complete:(NSString *)complete;

@end


@interface MCPickerView : UIView

@property (nonatomic , weak) id<MCPickerViewDelegate>  delegate;

/**
 选择窗的title
 */
@property (nonatomic , copy) NSString * titleText;

/**
 总共有几层结束 必须设置
 */
@property (nonatomic , assign) NSInteger  totalTier;

/**
 每一层的数据数组
 */
@property (nonatomic , strong) NSArray * dataArray;


/**
 给每一层数据添加数据源 有默认选择的字符串   无默认选择的话推荐使用 setDataArray

 @param dataArray 数据源
 @param Text 默认选择的字符串
 */
- (void)setData:(NSArray *)dataArray  selectText:(NSString *)Text;
@end
