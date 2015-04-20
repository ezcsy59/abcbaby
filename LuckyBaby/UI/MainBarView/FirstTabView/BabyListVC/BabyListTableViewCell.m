//
//  BabyListTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "BabyListTableViewCell.h"

@implementation BabyListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        
        self.leftImageView = [[HJHMyImageView alloc]init];
        self.leftImageView.frame = CGRectMake(15, 10, 60, 60);
        self.leftImageView.clipsToBounds = YES;
        self.leftImageView.layer.cornerRadius = 30;
        self.leftImageView.layer.borderWidth = 3;
        self.leftImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.leftImageView.image = [UIImage imageNamed:@"ic_picture_loading.png"];
        [self addSubview:self.leftImageView];
        
        self.firstLabel = [[HJHMyLabel alloc]init];
        self.firstLabel.frame = CGRectMake(90, 20, 200, 15);
        self.firstLabel.font = [UIFont systemFontOfSize:15];
        self.firstLabel.text = @"加载中";
        self.firstLabel.textColor = [UIColor blackColor];
        [self addSubview:self.firstLabel];
        
        self.secondLabel = [[HJHMyLabel alloc]init];
        self.secondLabel.frame = CGRectMake(90, 17 + 27, 200, 15);
        self.secondLabel.font = [UIFont systemFontOfSize:15];
        self.secondLabel.text = @"加载中...";
        self.secondLabel.textColor = [UIColor blackColor];
        [self addSubview:self.secondLabel];
        
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.image = [UIImage imageNamed:@"ic_course_more_classmates.png"];
        self.rightImage.frame = CGRectMake(280, 22, 20, 35);
        [self addSubview:self.rightImage];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 79, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}

@end
