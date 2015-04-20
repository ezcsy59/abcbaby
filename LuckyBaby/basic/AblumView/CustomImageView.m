//
//  CustomImageView.m
//  ALAssetDemo
//
//  Created by Kingsley on 13-6-25.
//  Copyright (c) 2013年 kingsley. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        self.userInteractionEnabled = YES;
        HJHMyButton *bgBtn = [[HJHMyButton alloc]init];
        bgBtn.frame = self.bounds;
        [bgBtn addTarget:self action:@selector(tapImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgBtn];
        self.selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 5, 20, 20)];
        self.selectedImageView.userInteractionEnabled = YES;
        self.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
        [self addSubview:self.selectedImageView];
    }
    return self;
}

-(void)tapImage{
    [[NSNotificationCenter defaultCenter]postNotificationName:kCustomImageTapped object:self];
}

//-(void)selectPhoto{
//    [[NSNotificationCenter defaultCenter]postNotificationName:kCustomImageSelected object:self];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
