//
//  readMe.m
//  瀑布流
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

瀑布流实现：
方法一：

三列 tableview ：每一列都是单独的，设置cell，不推荐，要注意禁止掉tableview的自己的滚动

方法二：自己写scrollview 创建 若干可重用的view ，之后把相应缓存池中的view 拿过来重用

方法三：Collectionview 写瀑布流

循环利用不需要做，缓存不要做，标示。算出对应的cell

