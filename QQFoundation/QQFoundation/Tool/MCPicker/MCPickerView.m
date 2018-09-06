//
//  MVPickerView.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCPickerView.h"
#import "MCPickerListView.h"
#import "MCPickerHeaderView.h"
#import "MCPickerModel.h"
static NSInteger const headerHeight = 30;//headerView的高度
static NSInteger const ScrollViewY = 70;//ScrollViewY Y坐标起始位
@interface MCPickerView ()<MCPickerListViewDelegate,MCPickerHeaderViewDelegate,MCPickerHeaderViewDelegate,UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView * ScrollView;
@property (nonatomic , strong) UILabel * TitleLb;
@property (nonatomic , strong) MCPickerHeaderView *header;
@property (nonatomic , strong) MCPickerListView * ListView;
@property (nonatomic , strong) MCPickerListView * ListView1;
@property (nonatomic , strong) MCPickerListView * ListView2;
@property (nonatomic , strong) MCPickerListView * ListView3;
@property (nonatomic , strong) NSMutableArray * headerDataArray;
@end
@implementation MCPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        self.headerDataArray = [NSMutableArray array];
        [self initForm];
    }
    return self;
}
- (void)initForm
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    UIView * BGView = [[UIView alloc]initWithFrame:self.bounds];
    BGView.backgroundColor = [UIColor blackColor];
    BGView.alpha = 0.5;
    [self addSubview:BGView];
    
    UIView *ContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 350, self.frame.size.width, 350)];
    ContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:ContentView];

    self.TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,self.frame.size.width , 15)];
    self.TitleLb.textColor = [UIColor grayColor];
    self.TitleLb.textAlignment = NSTextAlignmentCenter;
    self.TitleLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [ContentView addSubview:self.TitleLb];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 70, 0, 60, 40);
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(hiddenClick) forControlEvents:UIControlEventTouchUpInside];
    [ContentView addSubview:button];
    
    self.header = [[MCPickerHeaderView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, headerHeight)];
    self.header.backgroundColor = [UIColor whiteColor];
    self.header.dalegate = self;
    self.header.dataArray = @[@"请选择"];
    self.header.isLastRed = YES;
    [ContentView addSubview:self.header];
    
    [ContentView  addSubview:self.ScrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.header setindex:(int)(scrollView.contentOffset.x/self.frame.size.width)];
}
- (void)MCPickerHeaderView:(MCPickerHeaderView *)MCPickerHeaderView didSelcetIndex:(NSInteger)index
{
    [self.ScrollView setContentOffset:CGPointMake(self.frame.size.width*index,0) animated:YES];
}
- (void)MCPickerListView:(MCPickerListView *)MCPickerListView didSelcetedValue:(MCPickerModel *)Value
{
    self.headerDataArray  = [self.headerDataArray subarrayWithRange:NSMakeRange(0, MCPickerListView.tag)].mutableCopy;
    [self.headerDataArray addObject:Value.name];
    [self.headerDataArray addObject:@"请选择"];
    if (self.isLastArray) {
        [self hiddenClick];
    }
    if (self.isLastArray && [self.delegate respondsToSelector:@selector(MCPickerView:complete:)]) {
        [self.headerDataArray removeLastObject];
        [self.delegate MCPickerView:self complete:[self.headerDataArray componentsJoinedByString:@""]];
    }
    
    if (!self.isLastArray && [self.delegate respondsToSelector:@selector(MCPickerView:didSelcetedRow:value:)]) {
        [self.delegate MCPickerView:self didSelcetedRow:MCPickerListView.tag value:Value];
    }
    self.header.dataArray = self.headerDataArray;
}
- (UIScrollView *)ScrollView
{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,ScrollViewY, self.frame.size.width, self.frame.size.height  - ScrollViewY)];
        _ScrollView.pagingEnabled = YES;
        _ScrollView.delegate = self;
    }
    return _ScrollView;
}
- (MCPickerListView *)ListView
{
    if (!_ListView) {
        _ListView = [[MCPickerListView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height  - ScrollViewY)];
        _ListView.delegate = self;
        _ListView.tag = 0;
    }
    return _ListView;
}
- (MCPickerListView *)ListView1
{
    if (!_ListView1) {
        _ListView1 = [[MCPickerListView alloc]initWithFrame:CGRectMake(self.frame.size.width,0,self.frame.size.width, self.frame.size.height  - ScrollViewY)];
        _ListView1.delegate = self;
        _ListView1.tag = 1;
    }
    return _ListView1;
}
- (MCPickerListView *)ListView2
{
    if (!_ListView2) {
        _ListView2= [[MCPickerListView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0,self.frame.size.width, self.frame.size.height  - ScrollViewY)];
        _ListView2.delegate = self;
        _ListView2.tag = 2;

    }
    return _ListView2;
}
- (MCPickerListView *)ListView3
{
    if (!_ListView3) {
        _ListView3 = [[MCPickerListView alloc]initWithFrame:CGRectMake(self.frame.size.width *3,0,self.frame.size.width, self.frame.size.height  - ScrollViewY)];
        _ListView3.delegate = self;
        _ListView3.tag = 3;

    }
    return _ListView3;
}
- (void)setFirstArray:(NSArray *)firstArray
{
    _firstArray = firstArray;
    self.ListView.dataArray  =  firstArray;
    [self.ScrollView addSubview:self.ListView];
}
- (void)setSecondArray:(NSArray *)secondArray
{
    _secondArray = secondArray;
    
    self.ScrollView.contentSize = CGSizeMake(self.frame.size.width *2, 0);
    [self.ScrollView setContentOffset:CGPointMake(self.frame.size.width,0) animated:YES];
    self.ListView1.dataArray = secondArray;
    [self.ScrollView addSubview:self.ListView1];
}
- (void)setThirdArray:(NSArray *)thirdArray
{
    _thirdArray = thirdArray;
    self.ScrollView.contentSize = CGSizeMake(self.frame.size.width *3, 0);
    [self.ScrollView setContentOffset:CGPointMake(self.frame.size.width*2,0) animated:YES];
    self.ListView2.dataArray = thirdArray;
    [self.ScrollView addSubview:self.ListView2];
}
- (void)setFourthArray:(NSArray *)fourthArray
{
    _fourthArray = fourthArray;
    self.ScrollView.contentSize = CGSizeMake(self.frame.size.width *4, 0);
    [self.ScrollView setContentOffset:CGPointMake(self.frame.size.width*3,0) animated:YES];
    self.ListView3.dataArray = fourthArray;
    [self.ScrollView addSubview:self.ListView3];
}
- (void)setTitleText:(NSString *)titleText
{
    self.TitleLb.text = titleText;
}
- (void)hiddenClick
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
