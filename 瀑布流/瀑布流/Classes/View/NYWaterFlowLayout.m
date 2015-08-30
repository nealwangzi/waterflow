//
//  NYWaterFlowLayout.m
//  瀑布流
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYWaterFlowLayout.h"

@interface NYWaterFlowLayout ()
/* 字典记录每列最大Y值 */
@property(nonatomic , strong) NSMutableDictionary *maxYDict;
/* 存放数组 */
@property(nonatomic , strong) NSMutableArray *attrsArray;

@end
@implementation NYWaterFlowLayout
- (NSMutableDictionary *)maxYDict
{
    if (_maxYDict == nil) {
        _maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}
- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.ColumnMargin = 10;
        self.RowMargin = 10;
        self.ColumnsCount = 3;
    }
    return self;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (void)prepareLayout
{
    [super prepareLayout];
    
    for (int i = 0; i < self.ColumnsCount ; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0;  i < count;  i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
- (CGSize)collectionViewContentSize
{
    //字典遍历最大Y值
    __block NSString *maxColumn = @"0";
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if  ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue]);
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //字典遍历最小Y值
    __block NSString *minColumn = @"0";
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if  ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.ColumnsCount - 1)*self.ColumnMargin)/self.ColumnsCount;
    CGFloat height = [self.delegate waterFlowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    //计算位置
    CGFloat x = self.sectionInset.left + (width + self.ColumnMargin)*[minColumn floatValue];
    
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.RowMargin;
    
    self.maxYDict[minColumn] = @(y + height);
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;

}
@end
