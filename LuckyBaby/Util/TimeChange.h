//
//  TimeChange.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeChange : NSObject
+(NSString*)timeChage:(NSString*)time;

+(NSString*)timeChage2:(NSString*)time;

+(NSString *) compareCurrentTime:(NSDate*) compareDate;

+(NSString *) compareTowTime:(NSDate*) compareDate andTime2:(NSDate *) compareDate2;

+(NSDictionary*)getWeekday:(NSString*)string;

+(NSString*)getLastday:(NSString*)string;

+(NSString*)getNextday:(NSString*)string;

+(NSString *)getNextMonth:(NSString *)string;

+(NSString *)getLastMonth:(NSString *)string;

+(NSString *)getNextWeek:(NSString *)string;

+(NSString *)getLastWeek:(NSString *)string;
@end
