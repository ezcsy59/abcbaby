//
//  KGKeChengView.m
//  KGCalendarView
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "KGKeChengView.h"
// 280 * 392
@interface KGKeChengView ()
@property(nonatomic,strong)NSArray *labelArray;
@end

@implementation KGKeChengView

-(instancetype)initWithFrame:(CGRect)frame labelArray:(NSArray*)labelArray{
    if (self = [super initWithFrame:frame]) {
        self.labelArray = labelArray;
        [self setMainView];
    }
    return self;
}


-(void)setMainView{
    for (int i = 0; i < 30; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(40 + (i/6)*56, 56 + (i%6)*56, 56, 56);
        [self addSubview:imageV];
        UIImageView *footImageV = [[UIImageView alloc]init];
        footImageV.frame = CGRectMake(0, 55, 56, 0.5);
        footImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:footImageV];
        
        UIImageView *rightImageV = [[UIImageView alloc]init];
        rightImageV.frame = CGRectMake(55, 0, 0.5, 56);
        rightImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:rightImageV];
        
        UILabel *mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(5, 5, 46, 46);
        mainLabel.textColor = [UIColor blackColor];
        mainLabel.font = [UIFont systemFontOfSize:18];
        mainLabel.numberOfLines = 2;
        mainLabel.textAlignment = NSTextAlignmentCenter;
        mainLabel.text = [self.labelArray objectAtIndex:i];
        [imageV addSubview:mainLabel];
    }
//    UIImageView *leftImageV = [[UIImageView alloc]init];
//    leftImageV.frame = CGRectMake(0, 0, 0.5, 392);
//    leftImageV.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:leftImageV];
//    
//    UIImageView *topImageV = [[UIImageView alloc]init];
//    topImageV.frame = CGRectMake(0, 0, 280 + 40, 0.5);
//    topImageV.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:topImageV];
    //数字label
    for (int i = 0; i < 7; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.backgroundColor = [UIColor colorWithHexString:@"4DD0C8"];
        imageV.frame = CGRectMake(0, i*56, 40, 56);
        [self addSubview:imageV];
        
        UIImageView *footImageV = [[UIImageView alloc]init];
        footImageV.frame = CGRectMake(0, 55, 40, 0.5);
        footImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:footImageV];
        
        UIImageView *rightImageV = [[UIImageView alloc]init];
        rightImageV.frame = CGRectMake(39, 0, 0.5, 56);
        rightImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:rightImageV];
        
        UILabel *mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(5, 5, 20, 46);
        mainLabel.textColor = [UIColor blackColor];
        mainLabel.font = [UIFont systemFontOfSize:15];
        mainLabel.textAlignment = NSTextAlignmentCenter;
        if(i != 0){
            mainLabel.text = [NSString stringWithFormat:@"%d",i];
        }
        else{
            imageV.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        }
        [imageV addSubview:mainLabel];
    }
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        imageV.frame = CGRectMake(40 + i*56, 0, 56, 56);
        [self addSubview:imageV];
        
        UIImageView *footImageV = [[UIImageView alloc]init];
        footImageV.frame = CGRectMake(0, 55, 56, 0.5);
        footImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:footImageV];
        
        UIImageView *rightImageV = [[UIImageView alloc]init];
        rightImageV.frame = CGRectMake(55, 0, 0.5, 56);
        rightImageV.backgroundColor = [UIColor lightGrayColor];
        [imageV addSubview:rightImageV];
        
        UILabel *mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(5, 5, 46, 46);
        mainLabel.textColor = [UIColor blackColor];
        mainLabel.font = [UIFont systemFontOfSize:18];
        mainLabel.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                mainLabel.text = @"周一";
            }
                break;
            case 1:
            {
                mainLabel.text = @"周二";
            }
                break;
            case 2:
            {
                mainLabel.text = @"周三";
            }
                break;
            case 3:
            {
                mainLabel.text = @"周四";
            }
                break;
            case 4:
            {
                mainLabel.text = @"周五";
            }
                break;
            default:
                break;
        }
        [imageV addSubview:mainLabel];
    }
}
@end
