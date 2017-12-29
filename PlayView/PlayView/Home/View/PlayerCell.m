
//
//  PlayerCell.m
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "PlayerCell.h"
#import "UIImageView+WebCache.h"
#import "PlayBottomToolBar.h"

@interface PlayerCell ()

@property (weak, nonatomic) IBOutlet PlayBottomToolBar *toolBar;
@property (weak, nonatomic) IBOutlet UIImageView *IMGView;

@end

@implementation PlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)playAction:(UIButton *)sender {
    
    self.toolBar.alpha = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(cl_tableViewCellPlayVideoWithCell:)]){
        [_delegate cl_tableViewCellPlayVideoWithCell:self];
    }
}
-(void)setModel:(CLModel *)model{
    _model = model;
    __block UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    [[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:_model.pictureUrl] completion:^(BOOL isInCache) {
        if (isInCache) {
            //本地存在图片,替换占位图片
            placeholderImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.pictureUrl];
        }
        //主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.IMGView sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:placeholderImage];
        });
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.toolBar.playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setStopPlay:(BOOL)stopPlay
{
    _stopPlay = stopPlay;
    self.toolBar.alpha = 1;
}
@end
