//
//  ViewController.m
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import "ViewController.h"
#import "LFBCollectionMode.h"
#import "LFBDoubleCollectionCell.h"
#import "LFBSingleCollectionCell.h"
#import "LFBHomeCollectionReusableView.h"
#import "LFBHomeCollectionViewFlowLayout.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height
static NSString *const YXYTDoubleCollectionCellIdentifier = @"YXYTDoubleCollectionCellIdentifier";
static NSString *const YXYTSingleCollectionCellIdentifier = @"YXYTSingleCollectionCellIdentifier";
static NSString *const YXYTHomeCollectionReusableViewHeaderIdentifier = @"YXYTHomeCollectionReusableViewHeaderIdentifier";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LFBHomeCollectionViewProtocol>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LFBCollectionMode *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.model.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    LFBCollectionData *data = [self.model.data objectAtIndex:section];
    return data.content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LFBCollectionData *data = [self.model.data objectAtIndex:indexPath.section];
    if (data.isDouble) {
        LFBDoubleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YXYTDoubleCollectionCellIdentifier forIndexPath:indexPath];
        [cell bindDataWithStr:[data.content objectAtIndex:indexPath.row]];
        return cell;
    }else{
        LFBSingleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YXYTSingleCollectionCellIdentifier forIndexPath:indexPath];
        [cell bindDataWithStr:[data.content objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LFBCollectionData *data = [self.model.data objectAtIndex:indexPath.section];
        LFBHomeCollectionReusableView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:YXYTHomeCollectionReusableViewHeaderIdentifier forIndexPath:indexPath];
        [headReusableView bindDataWithStr:data.title];
        return headReusableView;
    }
    return nil;
}

#pragma mark - YXYTHomeCollectionViewProtocol
- (CGSize)waterFlowLayout:(LFBHomeCollectionViewFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   LFBCollectionData *data = [self.model.data objectAtIndex:indexPath.section];
    if (data.isDouble) {
        CGFloat itemWidth = (KScreenWidth - 45)/2, itemHeight = 135;
        return CGSizeMake(itemWidth, itemHeight);
    }
    return CGSizeMake(KScreenWidth - 30, 120);
}

- (CGSize)waterFlowLayout:(LFBHomeCollectionViewFlowLayout *)waterFlowLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenWidth, 53);
}

#pragma mark - Getter & Setter
- (UICollectionView *)collectionView{
    return _collectionView?:({
        LFBHomeCollectionViewFlowLayout *flowLayout = [[LFBHomeCollectionViewFlowLayout alloc]init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        [_collectionView registerClass:[LFBDoubleCollectionCell class] forCellWithReuseIdentifier:YXYTDoubleCollectionCellIdentifier];
        [_collectionView registerClass:[LFBSingleCollectionCell class] forCellWithReuseIdentifier:YXYTSingleCollectionCellIdentifier];
        [_collectionView registerClass:[LFBHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:YXYTHomeCollectionReusableViewHeaderIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        _collectionView;
    });
}




- (LFBCollectionMode *)model{
    return _model?:({
        _model = [[LFBCollectionMode alloc]init];
        {
            LFBCollectionData *data = [[LFBCollectionData alloc]init];
            data.isDouble = YES;
            data.title = @"特惠套餐";
            data.content = @[@"洗车",@"养护",@"喷漆"];
            [_model.data addObject:data];
        }
        {
            LFBCollectionData *data = [[LFBCollectionData alloc]init];
            data.isDouble = YES;
            data.title = @"汽车服务";
            data.content = @[@"张三",@"李四",@"王麻子"];
            [_model.data addObject:data];
        }
        {
            LFBCollectionData *data = [[LFBCollectionData alloc]init];
            data.isDouble = NO;
            data.title = @"特选商品";
            data.content = @[@"木耳",@"牛奶"];
            [_model.data addObject:data];
        }
        {
            LFBCollectionData *data = [[LFBCollectionData alloc]init];
            data.isDouble = YES;
            data.title = @"共享汽车";
            data.content = @[@"桑塔纳",@"捷达",@"宝马"];
            [_model.data addObject:data];
        }
        _model;
    });
}

@end
