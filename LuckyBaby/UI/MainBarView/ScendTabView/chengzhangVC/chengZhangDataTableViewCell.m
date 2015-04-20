//
//  chengZhangDataTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "chengZhangDataTableViewCell.h"

@implementation chengZhangDataTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.frame = CGRectMake(10, 18, 160, 18);
        self.leftLabel1.font = [UIFont systemFontOfSize:18];
        self.leftLabel1.text = @"身高:            cm";
        self.leftLabel1.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[HJHMyLabel alloc]init];
        self.leftLabel2.frame = CGRectMake(210, 18, 120, 18);
        self.leftLabel2.font = [UIFont systemFontOfSize:18];
        self.leftLabel2.text = @"体重:         kg";
        self.leftLabel2.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel2];
        
        self.leftLabel3 = [[HJHMyLabel alloc]init];
        self.leftLabel3.frame = CGRectMake(55, 18, 50, 18);
        self.leftLabel3.font = [UIFont systemFontOfSize:18];
        self.leftLabel3.textAlignment = NSTextAlignmentCenter;
        self.leftLabel3.text = @"116.2";
        self.leftLabel3.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        [self addSubview:self.leftLabel3];
        
        self.leftLabel4 = [[HJHMyLabel alloc]init];
        self.leftLabel4.frame = CGRectMake(250, 18, 50, 18);
        self.leftLabel4.font = [UIFont systemFontOfSize:18];
        self.leftLabel4.textAlignment = NSTextAlignmentCenter;
        self.leftLabel4.text = @"16.8";
        self.leftLabel4.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        [self addSubview:self.leftLabel4];
        
        self.leftLabel5 = [[HJHMyLabel alloc]init];
        self.leftLabel5.frame = CGRectMake(10, 45, 180, 18);
        self.leftLabel5.font = [UIFont systemFontOfSize:18];
        self.leftLabel5.text = @"宝宝长得又高又壮";
        self.leftLabel5.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        [self addSubview:self.leftLabel5];
        
        self.leftLabel6 = [[HJHMyLabel alloc]init];
        self.leftLabel6.frame = CGRectMake(220, 45, 120, 18);
        self.leftLabel6.font = [UIFont systemFontOfSize:18];
        self.leftLabel6.text = @"2015-08-12";
        self.leftLabel6.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.leftLabel6];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 79, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}

@end
