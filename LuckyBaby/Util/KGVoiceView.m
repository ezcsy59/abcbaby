//
//  KGVoiceView.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-14.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "KGVoiceView.h"

@implementation KGVoiceView{
    HJHMyImageView *imageView;
    NSTimer *timer;
    NSInteger imageCount;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
        [self addGestureRecognizer:tap];
        
        HJHMyImageView *mainImageView = [[HJHMyImageView alloc]init];
        mainImageView.layer.cornerRadius = 5.0;
        mainImageView.backgroundColor = [UIColor blackColor];
        mainImageView.alpha = 0.5;
        mainImageView.frame = CGRectMake(320/2 - 160/2, (iPhone5?568:480)/2 - 160/2, 160, 160);
        [self addSubview:mainImageView];
        
        imageView = [[HJHMyImageView alloc]init];
        
        imageView.frame = CGRectMake(320/2 - 80/2, (iPhone5?568:480)/2 - 80/2, 80, 80);
        
        [self addSubview:imageView];
        
        imageCount = 0;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mic_%d",imageCount]];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
    return self;
}


-(void)changeImage{
    imageCount = (imageCount + 1)%4;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mic_%d",imageCount]];
}

-(void)hideView{
    [timer invalidate];
    [imageView removeFromSuperview];
    imageView = nil;
    imageCount = 0;
}
@end
