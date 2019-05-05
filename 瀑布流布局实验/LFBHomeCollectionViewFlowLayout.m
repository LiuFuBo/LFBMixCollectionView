//
//  LFBHomeCollectionViewFlowLayout.m
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import "LFBHomeCollectionViewFlowLayout.h"

@interface LFBHomeCollectionViewFlowLayout ()
@property (nonatomic, strong) NSMutableDictionary *maxYHash;
@property (nonatomic, strong) NSMutableArray *attributesArr;
@end

@implementation LFBHomeCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnEdges = 15;
        self.rowEdges = 15;
        self.columnCount = 2;//一行多个item情况的个数
        self.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15);
        self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 90);
    }
    return self;
}

#pragma mark - 每次布局前准备工作
- (void)prepareLayout{
    [super prepareLayout];
    [self.maxYHash removeAllObjects];
    for (int index=0; index<self.columnCount; index++) {
        self.maxYHash[@(index)] = @(0);
    }
    [self.attributesArr removeAllObjects];
    //重新计算每个item的布局
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int index=0; index< sectionCount; index++) {
        for (int num=0; num < [self.collectionView numberOfItemsInSection:index]; num++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:num inSection:index];
            //配置item之前配置section对应的header
            if (indexPath.row == 0) {
                UICollectionViewLayoutAttributes *attributeHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
                if (attributeHeader) {
                    [self.attributesArr addObject:attributeHeader];
                }
            }
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributesArr addObject:attribute];
            //配置完section对应的item布局后配置其footer
            if (indexPath.row == [self.collectionView numberOfItemsInSection:index] - 1) {
                UICollectionViewLayoutAttributes *attributeFooter = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
                if (attributeFooter) {
                 [self.attributesArr addObject:attributeFooter];
                }
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    //获取布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize itemSize = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForItemAtIndexPath:)]) {
        itemSize = [self.delegate waterFlowLayout:self sizeForItemAtIndexPath:indexPath];
    }
    //当item.width大于屏幕一半时，此时肯定一行只能放一个item
    if (itemSize.width > [UIScreen mainScreen].bounds.size.width/2) {
        //找出最长列,更新一行只有一个item的约束
        int maxColumn = 0;//假设第一列是最长的
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            if ([self.maxYHash[@(index)]  floatValue] > [self.maxYHash[@(maxColumn)] floatValue]) {
                maxColumn = index;
            }
        }
        //计算item的起点
        CGFloat x = self.sectionInset.left;
        CGFloat y = [self.maxYHash[@(maxColumn)] floatValue] + self.sectionInset.top;
        //再次更新瀑布流为所有的列长度为一致
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            self.maxYHash[@(index)] = @(y + itemSize.height);
        }
        //设置frame
        attrs.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        return attrs;
    }else{
         //找出最短列,更新一行多个item的约束
        int minColum = 0;//假设第一列是最短的
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            if ([self.maxYHash[@(index)] floatValue] < [self.maxYHash[@(minColum)] floatValue]) {
                minColum = index;
            }
        }
        //计算item的起点
        CGFloat x = self.sectionInset.left + (itemSize.width + self.columnEdges)*minColum;
        CGFloat y = [self.maxYHash[@(minColum)] floatValue] + self.rowEdges;
        //更新这一列的y值
        self.maxYHash[@(minColum)] = @(y + itemSize.height);
        //设置frame
        attrs.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        return attrs;
    }
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    //获取布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        //找出瀑布流最长一列，将header放到最长一列后面
        int maxColumn = 0;
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            if ([self.maxYHash[@(index)] floatValue] > [self.maxYHash[@(maxColumn)] floatValue]) {
                maxColumn = index;
            }
        }
        //计算item的起点
        CGFloat x = 0;
        CGFloat y = [self.maxYHash[@(maxColumn)] floatValue];
        
         //获取itemHeader的size
        CGSize itemSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(waterFlowLayout:referenceSizeForHeaderInSection:)]) {
           itemSize = [self.delegate waterFlowLayout:self referenceSizeForHeaderInSection:indexPath.section];
        }else{
            return nil;
        }
        
        //再次更新瀑布流为所有的列长度为一致
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            self.maxYHash[@(index)] = @(y + itemSize.height);
        }
        
        //设置frame
        attrs.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        return attrs;
    }else if([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        //找出瀑布流最长一列，将header放到最长一列后面
        int maxColumn = 0;
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            if ([self.maxYHash[@(index)] floatValue] > [self.maxYHash[@(maxColumn)] floatValue]) {
                maxColumn = index;
            }
        }
        //计算item的起点
        CGFloat x = 0;
        CGFloat y = [self.maxYHash[@(maxColumn)] floatValue];
        
        //获取itemFooter的size
        CGSize itemSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(waterFlowLayout:referenceSizeForFooterInSection:)]) {
            itemSize = [self.delegate waterFlowLayout:self referenceSizeForFooterInSection:indexPath.section];
        }else{
            return nil;
        }
        
        //再次更新瀑布流为所有的列长度为一致
        for (int index=0; index< self.maxYHash.allKeys.count; index++) {
            self.maxYHash[@(index)] = @(y + itemSize.height);
        }
        
        //设置frame
        attrs.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        return attrs;
    }
    return nil;
}

#pragma mark 返回所有布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return [self.attributesArr copy];
}

#pragma mark - 设置滚动区域
- (CGSize)collectionViewContentSize{
    int maxColumn = 0;
    for (int index=0; index< self.maxYHash.allKeys.count; index++) {
        if ([self.maxYHash[@(index)] floatValue] > [self.maxYHash[@(maxColumn)] floatValue]) {
            maxColumn = index;
        }
    }
    return CGSizeMake(0, [self.maxYHash[@(maxColumn)] floatValue] + self.sectionInset.bottom);
}

#pragma mark - Getter & Setter
- (NSMutableDictionary *)maxYHash{
    return _maxYHash?:({
        _maxYHash = [NSMutableDictionary dictionary];
        _maxYHash;
    });
}

- (NSMutableArray *)attributesArr{
    return _attributesArr?:({
        _attributesArr = [NSMutableArray array];
        _attributesArr;
    });
}

@end
