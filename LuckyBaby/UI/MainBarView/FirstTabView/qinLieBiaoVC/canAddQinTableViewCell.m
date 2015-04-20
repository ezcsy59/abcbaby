//
//  canAddQinTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "canAddQinTableViewCell.h"

@implementation canAddQinTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        self.leftImage = [[HJHMyImageView alloc]init];
        self.leftImage.frame = CGRectMake(20, 10, 60, 60);
        self.leftImage.layer.cornerRadius = 30;
        self.leftImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.leftImage.image = [UIImage imageNamed:@"ic_picture_loading.png"];
        [self addSubview:self.leftImage];
        
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.frame = CGRectMake(280, 25, 15, 30);
        self.rightImage.image = [UIImage imageNamed:@"ic_course_more_classmates.png"];
        [self addSubview:self.rightImage];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.frame = CGRectMake(20 + 75, 11, 120, 18);
        self.leftLabel1.font = [UIFont systemFontOfSize:15];
        self.leftLabel1.text = @"nnn的妈妈";
        self.leftLabel1.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[HJHMyLabel alloc]init];
        self.leftLabel2.frame = CGRectMake(20 + 75, 45, 120, 18);
        self.leftLabel2.font = [UIFont systemFontOfSize:15];
        self.leftLabel2.text = @"邀请加入";
        self.leftLabel2.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.leftLabel2];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 79, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}

@end
