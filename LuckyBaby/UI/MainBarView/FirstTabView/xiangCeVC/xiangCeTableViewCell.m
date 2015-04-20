//
//  xiangCeTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "xiangCeTableViewCell.h"

@implementation xiangCeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        self.leftImage = [[HJHMyImageView alloc]init];
        self.leftImage.frame = CGRectMake(10, 10, 100, 100);
        self.leftImage.image = [UIImage imageNamed:@"ic_picture_loading.png"];
        [self addSubview:self.leftImage];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.frame = CGRectMake(120, 10, 150, 100);
        self.leftLabel1.font = [UIFont systemFontOfSize:25];
        self.leftLabel1.text = @"nnn的妈妈";
        self.leftLabel1.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[HJHMyLabel alloc]init];
        self.leftLabel2.frame = CGRectMake(120, 30, 120, 18);
        self.leftLabel2.font = [UIFont systemFontOfSize:15];
        self.leftLabel2.text = @"3月";
        self.leftLabel2.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [self addSubview:self.leftLabel2];
        
        self.leftLabel3 = [[HJHMyLabel alloc]init];
        self.leftLabel3.frame = CGRectMake(120, 55, 120, 18);
        self.leftLabel3.font = [UIFont systemFontOfSize:14];
        self.leftLabel3.text = @"照片2";
        self.leftLabel3.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.leftLabel3];
        
        self.leftLabel4 = [[HJHMyLabel alloc]init];
        self.leftLabel4.frame = CGRectMake(120, 75, 120, 18);
        self.leftLabel4.font = [UIFont systemFontOfSize:15];
        self.leftLabel4.text = @"视频1";
        self.leftLabel4.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.leftLabel4];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 119, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}

@end
