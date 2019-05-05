//
//  LFBHomeCollectionReusableView.m
//  瀑布流布局实验
//
//  Created by liufubo on 2019/4/29.
//  Copyright © 2019 liufubo. All rights reserved.
//

#import "LFBHomeCollectionReusableView.h"

@interface  LFBHomeCollectionReusableView ()
@property (nonatomic, strong) UILabel *labelNameText;
@end

@implementation LFBHomeCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelNameText];
//        [self.labelNameText setBounds:self.bounds];
//        [self.labelNameText setCenter:self.center];
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)bindDataWithStr:(NSString *)str{
    [self.labelNameText setText:str];
}

#pragma mark - Getter & Setter
- (UILabel *)labelNameText{
    return _labelNameText?:({
        _labelNameText = [[UILabel alloc]init];
        _labelNameText.textColor = [UIColor blackColor];
        _labelNameText.font = [UIFont boldSystemFontOfSize:16];
        _labelNameText.textAlignment = NSTextAlignmentLeft;
        _labelNameText.frame = CGRectMake(15, 20, 100, 20);
        _labelNameText;
    });
}

@end
