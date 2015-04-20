//
//  ChoseAblumTableViewCell.m
//  xiaozhan
//
//  Created by huang on 7/10/14.
//  Copyright (c) 2014 Kugou. All rights reserved.
//

#import "ChoseAblumTableViewCell.h"

@implementation ChoseAblumTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[HJHMyImageView alloc]init];
        self.headImageView.frame = CGRectMake(15, 5, 80, 80);
        [self addSubview:self.headImageView];
        
        self.namesLabel = [[HJHMyLabel alloc]init];
        self.namesLabel.frame = CGRectMake(120, 20, 200, 20);
        self.namesLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.namesLabel];
        
        self.namesLabel2 = [[HJHMyLabel alloc]init];
        self.namesLabel2.frame = CGRectMake(120, 40, 200, 14);
        self.namesLabel2.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.namesLabel2];
        
//        self.footImageView = [[HJHMyImageView alloc]init];
//        self.footImageView.frame = CGRectMake(0, 89.5, 320, .5);
//        self.footImageView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:self.footImageView];
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
