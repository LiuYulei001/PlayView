# PlayView
一个非常适用于列表的视频播放器


1.支持旋转

2.手势快进、音量调节、亮度调节等

3.播放进度、缓冲进度等

4.进度时间、总时间

... ...

简单用法：

CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 60, cell.CLwidth, cell.CLheight - 60)];

_playerView = playerView;

//重复播放，默认不播放

_playerView.repeatPlay = YES;

//当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器

_playerView.isLandscape = YES;

//设置等比例全屏拉伸，多余部分会被剪切

_playerView.fillMode = ResizeAspectFill;

//设置进度条背景颜色

_playerView.progressBackgroundColor = [UIColor colorWithRed:53 / 255.0 green:53 / 255.0 blue:65 / 255.0 alpha:1];

//设置进度条缓冲颜色

_playerView.progressBufferColor = [UIColor grayColor];

//设置进度条播放完成颜色

_playerView.progressPlayFinishColor = [UIColor whiteColor];

//全屏是否隐藏状态栏

_playerView.fullStatusBarHidden = NO;

//转子颜色

_playerView.strokeColor = [UIColor redColor];

//视频地址

_playerView.url = [NSURL URLWithString:cell.model.videoUrl];

//播放

[_playerView playVideo];

//返回按钮点击事件回调

[_playerView destroyPlay:^{
    
    NSLog(@"播放器被销毁了");
    
}];

[_playerView backButton:^(UIButton *button) {

    NSLog(@"返回按钮被点击");
    
}];

//播放完成回调

[_playerView endPlay:^{

    //销毁播放器
    
    [_playerView destroyPlayer];
    
    _playerView = nil;
    
    NSLog(@"播放完成");
    
}];
