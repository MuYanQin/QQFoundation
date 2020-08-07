//
//  QQCollectionView.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QQCollectionView;
@protocol QQCollectionViewRequestDelegate <NSObject>
@optional
/**
 返回请求到的数据
 @param QQCollectionView 返回自己
 @param pullDown   返回bool 表明  YES－－下拉刷新  NO －－－ 上拉记载
 @param successData         返回的数据
 */
- (void)QQCollectionView:(QQCollectionView *)QQCollectionView isPullDown:(BOOL)pullDown successData:(id)successData;

/**
 返回网络错误的状态

 @param QQCollectionView self
 @param error 错误error
 */
@optional
- (void)QQCollectionView:(QQCollectionView *)QQCollectionView requestFailed:(NSError *)error;

@end

@interface QQCollectionView : UICollectionView<UIGestureRecognizerDelegate>

@property (assign,nonatomic) id<QQCollectionViewRequestDelegate> requestDelegate;


//配合MCHoveringView使用的属性/
//**获取tableView偏移量的Block*/
@property (nonatomic , copy) void(^scrollViewDidScroll)(UIScrollView * scrollView);

//配合MCHoveringView使用的属性/
/**是否同时响应多个手势 默认NO*/
@property (nonatomic , assign) BOOL  canResponseMutiGesture;

/*传递controller进来展示loadding状态只能是weak不会引用*/
@property (weak, nonatomic)UIViewController *tempController;

/**
 请求的网址
 */
@property (nonatomic , copy) NSString * requestUrl;

/**
 请求的参数
 */
@property (nonatomic , strong) NSMutableDictionary * requestParam;

- (void)netWorkStart:(NSString *)url param:(NSDictionary *)param vc:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
