//
//  CLPlayerMaskView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import "CLPlayerMaskView.h"
#import "CLSlider.h"
#import "Masonry.h"

//间隙
#define Padding        10
//顶部底部工具条高度
#define ToolBarHeight     50

@interface CLPlayerMaskView ()

@end

@implementation CLPlayerMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}
- (void)initViews{
    [self addSubview:self.PlayTopToolBar];
    [self addSubview:self.playBottomToolBar];
    [self addSubview:self.activity];
    [self addSubview:self.failButton];
}
#pragma mark - 约束
- (void)makeConstraints{
    //顶部工具条
    [self.PlayTopToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    //底部工具条
    [self.playBottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    //转子
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    //失败按钮
    [self.failButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}
#pragma mark -- 设置颜色
-(void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor{
    _progressBackgroundColor = progressBackgroundColor;
    self.progress.trackTintColor = progressBackgroundColor;
}
-(void)setProgressBufferColor:(UIColor *)progressBufferColor{
    _progressBufferColor        = progressBufferColor;
    self.progress.progressTintColor = progressBufferColor;
}
-(void)setProgressPlayFinishColor:(UIColor *)progressPlayFinishColor{
    _progressPlayFinishColor      = progressPlayFinishColor;
    self.slider.minimumTrackTintColor = _progressPlayFinishColor;
}
#pragma mark - 懒加载
//转子
- (AILoadingView *) activity{
    if (_activity == nil){
        _activity             = [[AILoadingView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.strokeColor = [UIColor whiteColor];
        [_activity starAnimation];
    }
    return _activity;
}
//返回按钮
- (UIButton *) backButton{
    return self.PlayTopToolBar.backButton;
}
//顶部工具栏
- (PlayTopToolBar *)PlayTopToolBar
{
    if (!_PlayTopToolBar) {
        _PlayTopToolBar = [[PlayTopToolBar alloc]init];
        [_PlayTopToolBar.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PlayTopToolBar;
}
//底部工具栏
- (PlayBottomToolBar *)playBottomToolBar
{
    if (!_playBottomToolBar) {
        
        _playBottomToolBar = [[PlayBottomToolBar alloc]init];
        _playBottomToolBar.slider.enabled = YES;
        [_playBottomToolBar.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_playBottomToolBar.fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_playBottomToolBar.slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_playBottomToolBar.slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_playBottomToolBar.slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _playBottomToolBar;
}
//播放按钮
- (UIButton *) playButton{
    return self.playBottomToolBar.playButton;
}
//全屏按钮
//- (UIButton *) fullButton{
//    return self.playBottomToolBar.fullButton;
//}
//当前播放时间
- (UILabel *) currentTimeLabel{
    return self.playBottomToolBar.currentTimeLabel;
}
//总时间
- (UILabel *) totalTimeLabel{
    return self.playBottomToolBar.totalTimeLabel;
}
//缓冲条
- (UIProgressView *) progress{
    return self.playBottomToolBar.progress;
}
//滑动条
- (CLSlider *) slider{
    return self.playBottomToolBar.slider;
}
//加载失败按钮
- (UIButton *) failButton
{
    if (_failButton == nil) {
        _failButton        = [[UIButton alloc] init];
        _failButton.hidden = YES;
        [_failButton setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failButton.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
        [_failButton addTarget:self action:@selector(failButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failButton;
}
#pragma mark - 按钮点击事件
//返回按钮
- (void)backButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(cl_backButtonAction:)]) {
        [_delegate cl_backButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//播放按钮
- (void)playButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(cl_playButtonAction:)]) {
        [_delegate cl_playButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//全屏按钮
//- (void)fullButtonAction:(UIButton *)button{
//    button.selected = !button.selected;
//    if (_delegate && [_delegate respondsToSelector:@selector(cl_fullButtonAction:)]) {
//        [_delegate cl_fullButtonAction:button];
//    }else{
//        NSLog(@"没有实现代理或者没有设置代理人");
//    }
//}
//失败按钮
- (void)failButtonAction:(UIButton *)button{
    self.failButton.hidden = YES;
    self.activity.hidden   = NO;
    [self.activity starAnimation];
    if (_delegate && [_delegate respondsToSelector:@selector(cl_failButtonAction:)]) {
        [_delegate cl_failButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
#pragma mark - 滑杆
//开始滑动
- (void)progressSliderTouchBegan:(CLSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(cl_progressSliderTouchBegan:)]) {
        [_delegate cl_progressSliderTouchBegan:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动中
- (void)progressSliderValueChanged:(CLSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(cl_progressSliderValueChanged:)]) {
        [_delegate cl_progressSliderValueChanged:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动结束
- (void)progressSliderTouchEnded:(CLSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(cl_progressSliderTouchEnded:)]) {
        [_delegate cl_progressSliderTouchEnded:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    [self makeConstraints];
}
#pragma mark - 获取资源图片
- (UIImage *)getPictureWithName:(NSString *)name{
    return [UIImage imageNamed:name];
}

@end
