//
//  RootViewController.h
//  huang
//
//  Created by AA on 13-12-16.
//  Copyright (c) 2014年 huang. All rights reserved.
//
#import "MainBarViewController.h"
#import "HJHLoginViewController.h"
#import "UIBasicNavigationViewController.h"
#import "KGTipView.h"

#import "MainBarTeacherViewController.h"

@interface RootViewController : UIViewController <KGTipViewDelegate>

//新增一个main的tab主页
@property(nonatomic,strong) MainBarTeacherViewController* MainBarTeacherTabViewController;

@property(nonatomic,strong) MainBarViewController* mainTabViewController;
@property(nonatomic,strong) UIBasicNavigationViewController* rootNav;

@property(nonatomic,strong) HJHLoginViewController* loginViewController;
@property(nonatomic,strong) UINavigationController* loginNav;


-(void)addLoginView;
-(void)deleteLoginView;
-(void)addMainView;
-(void)deleteMainView;

//新增一个main的tab主页
-(void)addT_MainView;
-(void)deleteT_MainView;

@end
