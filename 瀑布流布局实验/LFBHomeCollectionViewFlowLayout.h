//
//  LFBHomeCollectionViewFlowLayout.h
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFBHomeCollectionViewProtocol.h"

@interface LFBHomeCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat columnEdges;//每一列item之间的距离
@property (nonatomic, assign) CGFloat rowEdges;//每一行item之间的距离
@property (nonatomic, assign) NSInteger columnCount;//混排时表示一排放多个Item的情况下Item个数
@property (nonatomic, weak) id<LFBHomeCollectionViewProtocol> delegate;

@end


