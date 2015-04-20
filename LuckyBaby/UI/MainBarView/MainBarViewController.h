//
//  MainBarViewController.h
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabViewController.h"
#import "SecondTabViewController.h"
#import "ThirdTabViewController.h"
#import "FouthTabViewController.h"

@interface MainBarViewController : FatherNavViewController
@property(nonatomic,strong)FirstTabViewController *firstTabVC;
@property(nonatomic,strong)SecondTabViewController *secondTabVC;
@property(nonatomic,strong)ThirdTabViewController *thirdTabVC;
@property(nonatomic,strong)FouthTabViewController *fouthTabVC;
@end
