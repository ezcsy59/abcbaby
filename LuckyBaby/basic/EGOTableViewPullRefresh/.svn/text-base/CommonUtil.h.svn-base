//
//  CommonUtil.h
//  TalkBar
//
//  Created by huang on 13-8-2.
//  Copyright (c) 2013年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define aMinute 60
#define aHour 3600
#define aDay 86400
#define aMonth aDay*30

#define MinuteFormate(x) [NSString stringWithFormat:@"%ld分钟前",x]
#define HourFormate(x) [NSString stringWithFormat:@"%ld小时前",x]
#define DayFormate(x) [NSString stringWithFormat:@"%ld天前",x]
#define Yesterday @"昨天"
#define BeforeDay @"前天"
#define Justnow @"刚刚"
#define SimpleDateToDay @"yyyy.MM.dd"//默认格式 具体到日
#define SimpleDay @"dd"
@interface CommonUtil : NSObject

// 计算从1970到现在的时间
+(long long)getTimeSince1970;

+(NSString*)convertDateFormate:(long long)date;
+(NSString*)stringWithDateFormat:(NSString*)dateFormat FromDate:(NSDate*)date;

//计算iSO8601标准时间
+(NSInteger)convertTime:(NSString*)timeString;

+(NSString*)convertTimeDate:(NSString*)timeString;



//导航推出动画
+(void)doNavigationPushAnimation:(UINavigationController*)nav;
//导航推出
+(void)navigationPushWithAnimation:(UIViewController*)vc;

//导航栏向上弹出动画
+(void)navigationPushTopWithAnimation:(UIViewController*)vc;

//导航栏向下弹出动画
+(void)navigationPushDownWithAnimation:(UIViewController*)vc;

+(void)doNavigationPopAnimation:(UINavigationController*)nav;

////计算内嵌时间
//+(NSInteger)conVertInternalTime:(NSString*)internalTimeStirng;

//+(UITextField *)getTextField:(CGRect)thisframe andTextFieldKeyBordType:(TextFieldType)KeyBordType andTextFieldReturnKeyType:(TextFieldType)ReturnKeyType;
//+(UIButton *)getUIButtonWithFrame:(CGRect)thisFrame andTitle:(NSString *)title andBtnType:(BtnType)Type;
+(NSString *)getErroStringForErroCode:(int )erroCode;

//+(NSURL *)getImagePath:(NSString *)keyPath;
//是否有耳机
+ (BOOL)isHeadphone;
@end
