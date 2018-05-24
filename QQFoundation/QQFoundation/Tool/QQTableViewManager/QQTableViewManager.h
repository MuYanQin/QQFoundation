//
//  QQTableViewManager.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RETableViewManagerDelegate <UITableViewDelegate>

@end

@interface QQTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;


- (id)initWithTableView:(UITableView *)tableView ;

- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray;
@end
