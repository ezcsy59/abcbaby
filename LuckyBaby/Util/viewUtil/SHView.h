//
//  SHView.h
//  SHLineGraphView
//
//  Created by 黄嘉宏 on 15-4-3.
//  Copyright (c) 2015年 grevolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHView : UIView
-(instancetype)initWithFrame:(CGRect)frame andxAxisValues:(NSMutableArray*)xAxisValues plottingValues:(NSMutableArray*)plottingValues plottingPointsLabels:(NSMutableArray*)plottingPointsLabels ageArray:(NSMutableArray *)ageArray topHeight:(int)height;
@end
