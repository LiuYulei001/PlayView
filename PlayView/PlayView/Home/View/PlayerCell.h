//
//  PlayerCell.h
//  PlayView
//
//  Created by Rainy on 2017/12/29.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLModel.h"

@class PlayerCell;

@protocol CLTableViewCellDelegate <NSObject>

- (void)cl_tableViewCellPlayVideoWithCell:(PlayerCell *)cell;

@end
@interface PlayerCell : UITableViewCell

@property (nonatomic, copy) CLModel *model;
@property (nonatomic, weak) id <CLTableViewCellDelegate> delegate;
@property(nonatomic,assign)BOOL stopPlay;

@end
