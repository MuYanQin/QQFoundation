//
//  MCMonitorView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/10/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCMonitorView.h"
#import "MCWebViewViewController.h"
#import "QQTool.h"
#import "MCDetectionView.h"
@interface MCMonitorView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * dataArray;
@property (nonatomic , strong) MCDetectionView * detectionView;
@end
@implementation MCMonitorView
{
    CGPoint _touchPoint;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [NSMutableArray array];
        [self addSubview:self.detectionView];
        [self addSubview:self.tableView];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    NSDictionary *dic  = self.dataArray[indexPath.row];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *temp;
        if ([obj isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)obj;
            temp = [NSString stringWithFormat:@"%@--%@",@"链接失败",@(error.code)];
        }else{
            temp = @"链接成功";
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",key,temp];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic  = self.dataArray[indexPath.row];
    MCWebViewViewController *webView = [MCWebViewViewController new];
    UINavigationController *nav=  [[UINavigationController alloc]initWithRootViewController:webView];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSError class]]) {
            webView.contentHtml = [QQTool dictionaryToJson:obj];
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }];
    
}
- (MCDetectionView *)detectionView
{
    if (!_detectionView) {
        _detectionView = [[MCDetectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    }
    return _detectionView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.detectionView.frame.size.height, self.frame.size.width, self.frame.size.height  - self.detectionView.frame.size.height)];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = (int)self.frame.size.height/2;
    }
    return _tableView;
}
- (void)setDomains:(NSArray *)Domains
{
    self.detectionView.Domains = Domains;
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    if (self.dataArray.count > 2) {
        [self.dataArray removeObjectAtIndex:0];
    }
    [self.dataArray addObject:dataDic];
    [self.tableView reloadData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前移动过程中的按钮坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    
    //父试图的宽高
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat superViewHeight = self.superview.frame.size.height;
    CGFloat btnX = self.frame.origin.x;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    //x轴左右极限坐标
    if (btnX > superViewWidth){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - btnW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (btnX < 0){
        //按钮左侧越界
        CGFloat centerX = btnW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = 64;
    CGFloat judgeSuperViewHeight = superViewHeight - defaultNaviHeight;
    
    //y轴上下极限坐标
    if (btnY <= 0){
        //按钮顶部越界
        centerY = btnH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (btnY > judgeSuperViewHeight){
        //按钮底部越界
        CGFloat y = superViewHeight - btnH * 0.5;
        self.center = CGPointMake(btnX, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    CGFloat btnWidth = self.frame.size.width;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat btnY = self.frame.origin.y;
    
    //自动识别贴边
    if (self.center.x >= self.superview.frame.size.width/2) {
        
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠右自动吸边
            CGFloat btnX = self.superview.frame.size.width - btnWidth;
            self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠左吸边
            CGFloat btnX = 0;
            self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        }];
    }
}

@end
