//
//  KGSeclectedView2.m
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//
//判断当前设备是否iphone5，用于屏幕适配显示判断使用
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#import "KGSeclectedView2.h"
#import "HJHMyImageView.h"
@implementation KGSeclectedView2{
    UIScrollView *sV;
}
-(id)initWithDictionary:(NSMutableArray*)arr withTitile:(NSString*)title andSelectedTagArray:(NSArray*)SelectedtagArray{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.frame];
        bgImageView.backgroundColor = [UIColor blackColor];
        bgImageView.alpha = 0.3;
        bgImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancalSelectClicked)];
        [bgImageView addGestureRecognizer:tap];
        
        [self addSubview:bgImageView];
        
        sV = [[UIScrollView alloc]init];
        sV.backgroundColor = [UIColor whiteColor];
        sV.userInteractionEnabled = YES;
        
        UIButton *btnComplete = [[UIButton alloc]init];
        [btnComplete setTitle:@"确认" forState:UIControlStateNormal];
        [btnComplete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnComplete.backgroundColor = [UIColor whiteColor];
        [btnComplete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sV addSubview:btnComplete];
        
        if (arr.count < 7) {
            sV.frame = CGRectMake(10, (iPhone5?568:480)/2 - ((arr.count) * 50)/2, 300, (arr.count+1) * 50);
            [sV setContentSize:CGSizeMake(100, (arr.count+1) * 50)];
            btnComplete.frame = CGRectMake(0, sV.contentSize.height - 50, 300, 50);
        }
        else{
            sV.frame = CGRectMake(10, (iPhone5?568:480)/2 - (350)/2, 300, 350 + 50);
            [sV setContentSize:CGSizeMake(100, (arr.count+1) * 50)];
            btnComplete.frame = CGRectMake(0, sV.contentSize.height - 50, 300, 50);
        }
        
        for (int i = 0; i<arr.count; i++) {
            UILabel *titleLabel3 = [[UILabel alloc]init];
            titleLabel3.textColor = [UIColor blackColor];
            titleLabel3.font = [UIFont systemFontOfSize:20];
            titleLabel3.text = [arr objectAtIndex:i];
            titleLabel3.frame = CGRectMake(15, i*50, 270, 50);
            [sV addSubview:titleLabel3];
            
            UIImageView *footLayer = [[UIImageView alloc]init];
            footLayer.frame = CGRectMake(0, i*50+49.5, 300, 0.5);
            footLayer.backgroundColor = [UIColor lightGrayColor];
            [sV addSubview:footLayer];
        }
        
        for (int i = 0; i < arr.count; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(260, 10 + i*50, 30, 30);
            btn.tag = 1000 + i;
            for (NSString *string in SelectedtagArray) {
                if (btn.tag%1000 == [string integerValue]) {
                    btn.selected = YES;
                }
            }
            [btn setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [sV addSubview:btn];
        }
        
        [self addSubview:sV];
        
        
        
        UILabel *titleLabel2 = [[UILabel alloc]init];
        titleLabel2.textColor = [UIColor colorWithHexString:@"93C6E9"];
        titleLabel2.font = [UIFont systemFontOfSize:20];
        titleLabel2.text = title;
        if (arr.count < 7) {
            HJHMyImageView *imageV = [[HJHMyImageView alloc]init];
            imageV.frame = CGRectMake(10, (iPhone5?568:480)/2 - (arr.count * 50)/2 - 50, 300, 50);
            imageV.backgroundColor = [UIColor whiteColor];
            [self addSubview:imageV];
            
            titleLabel2.frame = CGRectMake(15, 0, 270, 40);
            [imageV addSubview:titleLabel2];
            
            UIImageView *footLayer = [[UIImageView alloc]init];
            footLayer.frame = CGRectMake(0, 50 - 4, 300, 4);
            footLayer.backgroundColor = [UIColor colorWithHexString:@"93C6E9"];
            [imageV addSubview:footLayer];
        }
        else{
            HJHMyImageView *imageV = [[HJHMyImageView alloc]init];
            imageV.frame = CGRectMake(10, (iPhone5?568:480)/2 - (350)/2 - 50, 300, 50);
            imageV.backgroundColor = [UIColor whiteColor];
            [self addSubview:imageV];
            
            titleLabel2.frame = CGRectMake(15, 0, 270, 50);
            [imageV addSubview:titleLabel2];
            
            UIImageView *footLayer = [[UIImageView alloc]init];
            footLayer.frame = CGRectMake(0, 50 - 4, 300, 4);
            footLayer.backgroundColor = [UIColor colorWithHexString:@"93C6E9"];
            [imageV addSubview:footLayer];
        }
    }
    return self;
    
}

-(void)selectbtnClick:(UIButton*)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else{
        btn.selected = YES;
    }
}

-(void)btnClick:(UIButton*)btn{
    NSMutableArray *arry = [NSMutableArray array];
    for (UIButton *button in sV.subviews) {
        if (button.tag >= 1000) {
            if (button.selected == YES) {
                [arry addObject:[NSString stringWithFormat:@"%ld",button.tag%1000]];
            }
        }
    }
    [self.delegate2 selectBtnClick:arry];
}

-(void)cancalSelectClicked{
    [self removeFromSuperview];
}
@end
