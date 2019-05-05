//
//  LFBHomeCollectionViewProtocol.h
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LFBHomeCollectionViewFlowLayout;
@protocol LFBHomeCollectionViewProtocol <NSObject>

@optional
/**
 获取item的size

 @param waterFlowLayout 布局flowLayout
 @param indexPath indexPath
 @return 返回item的size
 */
- (CGSize)waterFlowLayout:(LFBHomeCollectionViewFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 获取section对应header的size

 @param waterFlowLayout 布局flowLayout
 @param section section
 @return 返回section对应header的size
 */
- (CGSize)waterFlowLayout:(LFBHomeCollectionViewFlowLayout *)waterFlowLayout referenceSizeForHeaderInSection:(NSInteger)section;


/**
 获取section对应footer的size

 @param waterFlowLayout 布局flowLayout
 @param section secion
 @return 返回section对应footer的size
 */
- (CGSize)waterFlowLayout:(LFBHomeCollectionViewFlowLayout *)waterFlowLayout referenceSizeForFooterInSection:(NSInteger)section;

@end


