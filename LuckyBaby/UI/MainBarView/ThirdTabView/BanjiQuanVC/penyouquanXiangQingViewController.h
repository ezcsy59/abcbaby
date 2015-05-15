//
//  penyouquanXiangQingViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-23.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIInputToolbarViewController2.h"

@interface penyouquanXiangQingViewController :FatherNavViewController{
    UIInputToolbarViewController2 *InputToolbarView;
}

-(instancetype)initWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic classId:(NSString*)classId className:(NSString*)className;
@end
