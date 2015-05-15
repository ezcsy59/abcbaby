//
//  KGEmojiView.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-13.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "KGEmojiView.h"
#import "firstTimeEmojiArayy.h"
#define emojiSVHeight 200
@implementation KGEmojiView{
    HJHMyButton *firstBtn;
}

-(instancetype)initWithEmoji{
    if (self = [super init]) {
        [self setMainView];
    }
    return self;
}

-(instancetype)initWithFirstEmoji{
    if (self = [super init]) {
        [self setMainView2];
    }
    return self;
}

-(void)setMainView{
    self.frame = CGRectMake(0, 0, 320, iPhone5?568:480);
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self addGestureRecognizer:tap];
    
    HJHMyImageView *headerLine = [[HJHMyImageView alloc]init];
    headerLine.frame = CGRectMake(0, (iPhone5?568:480) - emojiSVHeight, 320, 0.5);
    headerLine.backgroundColor = [UIColor colorWithHexString:@"F08221"];
    [self addSubview:headerLine];
    
    UIScrollView *emojiSV = [[UIScrollView alloc]init];
    emojiSV.backgroundColor = [UIColor whiteColor];
    emojiSV.frame = CGRectMake(0, (iPhone5?568:480) - emojiSVHeight, 320, emojiSVHeight);
    [emojiSV setContentSize:CGSizeMake(320*6, emojiSVHeight)];
    emojiSV.showsHorizontalScrollIndicator = NO;
    emojiSV.showsVerticalScrollIndicator = NO;
    emojiSV.pagingEnabled = YES;
    [self addSubview:emojiSV];
    
    for (int i = 0; i < 21; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(0 + (i%7) * 47, 10 + (i/7) *47, 40, 40);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
    
    for (int i = 21; i < 42; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(320 + ((i-21)%7) * 47, 10 + ((i-21)/7) *47, 40, 40);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
        
        if (i == 34) {
            [btn setImage:[UIImage imageNamed:@"[p107]"] forState:UIControlStateNormal];
            btn.tag = 107;
        }
    }
    
    for (int i = 42; i < 63; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(640 + ((i-42)%7) * 47, 10 + ((i-42)/7) *47, 40, 40);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
    
    for (int i = 63; i < 84; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(960 + ((i-63)%7) * 47, 10 + ((i-63)/7) *47, 40, 40);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
        
        if (i == 69) {
            [btn setImage:[UIImage imageNamed:@"[p108]"] forState:UIControlStateNormal];
            btn.tag = 108;
        }
    }
    
    for (int i = 84; i < 105; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(1280 + ((i-84)%7) * 47, 10 + ((i-84)/7) *47, 40, 40);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
        
        if (i == 104) {
            [btn setImage:[UIImage imageNamed:@"[p109]"] forState:UIControlStateNormal];
            btn.tag = 109;
        }
    }
    
    for (int i = 105; i < 110; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(1600 + ((i-105)%7) * 47, 10 + ((i-105)/7) *47, 47, 47);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[p%d]",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
}

-(void)btnClick:(HJHMyButton*)btn{
    [self.delegate2 addEmoji:[NSString stringWithFormat:@"[p%ld]",(long)btn.tag]];
}


-(void)hideView{
    [self.delegate2 hideView];

}

-(void)addEmoji:(NSString*)emoji{
    
}
//*****************************************
-(void)setMainView2{
    
    NSArray *array = [firstTimeEmojiArayy firstTimeEmojiArayy];
    self.frame = CGRectMake(0, 0, 320, iPhone5?568:480);
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self addGestureRecognizer:tap];

    UIScrollView *emojiSV = [[UIScrollView alloc]init];
    emojiSV.frame = CGRectMake(0, (iPhone5?568:480) - emojiSVHeight, 320, emojiSVHeight);
    [emojiSV setContentSize:CGSizeMake(320*4, emojiSVHeight)];
    emojiSV.showsHorizontalScrollIndicator = NO;
    emojiSV.showsVerticalScrollIndicator = NO;
    emojiSV.pagingEnabled = YES;
    emojiSV.backgroundColor = [UIColor whiteColor];
    [self addSubview:emojiSV];
    
    HJHMyImageView *headerLine = [[HJHMyImageView alloc]init];
    headerLine.frame = CGRectMake(0, (iPhone5?568:480) - emojiSVHeight, 320, 0.5);
    headerLine.backgroundColor = [UIColor colorWithHexString:@"F08221"];
    [self addSubview:headerLine];
    
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
    nameLabel.text = @"宝宝大事记";
    nameLabel.frame = CGRectMake(10, (iPhone5?568:480) - emojiSVHeight, 100, 40);
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:nameLabel];
    
    firstBtn = [[HJHMyButton alloc]init];
    firstBtn.frame = CGRectMake(210, 5, 30, 30);
    [firstBtn setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [emojiSV addSubview:firstBtn];
    
    
    HJHMyLabel *firstLabel = [[HJHMyLabel alloc]init];
    firstLabel.text = @"第一次";
    firstLabel.frame = CGRectMake(260, (iPhone5?568:480) - emojiSVHeight, 60, 40);
    firstLabel.textColor = [UIColor blackColor];
    firstLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:firstLabel];
    
    HJHMyImageView *headerLine2 = [[HJHMyImageView alloc]init];
    headerLine2.frame = CGRectMake(10, (iPhone5?568:480) - emojiSVHeight + 40, 300, 0.5);
    headerLine2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:headerLine2];
    
    for (int i = 0; i < 9; i++) {
        NSArray *arr = [array objectAtIndex:i];
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(10 + (i%3) * 100, 20 + (i/3) *47, 100, 100);
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [btn setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(30, 10, 30, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
    for (int i = 9; i < 18; i++) {
        NSArray *arr = [array objectAtIndex:i];
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(330 + ((i - 9)%3) * 100, 20 + ((i - 9)/3) *47, 100, 100);
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [btn setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(30, 10, 30, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
    for (int i = 18; i < 27; i++) {
        NSArray *arr = [array objectAtIndex:i];
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(650 + ((i - 18)%3) * 100, 20 + ((i - 18)/3) *47, 100, 100);
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [btn setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(30, 10, 30, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
    for (int i = 27; i < 33; i++) {
        NSArray *arr = [array objectAtIndex:i];
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(970 + ((i - 27)%3) * 100, 20 + ((i - 27)/3) *47, 100, 100);
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [btn setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(30, 10, 30, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [emojiSV addSubview:btn];
    }
}

-(void)firstBtnClick:(HJHMyButton*)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else{
        btn.selected = YES;
    }
}

-(void)btnClick2:(HJHMyButton*)btn{
    NSArray *array = [firstTimeEmojiArayy firstTimeEmojiArayy];
    NSArray *arr = [array objectAtIndex:btn.tag];
    [self.delegate2 addFirstEmoji:[arr objectAtIndex:1] isFirst:firstBtn.selected];
}
@end
