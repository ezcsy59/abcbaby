//
//  baoBaoBinLiViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guoMinShiController.h"
#import "BinLiShiViewController.h"
#import "binLiBenViewController.h"

@interface baoBaoBinLiViewController : FatherNavViewController
@property(nonatomic,strong)binLiBenViewController *firstTabVC;
@property(nonatomic,strong)BinLiShiViewController *secondTabVC;
@property(nonatomic,strong)guoMinShiController *thirdTabVC;
@end
