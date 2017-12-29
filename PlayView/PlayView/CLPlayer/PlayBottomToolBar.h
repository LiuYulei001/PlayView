//
//  PlayBottomToolBar.h
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSlider.h"

@interface PlayBottomToolBar : UIView

/**底部工具条播放按钮*/
@property (nonatomic,strong) UIButton *playButton;
/**底部工具条当前播放时间*/
@property (nonatomic,strong) UILabel *currentTimeLabel;
/**底部工具条视频总时间*/
@property (nonatomic,strong) UILabel *totalTimeLabel;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView *progress;
/**播放进度条*/
@property (nonatomic,strong) CLSlider *slider;
/**底部工具条全屏按钮*/
//@property (nonatomic,strong) UIButton *fullButton;

@end
