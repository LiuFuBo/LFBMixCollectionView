//
//  LFBSingleCollectionCell.m
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/28.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import "LFBSingleCollectionCell.h"

@interface LFBSingleCollectionCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation LFBSingleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor orangeColor]];
        [self.contentView addSubview:self.label];
        [self.label setCenter:self.contentView.center];
    }
    return self;
}

- (void)bindDataWithStr:(NSString *)str{
    [self.label setText:str];
}

- (UILabel *)label{
    return _label?:({
        _label = [[UILabel alloc]init];
        _label.font = [UIFont boldSystemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor redColor];
        _label.bounds =CGRectMake(0, 0, 120, 20);
        _label;
    });
}

@end
