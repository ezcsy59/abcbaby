//
//  KGSelectDateView.h
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGSelectDateViewDelegate <NSObject>

-(void)changeDateWithStartDate:(NSString*)startDate endDate:(NSString*)endDate;

@optional
-(void)changeDateWithStartDate:(NSString*)startDate endDate:(NSString*)endDate isLetfBtnClick:(BOOL)isLetfBtnClick;

@end

@interface KGSelectDateView : UIView

-(instancetype)initWithDateChanegSize:(NSInteger)changeSize;

@property (nonatomic,strong)HJHMyLabel *timelabel;
@property(nonatomic,weak)id<KGSelectDateViewDelegate> delegate2;
@end
