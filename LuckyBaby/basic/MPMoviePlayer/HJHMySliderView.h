//
//  HJHMySliderView.h
//  VideoTest
//
//  Created by huang on 8/27/14.
//  Copyright (c) 2014 lkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sliderViewDelegate <NSObject>
//返回进度0~1,tag可以不用
-(void)currentJinDu:(CGFloat)jinDu tag:(NSInteger)tag;
-(void)drapJinDuBtnUpInsideWithTag:(NSInteger)tag;
@end

@interface HJHMySliderView : UIView<UIGestureRecognizerDelegate>{
    CGFloat sliderShowWidth;
    CGFloat sliderSwapWidth;
    CGFloat sliderCurrentSwapX;
    UIImageView *playingJinDuImageView;
    UIImageView *loadingJinDuImageView;
    UIButton *drapJinDuBtn;
    UIImageView *mainJinDuTiaoImageView;
}
//当拖动的时候会把canChangeFrame设置成NO，在调用setPlayingJinDuImageViewAndPlayBtnImageView的时候须把它重新设置成YES
@property(nonatomic,assign)BOOL canChangeFrame;
@property(nonatomic,weak)id<sliderViewDelegate> delegate;
//区别自己，类似button的tag
@property(nonatomic,assign)NSInteger tag;
//判定是否水平摆放,默认为是
@property(nonatomic,assign)BOOL isHorizontal;
//公开方法，接收目前缓冲进度
-(void)setLoadingImageView:(CGFloat)loadingJinDu;
//公开方法，设置目前播放进度
-(void)setPlayingJinDuImageViewAndPlayBtnImageView:(CGFloat)width;

//设置slider图片的一些方法
-(void)setLoadingImageViewImage:(UIImage*)image;
-(void)setPlayingImageViewImage:(UIImage*)image;
-(void)setBgImageViewImage:(UIImage*)image;
-(void)setDragBtnImageViewImage:(UIImage*)image;
@end
