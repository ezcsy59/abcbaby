//
//  t_HJHFouthMainCell.m
//  weixinDemo
//
//  Created by huang on 4/21/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "t_HJHFouthMainCell.h"

@implementation t_HJHFouthMainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgImagaView = [[HJHMyImageView alloc]init];
        [self addSubview:self.bgImagaView];
        
        self.backgroundColor = [UIColor whiteColor];
        self.leftImage = [[HJHMyImageView alloc]init];
        self.leftImage.frame = CGRectMake(15, 10, 25, 25);
        [self addSubview:self.leftImage];
        
        self.label = [[HJHMyLabel alloc]init];
        self.label.font = [UIFont systemFontOfSize:18];
        self.label.frame = CGRectMake(50, 0, 200, 45);
        [self addSubview:self.label];
        
        self.label2 = [[HJHMyLabel alloc]init];
        self.label2.font = [UIFont systemFontOfSize:18];
        self.label2.frame = CGRectMake(200, 0, 80, 45);
        self.label2.textAlignment = NSTextAlignmentRight;
        self.label2.textColor = [UIColor colorWithHexString:@"#D1D1D1"];
        self.label2.hidden = YES;
        [self addSubview:self.label2];
        
        self.footLayer = [[HJHMyImageView alloc]init];
        self.footLayer.frame = CGRectMake(0, 44, ScreenWidth, 1);
        self.footLayer.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        [self addSubview:self.footLayer];
        
        self.rightImage = [[HJHMyImageView alloc]init];
        self.rightImage.frame = CGRectMake(270, 13, 10, 17.5);
        [self addSubview:self.rightImage];
    }
    return self;
}

@end
