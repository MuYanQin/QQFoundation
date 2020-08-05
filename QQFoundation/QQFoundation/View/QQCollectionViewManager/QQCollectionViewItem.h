//
//  QQCollectionViewItem.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQCollectionViewItem : NSObject
@property (nonatomic, copy  ) void(^selcetCellHandler)(id item);

@end

NS_ASSUME_NONNULL_END
