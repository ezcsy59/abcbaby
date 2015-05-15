//
//  KGSelectDateView.m
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//

#import "KGSelectDateView.h"

@interface KGSelectDateView ()
@property (nonatomic,assign)NSInteger chageSize;
@property (nonatomic,strong)NSString *inputTime;
@end

@implementation KGSelectDateView

-(instancetype)initWithDateChanegSize:(NSInteger)changeSize{
    if (self = [super init]) {
        self.chageSize = changeSize;
        self.frame = CGRectMake(0, 0, 320, 60);
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        UIButton *leftBtn = [[UIButton alloc]init];
        leftBtn.frame = CGRectMake(25, 15, 20, 30);
        [leftBtn setImage:[UIImage imageNamed:@"left_icon"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [[UIButton alloc]init];
        rightBtn.frame = CGRectMake(265, 15, 20, 30);
        [rightBtn setImage:[UIImage imageNamed:@"right_icon"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        NSDate *date = [NSDate date];
        NSString *string = [date description];
        NSArray *array = [string componentsSeparatedByString:@" "];
        self.timelabel = [[HJHMyLabel alloc]init];
        
        self.inputTime = [array objectAtIndex:0];
        if (self.chageSize == 1) {
            self.timelabel.text = [array objectAtIndex:0];
        }
        else if(self.chageSize == 7){
            
        }
        else if(self.chageSize == 30){
            self.timelabel.text = [array objectAtIndex:0];
            NSArray *array2 = [self.timelabel.text componentsSeparatedByString:@"-"];
            self.timelabel.text = [NSString stringWithFormat:@"%@-%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
        }
        self.timelabel.font = [UIFont systemFontOfSize:20];
        self.timelabel.frame = CGRectMake(0, 0, 320, 60);
        self.timelabel.textColor = [UIColor blackColor];
        self.timelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timelabel];
    }
    return self;
}

-(void)leftBtnClick{
    NSString *oldTime = self.timelabel.text;
    
    if(self.chageSize == 1){
        self.timelabel.text = [TimeChange getLastday:self.timelabel.text];
    }
    else if(self.chageSize == 7){
    }
    else if(self.chageSize == 30){
        self.timelabel.text = [TimeChange getLastMonth:self.inputTime];
        self.inputTime = [TimeChange getLastMonth:self.inputTime];
        NSArray *array2 = [self.timelabel.text componentsSeparatedByString:@"-"];
        self.timelabel.text = [NSString stringWithFormat:@"%@-%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
    }
    
    if ([self.delegate2 respondsToSelector:@selector(changeDateWithStartDate:endDate:)]) {
        [self.delegate2 changeDateWithStartDate:self.timelabel.text endDate:oldTime];
    }
    if ([self.delegate2 respondsToSelector:@selector(changeDateWithStartDate:endDate:isLetfBtnClick:)]) {
        [self.delegate2 changeDateWithStartDate:self.timelabel.text endDate:oldTime isLetfBtnClick:YES];
    }
}

-(void)rightBtnClick{
    NSString *oldTime = self.timelabel.text;
    if(self.chageSize == 1){
        self.timelabel.text = [TimeChange getNextday:self.timelabel.text];
        NSArray *array2 = [self.timelabel.text componentsSeparatedByString:@"-"];
        self.timelabel.text = [NSString stringWithFormat:@"%@-%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
    }
    else if(self.chageSize == 7){
        
    }
    else if(self.chageSize == 30){
        self.timelabel.text = [TimeChange getNextMonth:self.inputTime];
        self.inputTime = [TimeChange getNextMonth:self.inputTime];
        NSArray *array2 = [self.timelabel.text componentsSeparatedByString:@"-"];
        self.timelabel.text = [NSString stringWithFormat:@"%@-%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
    }
    
    if ([self.delegate2 respondsToSelector:@selector(changeDateWithStartDate:endDate:)]) {
        [self.delegate2 changeDateWithStartDate:oldTime endDate:self.timelabel.text];
    }
    if ([self.delegate2 respondsToSelector:@selector(changeDateWithStartDate:endDate:isLetfBtnClick:)]) {
        [self.delegate2 changeDateWithStartDate:oldTime endDate:self.timelabel.text isLetfBtnClick:NO];
    }
}
@end
