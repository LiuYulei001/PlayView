//
//  YLTableViewVC.m
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "YLTableViewVC.h"

#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif

#import "CLPlayerView.h"
#import "CLModel.h"
#import "UIView+CLSetRect.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "PlayerCell.h"

static NSString *CLTableViewCellIdentifier = @"PlayerCell";

@interface YLTableViewVC () <UITableViewDelegate, UITableViewDataSource, CLTableViewCellDelegate, UIScrollViewDelegate>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *arrayDS;
/**CLplayer*/
@property (nonatomic, weak) CLPlayerView *playerView;
/**记录Cell*/
@property (nonatomic, assign) UITableViewCell *cell;

@end

@implementation YLTableViewVC
#pragma mark - 懒加载
/**数据源*/
- (NSMutableArray *) arrayDS{
    if (_arrayDS == nil){
        _arrayDS = [[NSMutableArray alloc] init];
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Date" ofType:@"json"]];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CLModel *model = [CLModel new];
            [model setValuesForKeysWithDictionary:obj];
            [_arrayDS addObject:model];
        }];
    }
    return _arrayDS;
}
/**tableView*/
- (UITableView *) tableView{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"PlayerCell" bundle:nil] forCellReuseIdentifier:CLTableViewCellIdentifier];
        
    }
    return _tableView;
}
#pragma mark - 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    self.navigationItem.title = @"ListPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view);
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDS.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CLTableViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
//在willDisplayCell里面处理数据能优化tableview的滑动流畅性，cell将要出现的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerCell * myCell = (PlayerCell *)cell;
    myCell.model = self.arrayDS[indexPath.row];
}
//cell离开tableView时调用
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        //区分是否是播放器所在cell,销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
}
#pragma mark - 点击播放代理
- (void)cl_tableViewCellPlayVideoWithCell:(PlayerCell *)cell{
    //记录被点击的Cell
    _cell = cell;
    //销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 60, cell.CLwidth, cell.CLheight - 60)];
    _playerView = playerView;
    [cell.contentView addSubview:_playerView];
    //    //重复播放，默认不播放
    //    _playerView.repeatPlay = YES;
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    //    _playerView.isLandscape = YES;
    //    //设置等比例全屏拉伸，多余部分会被剪切
    //    _playerView.fillMode = ResizeAspectFill;
    //设置进度条背景颜色
    _playerView.progressBackgroundColor = [UIColor colorWithRed:53 / 255.0 green:53 / 255.0 blue:65 / 255.0 alpha:1];
    //设置进度条缓冲颜色
    _playerView.progressBufferColor = [UIColor grayColor];
    //设置进度条播放完成颜色
    _playerView.progressPlayFinishColor = [UIColor whiteColor];
    //    //全屏是否隐藏状态栏
    //    _playerView.fullStatusBarHidden = NO;
    //    //转子颜色
    //    _playerView.strokeColor = [UIColor redColor];
    //视频地址
    _playerView.url = [NSURL URLWithString:cell.model.videoUrl];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView destroyPlay:^{
        cell.stopPlay = YES;
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
        _cell = nil;
        NSLog(@"播放完成");
    }];
}


//#pragma mark -- 需要页面支持其他方向，需要重写这三个方法，默认所有页面只支持竖屏
//// 是否支持自动转屏
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//// 支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;
//}
//// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}

@end
