//
//  KGSelectView.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//自定义选择框

#import "KGSelectView.h"

@implementation KGSelectView

-(id)initWithDictionary:(NSMutableArray*)arr title:(NSString*)title cancelBtn:(NSString*)cancelBtn{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.frame];
        bgImageView.backgroundColor = [UIColor blackColor];
        //透明度
        bgImageView.alpha = 0.5;
        //交互事件是否相应
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        
        //真正选择控件
        UIImageView *selectView = [[UIImageView alloc]init];
        selectView.userInteractionEnabled = YES;
        selectView.frame = CGRectMake(0, ((iPhone5?568:480)/2 - (arr.count+2)*50/2), 320, (arr.count+2)*50);
        //圆角
        selectView.layer.cornerRadius = 8.0;
        selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectView];
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        titleLabel1.textColor = [UIColor colorWithHexString:@"#F08221"];
        titleLabel1.font = [UIFont systemFontOfSize:20];
        titleLabel1.text = title;
        titleLabel1.frame = CGRectMake(15, 0, 320, 50);
        [selectView addSubview:titleLabel1];
        
        UIImageView *titleLayer = [[UIImageView alloc]init];
        titleLayer.frame = CGRectMake(0, 49, 320, 2);
        titleLayer.backgroundColor = [UIColor colorWithHexString:@"#F08221"];
        [selectView addSubview:titleLayer];
        
        UILabel *titleLabel2 = [[UILabel alloc]init];
        titleLabel2.textColor = [UIColor blackColor];
        titleLabel2.font = [UIFont systemFontOfSize:20];
        titleLabel2.text = cancelBtn;
        titleLabel2.frame = CGRectMake(15, (arr.count+1)*50, 320, 50);
        [selectView addSubview:titleLabel2];
        
        UIImageView *footLayer = [[UIImageView alloc]init];
        footLayer.frame = CGRectMake(0, (arr.count)*50 + 49, 320, 2);
        footLayer.backgroundColor = [UIColor lightGrayColor];
        [selectView addSubview:footLayer];
        
        
        for (int i = 0; i<arr.count; i++) {
            UILabel *titleLabel3 = [[UILabel alloc]init];
            titleLabel3.textColor = [UIColor blackColor];
            titleLabel3.font = [UIFont systemFontOfSize:20];
            titleLabel3.text = [arr objectAtIndex:i];
            titleLabel3.frame = CGRectMake(15, (i+1)*50, 320, 50);
            [selectView addSubview:titleLabel3];
            
            if (i != arr.count - 1) {
                UIImageView *footLayer = [[UIImageView alloc]init];
                footLayer.frame = CGRectMake(0, (i+1)*50+49.5, 320, 0.5);
                footLayer.backgroundColor = [UIColor lightGrayColor];
                [selectView addSubview:footLayer];
            }
        }
        
        
        for (int i = 0; i < arr.count + 1; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(0, (i+1)*50, 320, 50);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [selectView addSubview:btn];
        }
    }
    return self;
}

-(id)initWithDictionary:(NSMutableArray*)arr{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.frame];
        bgImageView.backgroundColor = [UIColor clearColor];
        bgImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancalSelectClicked)];
        [bgImageView addGestureRecognizer:tap];
        
        [self addSubview:bgImageView];
        
        UIScrollView *sV = [[UIScrollView alloc]init];
        sV.backgroundColor = [UIColor whiteColor];
        sV.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
        sV.layer.borderWidth = 1;
        sV.userInteractionEnabled = YES;
        if (arr.count < 7) {
            sV.frame = CGRectMake(110, (iPhone5?568:480)/2 - (arr.count * 50)/2, 100, arr.count * 50);
            [sV setContentSize:CGSizeMake(100, arr.count * 50)];
        }
        else{
            sV.frame = CGRectMake(110, (iPhone5?568:480)/2 - (350)/2, 100, 350);
            [sV setContentSize:CGSizeMake(100, arr.count * 50)];
        }
        
        for (int i = 0; i<arr.count; i++) {
            UILabel *titleLabel3 = [[UILabel alloc]init];
            titleLabel3.textColor = [UIColor blackColor];
            titleLabel3.font = [UIFont systemFontOfSize:20];
            titleLabel3.text = [arr objectAtIndex:i];
            titleLabel3.frame = CGRectMake(15, i*50, 70, 50);
            [sV addSubview:titleLabel3];
            
            if (i != arr.count - 1) {
                UIImageView *footLayer = [[UIImageView alloc]init];
                footLayer.frame = CGRectMake(0, i*50+49.5, 100, 0.5);
                footLayer.backgroundColor = [UIColor lightGrayColor];
                [sV addSubview:footLayer];
            }
        }
        
        for (int i = 0; i < arr.count + 1; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(0, i*50, 100, 50);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [sV addSubview:btn];
        }
        
        [self addSubview:sV];
    }
    return self;
}

-(id)initWithDictionary:(NSMutableArray*)arr withTitile:(NSString*)title{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.frame];
        bgImageView.backgroundColor = [UIColor blackColor];
        bgImageView.alpha = 0.3;
        bgImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancalSelectClicked)];
        [bgImageView addGestureRecognizer:tap];
        
        [self addSubview:bgImageView];
        
        UIScrollView *sV = [[UIScrollView alloc]init];
        sV.backgroundColor = [UIColor whiteColor];
        sV.userInteractionEnabled = YES;
        
        if (arr.count < 7) {
            sV.frame = CGRectMake(10, (iPhone5?568:480)/2 - (arr.count * 50)/2, 300, arr.count * 50);
            [sV setContentSize:CGSizeMake(100, arr.count * 50)];
        }
        else{
            sV.frame = CGRectMake(10, (iPhone5?568:480)/2 - (350)/2, 300, 350);
            [sV setContentSize:CGSizeMake(100, arr.count * 50)];
        }
        
        for (int i = 0; i<arr.count; i++) {
            UILabel *titleLabel3 = [[UILabel alloc]init];
            titleLabel3.textColor = [UIColor blackColor];
            titleLabel3.font = [UIFont systemFontOfSize:20];
            titleLabel3.text = [arr objectAtIndex:i];
            titleLabel3.frame = CGRectMake(15, i*50, 270, 50);
            [sV addSubview:titleLabel3];
            
            if (i != arr.count - 1) {
                UIImageView *footLayer = [[UIImageView alloc]init];
                footLayer.frame = CGRectMake(0, i*50+49.5, 300, 0.5);
                footLayer.backgroundColor = [UIColor lightGrayColor];
                [sV addSubview:footLayer];
            }
        }
        
        for (int i = 0; i < arr.count + 1; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(0, i*50, 300, 50);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
            
            titleLabel2.frame = CGRectMake(15, 0, 270, 50);
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

-(void)cancalSelectClicked{
    [self.delegate2 cancalSelectClicked];
}

-(void)btnClick:(UIButton*)btn{
    [self.delegate2 selectBtnClick:btn.tag];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
