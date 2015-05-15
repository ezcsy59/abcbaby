//
//  HJHTimePickerView.m
//  PickerView
//
//  Created by 黄嘉宏 on 15-4-1.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#import "HJHTimePickerView.h"

@interface HJHTimePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,assign)BOOL isSelectChange;

/*
 判断是否联动
 */
@property(nonatomic,assign)int isChangeStyle;

@property(nonatomic,strong)NSMutableArray *com2Arrays;

@property(nonatomic,strong)NSMutableArray *com3Arrays;

@end

@implementation HJHTimePickerView

-(instancetype)init{
    if (self = [super init]) {
        self.pickerArray1 = [NSMutableArray array];
        self.pickerArray2 = [NSMutableArray array];
        self.pickerArray3 = [NSMutableArray array];
        self.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
        for (int i = 0; i < 24; i++) {
            [self.pickerArray1 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        for (int i = 1; i < 60; i++) {
            [self.pickerArray2 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [self setPickerV];
    }
    return self;
}

-(void)setPickerV{
    UIImageView *pBgV = [[UIImageView alloc]init];
    pBgV.backgroundColor = [UIColor whiteColor];
//    pBgV.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
    pBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pBgV.layer.borderWidth = 1;
    pBgV.frame = CGRectMake(80, 20, 160, 110);
    pBgV.layer.cornerRadius = 5.0;
    pBgV.userInteractionEnabled = YES;
    pBgV.clipsToBounds = YES;
    [self addSubview:pBgV];
    
    
//    UIButton *comBtn = [[UIButton alloc]init];
//    comBtn.frame = CGRectMake(10, (iPhone5?568:480) - 130, 300, 55);
//    comBtn.backgroundColor = [UIColor whiteColor];
//    [comBtn setTitle:@"确认" forState:UIControlStateNormal];
//    comBtn.titleLabel.font = [UIFont systemFontOfSize:25];
////    comBtn.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
//    comBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    comBtn.layer.borderWidth = 1;
//    [comBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [comBtn addTarget: self action: @selector(quebClicked) forControlEvents: UIControlEventTouchUpInside];
//    comBtn.layer.cornerRadius = 5.0;
//    [self addSubview:comBtn];
//    
//    UIButton *cancelBtn = [[UIButton alloc]init];
//    cancelBtn.frame = CGRectMake(10, (iPhone5?568:480) - 65, 300, 55);
//    cancelBtn.backgroundColor = [UIColor whiteColor];
////    cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
//    cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cancelBtn.layer.borderWidth = 1;
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:25];
//    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    cancelBtn.layer.cornerRadius = 5.0;
//    [cancelBtn addTarget: self action: @selector(cancalbClicked) forControlEvents: UIControlEventTouchUpInside];
//    [self addSubview:cancelBtn];
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.frame = CGRectMake(0, 0, 160, 110);
    
    self.pickerView.dataSource = self;   //这个不用说了瑟
    
    self.pickerView.delegate = self;       //这个不用说了瑟
    
    self.pickerView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
    
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int time=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *t=[cal components:time fromDate:now];
    [self.pickerView selectRow:t.year inComponent:0 animated:NO];
    [self.pickerView selectRow:t.month inComponent:1 animated:NO];
//    [self.pickerView selectRow:t.hour inComponent:2 animated:NO];
    
    [pBgV addSubview:self.pickerView];
}

#pragma mark -

#pragma mark UIPickerViewDataSource



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{

    return 2;     //这个picker里的组键数

}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component == 0) {
        return 16384;  //数组个数
    }
    else{
        return 16384;  //数组个数
    }

}

#pragma mark -

#pragma mark UIPickerViewDelegate



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [self.pickerArray1 objectAtIndex:(row%self.pickerArray1.count)];
        
        myView.font = [UIFont systemFontOfSize:20];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else if(component == 1){
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.text = [self.pickerArray2 objectAtIndex:(row%self.pickerArray2.count)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:20];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
//    else{
//        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
//        
//        myView.text = [self.pickerArray3 objectAtIndex:(row%self.pickerArray3.count)];
//        
//        myView.textAlignment = NSTextAlignmentCenter;
//        
//        myView.font = [UIFont systemFontOfSize:25];
//        
//        myView.backgroundColor = [UIColor clearColor];
//    }
    
    return myView;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

//    if (component == 1) {
//        switch (row%12) {
//            case 0:case 2:case 4:case 6:case 7:case 9:case 11:
//            {
//                [self.pickerArray3 removeAllObjects];
//                for (int i = 1; i < 32; i++) {
//                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%d",i]];
//                }
//            }
//                break;
//            case 3:case 5:case 8:case 10:
//            {
//                [self.pickerArray3 removeAllObjects];
//                for (int i = 1; i < 31; i++) {
//                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%d",i]];
//                }
//            }
//                break;
//            case 1:
//            {
//                [self.pickerArray3 removeAllObjects];
//                for (int i = 1; i < 29; i++) {
//                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%d",i]];
//                }
//            }
//                break;
//                
//            default:
//                break;
//        }
//        [self.pickerView reloadComponent:2];
//    }
//    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    
    if (component == 0)
        
        componentWidth = 80.0; // 第一个组键的宽度
    
    else
        
        componentWidth = 80.0; // 第2个组键的宽度
    
    
    
    return componentWidth;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 30.0;
    
}

#pragma btnClick
-(void)cancalbClicked{
    [self.delegate2 hjhTimeCancalbClicked];
}

-(void)quebClicked{
    NSInteger provinceIndex = [self.pickerView selectedRowInComponent: 0];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent: 1];
    
    NSString *provinceStr = [self.pickerArray1 objectAtIndex: provinceIndex%24];
    NSString *cityStr = [self.pickerArray2 objectAtIndex: cityIndex%60];

    
    NSString *showMsg = [NSString stringWithFormat: @"%@:%@", provinceStr, cityStr];
    
    [self.delegate2 hjhTimeGetDifang:showMsg];
}
@end
