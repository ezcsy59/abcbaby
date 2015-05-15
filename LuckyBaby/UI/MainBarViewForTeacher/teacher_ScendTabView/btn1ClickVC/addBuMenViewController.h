//
//  addBuMenViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addBuMenViewDelegate <NSObject>

-(void)selectBuMenArray:(NSArray*)array;

@end

@interface addBuMenViewController : FatherNavViewController
@property(nonatomic,assign)id<addBuMenViewDelegate>delegate2;

-(instancetype)initWithBuMenArray:(NSArray*)array;

@end
