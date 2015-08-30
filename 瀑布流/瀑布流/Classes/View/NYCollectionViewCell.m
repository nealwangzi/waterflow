//
//  NYCollectionViewCell.m
//  瀑布流
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYCollectionViewCell.h"
#import "NYShop.h"
#import <UIImageView+WebCache.h>
@interface NYCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation NYCollectionViewCell

- (void)awakeFromNib {
    
}
- (void)setShop:(NYShop *)shop
{
    _shop = shop;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = shop.price;
}
@end
