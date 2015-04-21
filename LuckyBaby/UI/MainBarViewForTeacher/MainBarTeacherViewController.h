//
//  MainBarTeacherViewController.h
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t_FirstTabViewController.h"
#import "t_SecondTabViewController.h"
#import "t_ThirdTabViewController.h"
#import "t_FouthTabViewController.h"

@interface MainBarTeacherViewController : FatherNavViewController
@property(nonatomic,strong)t_FirstTabViewController *firstTabVC;
@property(nonatomic,strong)t_SecondTabViewController *secondTabVC;
@property(nonatomic,strong)t_ThirdTabViewController *thirdTabVC;
@property(nonatomic,strong)t_FouthTabViewController *fouthTabVC;
@end
