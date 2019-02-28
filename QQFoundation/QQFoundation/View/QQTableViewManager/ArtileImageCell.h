//
//  ArtileImageCell.h
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/16.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtileImageCell : UICollectionViewCell
@property (nonatomic , strong) QQButton * button;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , copy)  void(^deleteImage)(NSInteger tag);
@end
