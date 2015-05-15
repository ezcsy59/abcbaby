//
//  qinShuJieSongMsgViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-5-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol qinShuJieSongMsgViewDelegate <NSObject>

-(void)getDataByDelegete;

@end

@interface qinShuJieSongMsgViewController : FatherNavViewController
-(instancetype)initWithDic:(NSDictionary *)dic;

@property(nonatomic,assign)id<qinShuJieSongMsgViewDelegate> delegate2;
@end
