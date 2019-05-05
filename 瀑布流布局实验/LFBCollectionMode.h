//
//  LFBCollectionMode.h
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LFBCollectionData;
@interface LFBCollectionMode : NSObject
@property (nonatomic, copy) NSMutableArray<LFBCollectionData *> *data;
@end

@interface LFBCollectionData : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isDouble;
@property (nonatomic, copy) NSArray<NSString *> *content;
@end

