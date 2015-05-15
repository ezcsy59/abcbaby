//
//  t_FirstTabViewController.h
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tab1_insertFirstTabVC.h"
#import "Tab2_insertFirstTabVC.h"
#import "Tab3_insertFirstTabVC.h"
#import "Tab4_insertFirstTabVC.h"
#import "Tab5_insertFirstTabVC.h"
#import "Tab6_insertFirstTabVC.h"
#import "Tab7_insertFirstTabVC.h"

@interface t_FirstTabViewController : UIViewController
@property(nonatomic,strong)Tab1_insertFirstTabVC *firstTabVC;
@property(nonatomic,strong)Tab2_insertFirstTabVC *secondTabVC;
@property(nonatomic,strong)Tab3_insertFirstTabVC *thirdTabVC;
@property(nonatomic,strong)Tab4_insertFirstTabVC *fouthTabVC;
@property(nonatomic,strong)Tab5_insertFirstTabVC *fiveTabVC;
@property(nonatomic,strong)Tab6_insertFirstTabVC *sixTabVC;
@property(nonatomic,strong)Tab7_insertFirstTabVC *seventTabVC;
@end
