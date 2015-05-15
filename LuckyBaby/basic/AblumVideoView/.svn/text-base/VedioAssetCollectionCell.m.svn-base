//
//  VedioAssetCollectionCell.m
//  ALAssetDemo
//
//  Created by Kingsley on 13-6-25.
//  Copyright (c) 2013年 kingsley. All rights reserved.
//

#import "VedioAssetCollectionCell.h"
#import "VedioCustomImageView.h"
@implementation VedioAssetCollectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i<num4Row; i++) {
            VedioCustomImageView* imageV = [[VedioCustomImageView alloc]initWithFrame:CGRectMake(i*79 + 4, 4, 75, 75)];
            imageV.contentMode = UIViewContentModeScaleToFill;
            imageV.tag = i+1000;
            [self addSubview:imageV];
        }
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numForRow:(NSInteger)num{
    num4Row = num;
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
