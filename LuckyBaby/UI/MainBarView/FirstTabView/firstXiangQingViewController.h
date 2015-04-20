//
//  firstXiangQingViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIInputToolbarViewController2.h"
@interface firstXiangQingViewController :  FatherNavViewController<sendMessage>{
    UIInputToolbarViewController2 *InputToolbarView;
}
-(instancetype)initWithXiangQingDic:(NSDictionary *)xiangQingDic;

@end
