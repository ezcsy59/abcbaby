//
//  qinListTableViewCell2.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "qinListTableViewCell2.h"

@implementation qinListTableViewCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.frame = CGRectMake(280, 5, 30, 30);
        self.rightImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.rightImage.image = [UIImage imageNamed:@"add_qin.png"];
        [self addSubview:self.rightImage];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.frame = CGRectMake(15, 11, 120, 18);
        self.leftLabel1.font = [UIFont systemFontOfSize:18];
        self.leftLabel1.textAlignment = NSTextAlignmentCenter;
        self.leftLabel1.text = @"可添加的亲";
        self.leftLabel1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        [self addSubview:self.leftLabel1];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 39, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}

@end
