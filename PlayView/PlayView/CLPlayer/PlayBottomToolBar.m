//
//  PlayBottomToolBar.m
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

//间隙
#define Padding        10
//顶部底部工具条高度
#define ToolBarHeight     50

#import "PlayBottomToolBar.h"
#import "Masonry.h"

@implementation PlayBottomToolBar

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
    
    [self addSubview:self.playButton];
    [self addSubview:self.currentTimeLabel];
    [self addSubview:self.progress];
    [self addSubview:self.slider];
    [self addSubview:self.totalTimeLabel];
//    [self addSubview:self.fullButton];
    
    //播放按钮
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(Padding);
        make.bottom.mas_equalTo(-Padding);
        make.width.equalTo(self.playButton.mas_height);
    }];
    //当前播放时间
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(Padding);
        make.width.mas_equalTo(45);
        make.centerY.equalTo(self);
    }];
    //总时间
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-Padding);
        make.width.mas_equalTo(45);
        make.centerY.equalTo(self);
    }];
    //缓冲条
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(Padding);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-Padding);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self);
    }];
    //滑杆
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(Padding);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-Padding);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self);
    }];
//全屏按钮
//    [self.fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.mas_equalTo(-Padding);
//        make.top.mas_equalTo(Padding);
//        make.width.equalTo(self.fullButton.mas_height);
//    }];
}
//播放按钮
- (UIButton *) playButton{
    if (_playButton == nil){
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"CLPlayBtn"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"CLPauseBtn"] forState:UIControlStateSelected];
    }
    return _playButton;
}
//当前播放时间
- (UILabel *) currentTimeLabel{
    if (_currentTimeLabel == nil){
        _currentTimeLabel                           = [[UILabel alloc] init];
        _currentTimeLabel.textColor                 = [UIColor whiteColor];
        _currentTimeLabel.adjustsFontSizeToFitWidth = YES;
        _currentTimeLabel.text                      = @"00:00";
        _currentTimeLabel.textAlignment             = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
//总时间
- (UILabel *) totalTimeLabel{
    if (_totalTimeLabel == nil){
        _totalTimeLabel                           = [[UILabel alloc] init];
        _totalTimeLabel.textColor                 = [UIColor whiteColor];
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.text                      = @"00:00";
        _totalTimeLabel.textAlignment             = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
//缓冲条
- (UIProgressView *) progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc] init];
        _progress.trackTintColor = [UIColor colorWithRed:53 / 255.0 green:53 / 255.0 blue:65 / 255.0 alpha:1];
    }
    return _progress;
}
//滑动条
- (CLSlider *) slider{
    if (_slider == nil){
        _slider = [[CLSlider alloc] init];
        //右边颜色
        _slider.maximumTrackTintColor = [UIColor clearColor];
        _slider.enabled = NO;
    }
    return _slider;
}
//全屏按钮
//- (UIButton *) fullButton{
//    if (_fullButton == nil){
//        _fullButton = [[UIButton alloc] init];
//        [_fullButton setImage:[UIImage imageNamed:@"CLMaxBtn"] forState:UIControlStateNormal];
//        [_fullButton setImage:[UIImage imageNamed:@"CLMinBtn"] forState:UIControlStateSelected];
//    }
//    return _fullButton;
//}

@end
