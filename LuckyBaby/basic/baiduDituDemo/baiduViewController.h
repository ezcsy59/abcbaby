//
//  baiduViewController.h
//  DemoForTesting
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BMKLocationService.h"
#import "BMKSearchComponent.h"
#import "BMKCloudSearch.h"
#import "BMKPoiSearch.h"

@protocol baiduViewDelegate <NSObject>

-(void)popBackWith:(NSMutableArray*)locationArray;

@end

@interface baiduViewController : FatherNavViewController{
    
}

@property(nonatomic,assign)id<baiduViewDelegate> delegate2;
@property(nonatomic,assign)NSString *searchName;
//获取坐标数组
-(void)beginDingWei;
@end
