//
//  HJHMySliderView.m
//  VideoTest
//
//  Created by huang on 8/27/14.
//  Copyright (c) 2014 lkk. All rights reserved.
//
#define dragBtnWidth self.frame.size.height
#define dragBtnJianXi self.frame.size.height/8
#define dragBtnY 0 - 0.5
#import "HJHMySliderView.h"

@implementation HJHMySliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.canChangeFrame = YES;
        self.isHorizontal = YES;
        [self setSliderView:frame];
        self.clipsToBounds = YES;
        sliderShowWidth = self.frame.size.width - 70 - dragBtnWidth;
        sliderSwapWidth = self.frame.size.width - dragBtnJianXi - 12 - 20 - dragBtnWidth - dragBtnJianXi - dragBtnWidth/2;
        // Initialization code
    }
    return self;
}


-(void)setSliderView:(CGRect)frame{
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    bgImageView.clipsToBounds = YES;
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.userInteractionEnabled = YES;
    [self addSubview:bgImageView];
    
    mainJinDuTiaoImageView = [[UIImageView alloc]init];
    mainJinDuTiaoImageView.frame = CGRectMake(6+dragBtnWidth/2, self.frame.size.height/30*14, self.frame.size.width - 70 - dragBtnWidth, self.frame.size.height/30);
    mainJinDuTiaoImageView.image = [UIImage imageNamed:@"scrubsilider_off.png"];
    mainJinDuTiaoImageView.backgroundColor = [UIColor clearColor];
    [bgImageView addSubview:mainJinDuTiaoImageView];
    
    loadingJinDuImageView = [[UIImageView alloc]init];
    loadingJinDuImageView.frame = CGRectMake(6+dragBtnWidth/2, self.frame.size.height/30*14, 0, self.frame.size.height/30);
    [loadingJinDuImageView setImage:[UIImage imageNamed:@"Buffer.png"]];
    loadingJinDuImageView.backgroundColor = [UIColor clearColor];
    [bgImageView addSubview:loadingJinDuImageView];
    
    playingJinDuImageView = [[UIImageView alloc]init];
    playingJinDuImageView.frame = CGRectMake(6+dragBtnWidth/2, self.frame.size.height/30*14, 0, self.frame.size.height/30);
    playingJinDuImageView.image = [UIImage imageNamed:@"scrubsilider_on.png"];
    //playingJinDuImageView.backgroundColor = [UIColor blackColor];
    [bgImageView addSubview:playingJinDuImageView];
    
    drapJinDuBtn = [[UIButton alloc]init];
    drapJinDuBtn.frame = CGRectMake(6, dragBtnY, dragBtnWidth, dragBtnWidth);
    drapJinDuBtn.backgroundColor = [UIColor clearColor];
    [drapJinDuBtn setImage:[UIImage imageNamed:@"scrubslider_btn.png"] forState:UIControlStateNormal];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [drapJinDuBtn addGestureRecognizer:pan];
    [bgImageView addSubview:drapJinDuBtn];
}

