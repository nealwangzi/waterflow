//
//  ViewController.m
//  瀑布流
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NYWaterFlowLayout.h"
#import "NYCollectionViewCell.h"
#import "NYShop.h"
#import <MJExtension.h>
#import <MJRefresh.h>

static NSString * const ID = @"cell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,NYWaterFlowLayoutDelegate>
/* 数据 */
@property(nonatomic , strong) NSMutableArray *shops;
/*  */
@property(nonatomic , weak) UICollectionView *collectionView;

@end

@implementation ViewController
- (NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [NSMutableArray array];
        }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *temp = [NYShop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:temp];

    NYWaterFlowLayout *layout = [[NYWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"NYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *temp = [NYShop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:temp];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    });
}
- (CGFloat)waterFlowLayout:(NYWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    NYShop *shop = self.shops[indexPath.item];
    return shop.h * width / shop.w;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}
@end
