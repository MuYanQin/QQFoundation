//
//  MCCollectionViewController.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "MCCollectionViewController.h"
#import "QQCollectionViewManager.h"
#import "MCTestCell.h"
#import "QQCollectionView.h"
#import "MCCollectionAddViewController.h"
@interface MCCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , strong) QQCollectionViewManager *manager;
@end

@implementation MCCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"collectionView管理";
    [self nav_RightItemWithStr:@"新建" Selector:@selector(addnv)];
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((KScreenWidth - 45)/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    QQCollectionView *collection =  [[QQCollectionView alloc]initWithFrame:CGRectMake(0, MCNavHeight, KScreenWidth, KScreenHeight - MCNavHeight) collectionViewLayout:layout];

    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    
    
    self.manager = [[QQCollectionViewManager alloc]initWithCollectionView:collection];
    self.manager[@"MCTestItem"] = @"MCTestCell";

    MCTestItem *one = [[MCTestItem alloc]init];
    one.selcetCellHandler = ^(id  _Nonnull item) {
        
    };

    MCTestItem *two = [[MCTestItem alloc]init];

    MCTestItem *three = [[MCTestItem alloc]init];

    [self.manager reloadCollectionViewWithItems:@[one,two,three]];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"23" forIndexPath:indexPath];
    return cell;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)addnv
{
    [self.navigationController pushViewController:[MCCollectionAddViewController new] animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
