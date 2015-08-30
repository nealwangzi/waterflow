//
//  NYWaterFlowLayout.h
//  瀑布流
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYWaterFlowLayout;
@protocol NYWaterFlowLayoutDelegate <NSObject>

- (CGFloat)waterFlowLayout:(NYWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath :(NSIndexPath *)indexPath;
@end
@interface NYWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign)UIEdgeInsets sectionInset;
//每列间距
@property (nonatomic, assign)CGFloat ColumnMargin ;
//每行间距
@property (nonatomic, assign)CGFloat RowMargin ;
/* 列数 */
@property(nonatomic , assign)NSInteger ColumnsCount;

/* delegate */
@property(nonatomic , weak) id<NYWaterFlowLayoutDelegate> delegate;

@end