#pragma mark -pinGetureMethod
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self];
            //NSLog(@"(%f\n%f)",recognizer.view.center.x,translation.x);
            //12和20都是缓冲区
            
            //加一个锁防止被同时调用
            self.canChangeFrame = NO;
            //水平摆放的拖动方法
            if (self.isHorizontal) {
                if ((translation.x + recognizer.view.center.x > dragBtnJianXi + dragBtnWidth/2 && translation.x + recognizer.view.center.x<self.frame.size.width - dragBtnJianXi - 12 - 20 - dragBtnWidth)) {
                    //NSLog(@"======%f\n%f======",recognizer.view.center.x,translation.x);
                    if (recognizer.view.center.x <= self.frame.size.width - dragBtnJianXi - 12 - dragBtnWidth && recognizer.view.center.x >= dragBtnJianXi + dragBtnWidth/2) {
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }else if(recognizer.view.center.x > self.frame.size.width - dragBtnJianXi - 12 - dragBtnWidth  && translation.x <= 0){
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }else if(recognizer.view.center.x < dragBtnJianXi + dragBtnWidth/2  && translation.x >= 0){
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }
                }else if(translation.x + recognizer.view.center.x < dragBtnJianXi + dragBtnWidth/2){
                    recognizer.view.center = CGPointMake(dragBtnJianXi + dragBtnWidth/2,
                                                         recognizer.view.center.y);
                    [recognizer setTranslation:CGPointZero inView:self];
                }else if(translation.x + recognizer.view.center.x>self.frame.size.width - dragBtnJianXi - 12 - 20 - dragBtnWidth){
                    recognizer.view.center = CGPointMake(self.frame.size.width - dragBtnJianXi - 12 - 20 - dragBtnWidth,
                                                         recognizer.view.center.y);
                    [recognizer setTranslation:CGPointZero inView:self];
                }
                sliderCurrentSwapX = recognizer.view.center.x;
                //NSLog(@"%f,%f",sliderSwapWidth,sliderCurrentSwapX);
                
                //改变本地得进度条
                CGRect r = playingJinDuImageView.frame;
                r.size.width = (sliderCurrentSwapX - dragBtnJianXi - dragBtnWidth/2)/sliderSwapWidth *sliderShowWidth;
                playingJinDuImageView.frame = r;
                //NSLog(@"+++++++%f",playingJinDuImageView.frame.size.width);
                
                [self.delegate currentJinDu:(sliderCurrentSwapX - dragBtnJianXi - dragBtnWidth/2)/sliderSwapWidth tag:self.tag];
            }else{
                NSLog(@"%f\n%f\n%f\n%f============",recognizer.view.center.x,translation.x,self.frame.size.width/8,self.frame.size.width);
                if ((translation.x + recognizer.view.center.x > self.frame.size.width/8 + self.frame.size.width/2 && translation.x + recognizer.view.center.x<self.frame.size.height - self.frame.size.width/8 - 12 - 20 - self.frame.size.width)) {
                    //NSLog(@"======%f\n%f======",recognizer.view.center.x,translation.x);
                    if (recognizer.view.center.x <= self.frame.size.height - self.frame.size.width/8 - 12 - self.frame.size.width && recognizer.view.center.x >= self.frame.size.width/8 + self.frame.size.width/2) {
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }else if(recognizer.view.center.x > self.frame.size.height - self.frame.size.width/8 - 12 - self.frame.size.width  && translation.x <= 0){
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }else if(recognizer.view.center.x < self.frame.size.width/8 + self.frame.size.width/2  && translation.x >= 0){
                        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                             recognizer.view.center.y);
                        [recognizer setTranslation:CGPointZero inView:self];
                    }
                }else if(translation.x + recognizer.view.center.x < self.frame.size.height/8 + self.frame.size.width/2){
                    recognizer.view.center = CGPointMake(self.frame.size.width/8 + self.frame.size.width/2,
                                                         recognizer.view.center.y);
                    [recognizer setTranslation:CGPointZero inView:self];
                }else if(translation.x + recognizer.view.center.x>self.frame.size.height - self.frame.size.width/8 - 12 - 20 - self.frame.size.width){
                    recognizer.view.center = CGPointMake(self.frame.size.height - self.frame.size.width/8 - 12 - 20 - self.frame.size.width,
                                                         recognizer.view.center.y);
                    [recognizer setTranslation:CGPointZero inView:self];
                }
                sliderCurrentSwapX = recognizer.view.center.x;
                //NSLog(@"%f,%f",sliderSwapWidth,sliderCurrentSwapX);
                
                //改变本地得进度条
                CGRect r = playingJinDuImageView.frame;
                r.size.width = (sliderCurrentSwapX - self.frame.size.width/8 - self.frame.size.width/2)/sliderSwapWidth *sliderShowWidth;
                playingJinDuImageView.frame = r;
                //NSLog(@"+++++++%f",playingJinDuImageView.frame.size.width);
                
                [self.delegate currentJinDu:(sliderCurrentSwapX - self.frame.size.width/8 - self.frame.size.width/2)/sliderSwapWidth tag:self.tag];
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.delegate drapJinDuBtnUpInsideWithTag:self.tag];
        }
            break;
        default:
            break;
    }
    
}

-(void)setLoadingImageView:(CGFloat)loadingJinDu{
    CGRect r = loadingJinDuImageView.frame;
    r.size.width = sliderShowWidth * loadingJinDu;
    loadingJinDuImageView.frame = r;
}

-(void)setPlayingJinDuImageViewAndPlayBtnImageView:(CGFloat)width{
    if (self.canChangeFrame == YES) {
        CGRect r = playingJinDuImageView.frame;
        r.size.width = sliderShowWidth * width;
        playingJinDuImageView.frame = r;
        
        CGRect r1 = drapJinDuBtn.frame;
        r1.origin.x = sliderSwapWidth * width + 6;
        drapJinDuBtn.frame = r1;
    }
}

#pragma mark - setViewImage
-(void)setLoadingImageViewImage:(UIImage *)image{
    [loadingJinDuImageView setImage:image];
}

-(void)setPlayingImageViewImage:(UIImage *)image{
    [playingJinDuImageView setImage:image];
}

-(void)setBgImageViewImage:(UIImage *)image{
    [mainJinDuTiaoImageView setImage:image];
}

-(void)setDragBtnImageViewImage:(UIImage *)image{
    [drapJinDuBtn setImage:image forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
