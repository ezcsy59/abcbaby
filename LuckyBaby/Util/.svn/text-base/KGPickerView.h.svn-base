//
//  KGPickerView.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-1.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@protocol KGPcikerViewDelegate <NSObject>

-(void)getDifang:(NSString*)area;

-(void)cancalbClicked;

@end

@interface KGPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}
@property(nonatomic,assign)id<KGPcikerViewDelegate>delegate2;

- (void) buttobClicked: (id)sender;

@end
