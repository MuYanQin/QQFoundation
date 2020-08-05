//
//  QYSelectImageCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/5.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QQTableViewCell.h"
#import "CCTZImgPickerTool.h"

NS_ASSUME_NONNULL_BEGIN
@interface QYSelectImageItem : QQTableViewItem
@property (nonatomic , assign) NSInteger  maxImage;///<可选择图片的最大数目

@property (nonatomic , assign) BOOL  detail;///<是否是详情页 默认否

/**已选择的的图片 包含UIImage/NSString*/
@property (nonatomic , strong) NSMutableArray * selectedPhotos;

/**获取选择的图片 只包含UIImage对象*/
@property (nonatomic , strong, readonly) NSMutableArray * selectedimages;

/**获取defaultPhotos数组里面除了UIImage对象的其他数据*/
@property (nonatomic , strong, readonly) NSMutableArray * surplusURL;

/**默认显示的数组 UIImage/NSString*/
@property (nonatomic , strong) NSMutableArray * defaultPhotos;

/***selectedPhotos 发生变化就执行的Block*/
@property (nonatomic , copy) void(^selectImage)(QYSelectImageItem *ttitem,NSMutableArray * imageArray);
@end

@interface QYSelectImageCell : QQTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , strong) QYSelectImageItem * item;
@property (nonatomic , strong) CCTZImgPickerTool *imgPikerTool;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout * layout ;
@property (nonatomic , strong) UIView * line;

@end

@interface QYImageCell : UICollectionViewCell
@property (nonatomic , strong) QQButton * button;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , copy)  void(^deleteImage)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
