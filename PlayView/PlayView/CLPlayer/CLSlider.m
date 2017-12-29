//
//  Slider.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/2.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import "CLSlider.h"

#define SLIDER_X_BOUND 80
#define SLIDER_Y_BOUND 40
#define SLIDER_H_BOUND 2
#define SLIDER_H_BLOCK 0.1

@interface CLSlider ()

@end

@implementation CLSlider

-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size

{
    
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    UIImage *thumbImage = [self OriginImage:[self getPictureWithName:@"CLRound"] scaleToSize:CGSizeMake(SLIDER_H_BLOCK, SLIDER_H_BLOCK)];
    
    [self setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
}
// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
- (CGRect)trackRectForBounds:(CGRect)bounds{
    [super trackRectForBounds:bounds];
    return CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds), SLIDER_H_BOUND);
}


#pragma mark - 获取资源图片
- (UIImage *)getPictureWithName:(NSString *)name{
    return [UIImage imageNamed:name];
}


@end
