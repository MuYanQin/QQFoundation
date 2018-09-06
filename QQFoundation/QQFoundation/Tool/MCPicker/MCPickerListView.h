//
//  MCPickerListView.h
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPickerListView;
@class MCPickerModel;
@protocol MCPickerListViewDelegate<NSObject>
- (void)MCPickerListView:(MCPickerListView *)MCPickerListView didSelcetedValue:(MCPickerModel *)Value;
@end
@interface MCPickerListView : UIView
@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic , weak) id<MCPickerListViewDelegate>  delegate;
@end
