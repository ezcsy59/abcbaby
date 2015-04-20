//
//  HJHMessageTableViewCell.m
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHMessageTableViewCell.h"
@implementation HJHMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 5 - 30, 10, 30, 30)];
        UIImage *image2 = [UIImage imageNamed:@"P1.jpg"];
        [self.userImageView setImage:image2];
        [self addSubview:self.userImageView];
        
        self.bgImageView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"chat_bubble_me_1stline.png"];
        image  = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self.bgImageView setImage:image];
        [self addSubview:self.bgImageView];
        
        self.messageName = [[UILabel alloc]init];
        self.messageName.font = [UIFont systemFontOfSize:12];
        self.messageName.textColor = [UIColor lightGrayColor];
        [self addSubview:self.messageName];
        
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        self.messageLabel.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:self.messageLabel];
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
