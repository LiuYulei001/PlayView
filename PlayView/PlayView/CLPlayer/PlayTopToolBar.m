//
//  PlayTopToolBar.m
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

//间隙
#define Padding        10
//顶部底部工具条高度
#define ToolBarHeight     50

#import "PlayTopToolBar.h"
#import "Masonry.h"

@implementation PlayTopToolBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.userInteractionEnabled = YES;
        [self setUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backButton];
    //返回按钮
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(Padding);
        make.bottom.mas_equalTo(-Padding);
        make.width.equalTo(self.backButton.mas_height);
    }];
}
//返回按钮
- (UIButton *) backButton{
    if (_backButton == nil){
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"CLBackBtn"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"CLBackBtn"] forState:UIControlStateHighlighted];
    }
    return _backButton;
}
@end
