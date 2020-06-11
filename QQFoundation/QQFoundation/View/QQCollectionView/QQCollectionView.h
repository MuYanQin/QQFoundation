//
//  QQCollectionView.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQCollectionView : UICollectionView<UIGestureRecognizerDelegate>

//配合MCHoveringView使用的属性/
//**获取tableView偏移量的Block*/
@property (nonatomic , copy) void(^scrollViewDidScroll)(UIScrollView * scrollView);

//配合MCHoveringView使用的属性/
/**是否同时响应多个手势 默认NO*/
@property (nonatomic , assign) BOOL  canResponseMutiGesture;

@property (nonatomic , copy) NSString * requestUrl;


@end

NS_ASSUME_NONNULL_END
