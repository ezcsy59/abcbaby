//
//  ThirdTableViewCell.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-31.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgImagaView = [[HJHMyImageView alloc]init];
        [self addSubview:self.bgImagaView];
        
        self.mainLabel = [[HJHMyLabel alloc]init];
        self.mainLabel.frame = CGRectMake(15, 10, 320, 20);
        self.mainLabel.font = [UIFont systemFontOfSize:20];
        self.mainLabel.textColor = [UIColor blackColor];
        [self addSubview:self.mainLabel];
        
        self.smallLabel = [[HJHMyLabel alloc]init];
        self.smallLabel.frame = CGRectMake(15, 40, 320, 15);
        self.smallLabel.font = [UIFont systemFontOfSize:15];
        self.smallLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:self.smallLabel];
        
        self.footImageView = [[HJHMyImageView alloc]init];
        self.footImageView.frame = CGRectMake(0, 64, 320, 0.5);
        self.footImageView.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [self addSubview:self.footImageView];
        
    }
    return self;
}
@end
