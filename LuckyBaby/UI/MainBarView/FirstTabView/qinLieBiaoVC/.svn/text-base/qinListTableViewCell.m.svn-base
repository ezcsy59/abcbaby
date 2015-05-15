//
//  qinListTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "qinListTableViewCell.h"

@implementation qinListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        
        self.leftImageView = [[HJHMyImageView alloc]init];
        self.leftImageView.frame = CGRectMake(20, 10, 120, 120);
        self.leftImageView.clipsToBounds = YES;
        self.leftImageView.layer.cornerRadius = 60;
        self.leftImageView.layer.borderWidth = 6;
        self.leftImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.leftImageView.image = [UIImage imageNamed:@"mine_head_img.png"];
        [self addSubview:self.leftImageView];
        
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.frame = CGRectMake(20 + 160, 10, 120, 120);
        self.rightImage.clipsToBounds = YES;
        self.rightImage.layer.cornerRadius = 60;
        self.rightImage.layer.borderWidth = 6;
        self.rightImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.rightImage.image = [UIImage imageNamed:@"mine_head_img.png"];
        [self addSubview:self.rightImage];
        
        self.leftLabel1 = [[HJHMyLabel alloc]init];
        self.leftLabel1.hidden = YES;
        self.leftLabel1.frame = CGRectMake(20, 140, 120, 18);
        self.leftLabel1.font = [UIFont systemFontOfSize:18];
        self.leftLabel1.textAlignment = NSTextAlignmentCenter;
        self.leftLabel1.text = @"";
        self.leftLabel1.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[HJHMyLabel alloc]init];
        self.leftLabel2.frame = CGRectMake(20, 140 + 17, 120, 15);
        self.leftLabel2.font = [UIFont systemFontOfSize:15];
        self.leftLabel2.textAlignment = NSTextAlignmentCenter;
        self.leftLabel2.text = @"邀请妈妈加入";
        self.leftLabel2.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel2];
        
        self.leftLabel3 = [[HJHMyLabel alloc]init];
        self.leftLabel3.hidden = YES;
        self.leftLabel3.frame = CGRectMake(20, 140 + 22, 120, 30);
        self.leftLabel3.numberOfLines = 2;
        self.leftLabel3.font = [UIFont systemFontOfSize:12];
        self.leftLabel3.textAlignment = NSTextAlignmentCenter;
        self.leftLabel3.text = @"";
        self.leftLabel3.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel3];
        
        self.rightLabel1 = [[HJHMyLabel alloc]init];
        self.rightLabel1.hidden = YES;
        self.rightLabel1.frame = CGRectMake(20 + 160, 140, 120, 18);
        self.rightLabel1.font = [UIFont systemFontOfSize:18];
        self.rightLabel1.textAlignment = NSTextAlignmentCenter;
        self.rightLabel1.text = @"";
        self.rightLabel1.textColor = [UIColor blackColor];
        [self addSubview:self.rightLabel1];
        
        self.rightLabel2 = [[HJHMyLabel alloc]init];
        self.rightLabel2.frame = CGRectMake(20 + 160, 140 + 17, 120, 15);
        self.rightLabel2.font = [UIFont systemFontOfSize:15];
        self.rightLabel2.textAlignment = NSTextAlignmentCenter;
        self.rightLabel2.text = @"邀请爸爸加入";
        self.rightLabel2.textColor = [UIColor blackColor];
        [self addSubview:self.rightLabel2];
        
        self.rightLabel3 = [[HJHMyLabel alloc]init];
        self.rightLabel3.frame = CGRectMake(20 + 160, 140 + 22, 120, 30);
        self.rightLabel3.numberOfLines = 2;
        self.rightLabel3.hidden = YES;
        self.rightLabel3.font = [UIFont systemFontOfSize:12];
        self.rightLabel3.textAlignment = NSTextAlignmentCenter;
        self.rightLabel3.text = @"";
        self.rightLabel3.textColor = [UIColor blackColor];
        [self addSubview:self.rightLabel3];
        
        self.footImage = [[HJHMyImageView alloc]init];
        self.footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        self.footImage.frame = CGRectMake(0, 199, 320, 0.5);
        [self addSubview:self.footImage];
        
        self.leftBtn = [[HJHMyButton alloc]initWithFrame:self.leftImageView.frame];
        [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [[HJHMyButton alloc]initWithFrame:self.rightImage.frame];
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
    }
    return self;
}

-(void)leftBtnClick{
    BOOL haveMan = NO;
    if (self.leftLabel2.hidden == YES) {
        haveMan = YES;
    }
    [self.delegate2 leftBtnClick:haveMan recId:self.leftRec nickName:self.leftLabel1.text];
}

-(void)rightBtnClick{
    BOOL haveMan = NO;
    if (self.rightLabel2.hidden == YES) {
        haveMan = YES;
    }
    [self.delegate2 rightBtnClick:haveMan recId:self.RightRec nickName:self.rightLabel1.text];
}


-(void)setDefualt{
    self.leftLabel2.hidden = NO;
    self.leftLabel1.hidden = YES;
    self.leftLabel3.hidden = YES;
    self.rightLabel1.hidden = YES;
    self.rightLabel3.hidden = YES;
    self.rightLabel2.hidden = NO;
    self.leftImageView.image = [UIImage imageNamed:@"mine_head_img.png"];
    self.rightImage.image = [UIImage imageNamed:@"mine_head_img.png"];
}
@end
