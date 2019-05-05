//
//  LFBCollectionMode.m
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import "LFBCollectionMode.h"

@implementation LFBCollectionMode
- (NSMutableArray<LFBCollectionData *> *)data{
    return _data?:({
        _data = [NSMutableArray array];
        _data;
    });
}
@end

@implementation LFBCollectionData


@end
