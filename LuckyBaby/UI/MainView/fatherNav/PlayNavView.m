//
//  PlayNavView.m
//  huang
//
//  Created by terrence on 14-1-4.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "PlayNavView.h"

@implementation PlayNavView
@synthesize titleLabel,line;

-(id)init
{
    CGRect navFrame;
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        if (iOS7)
        {
            navFrame = CGRectMake(0, 0, ScreenWidth, 65);
        }
        else
        {
            navFrame = CGRectMake(0, 0, ScreenWidth, 50);
        }
        self.frame = navFrame;
        NSLog(@"%f",self.frame.size.height);
        if (self)
        {
            //给nav设置一个顶部图片
            HJHMyImageView *bgStatusView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
            [bgStatusView setBackgroundColor:[UIColor blackColor]];
            [self addSubview:bgStatusView];
            
            
            //给nav设置一个顶部图片
            HJHMyImageView *bgImg = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, ScreenWidth, 1)];
            [bgImg setBackgroundColor:[UIColor lightGrayColor]];
       //     [bgImg setImage:[UIImage imageNamed:@"top_bar.png"]];
            [self addSubview:bgImg];
            [self initView];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initView
{
    [self setBackgroundColor:[UIColor clearColor]];
    CGRect titleFrame = CGRectMake(0, 0, 220, 30);
    CGPoint titleCenterPoint;
    if (iOS7)
    {
        titleCenterPoint = CGPointMake(self.bounds.size.width/2, 43);
    }
    else
    {
        titleCenterPoint = CGPointMake(self.bounds.size.width/2, 28);
    }
    
    titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.center = titleCenterPoint;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
