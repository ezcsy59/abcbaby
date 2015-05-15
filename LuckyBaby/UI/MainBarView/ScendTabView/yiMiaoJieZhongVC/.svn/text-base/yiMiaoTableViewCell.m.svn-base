//
//  yiMiaoTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "yiMiaoTableViewCell.h"

@implementation yiMiaoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.frame = CGRectMake(240, 10, 20, 40);
        self.rightImage.layer.cornerRadius = 30;
        self.rightImage.contentMode = UIViewContentModeScaleToFill;
        self.rightImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.rightImage.image = [UIImage imageNamed:@"lab_j_a.png"];
        [self addSubview:self.rightImage];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.frame = CGRectMake(15, 10, 150, 18);
        self.leftLabel1.font = [UIFont systemFontOfSize:15];
        self.leftLabel1.text = @"";
        self.leftLabel1.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[HJHMyLabel alloc]init];
        self.leftLabel2.frame = CGRectMake(15, 37, 150, 18);
        self.leftLabel2.font = [UIFont systemFontOfSize:15];
        self.leftLabel2.text = @"";
        self.leftLabel2.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel2];
        
        self.rightLabel = [[HJHMyLabel alloc]init];
        self.rightLabel.frame = CGRectMake(260, 0, 60, 60);
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.text = @"";
        self.rightLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.rightLabel];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 69, 320, 0.5);
        [self addSubview:self.footImage];
    }
    return self;
}


@end
