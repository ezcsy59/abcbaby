//
//  HJHTimePickerView.h
//  PickerView
//
//  Created by 黄嘉宏 on 15-4-1.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJHTimePickerViewDelegate <NSObject>

-(void)hjhTimeGetDifang:(NSString*)area;

-(void)hjhTimeCancalbClicked;

@end

@interface HJHTimePickerView : UIView
@property(nonatomic,strong)NSMutableArray *pickerArray1;
@property(nonatomic,strong)NSMutableArray *pickerArray2;
@property(nonatomic,strong)NSMutableArray *pickerArray3;
@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,assign)id<HJHTimePickerViewDelegate>delegate2;

-(void)setPickerV;
@end
