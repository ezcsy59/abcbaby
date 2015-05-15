//
//  xigaiMimaViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-18.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xigaiMimaViewController : FatherNavViewController<KGSelectViewDelegate>
@property(nonatomic,copy)NSString *parentName;

-(instancetype)initWithStyle:(int)style;
@end
