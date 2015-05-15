//
//  TimeChange.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "TimeChange.h"

@implementation TimeChange
+(NSString*)timeChage:(NSString*)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    return confromTimespStr;
}

+(NSString*)timeChage2:(NSString*)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [formatter dateFromString:time];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) < 366){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    return  result;
}

+(NSString *) compareTowTime:(NSDate*) compareDate andTime2:(NSDate *) compareDate2
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceDate:compareDate2];
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) < 366){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    return  result;
}

+(NSDictionary*)getWeekday:(NSString*)string{
    NSString *mString = [string substringFromIndex:4];
    string = [TimeChange timeChage2:[NSString stringWithFormat:@"%@/%@/%@",[string substringToIndex:4],[mString substringToIndex:2],[mString substringFromIndex:2]]];
    NSDate *firstDate;
    NSDate *nextDate;
    NSDate *eightWeekDate;
    //获取日期
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    
    switch (week) {
        case 1:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+1];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-6];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+6 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 2:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:1];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+8];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:56 + 1];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 3:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+6];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-1];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+1 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 4:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+5];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-2];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+2 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 5:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+4];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-3];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+3 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 6:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+3];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-4];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+4 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
        case 7:
        {
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+2];
            nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:-5];
            firstDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:0];
            
            [adcomps setDay:+5 + 56];
            eightWeekDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        }
            break;
            
            
        default:
            break;
    }
    NSString *firstString = [NSString stringWithFormat:@"%@",firstDate];
    NSString *nextString = [NSString stringWithFormat:@"%@",nextDate];
    NSString *eightWeekString = [NSString stringWithFormat:@"%@",eightWeekDate];
    return @{@"firstDate":firstString,@"nextDate":nextString,@"eightWeekDate":eightWeekString};
}

+(NSString*)getNextday:(NSString*)string{
    string = [TimeChange timeChage2:string];
    NSDate *nextDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:+2];
    nextDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *nextString = [NSString stringWithFormat:@"%@",nextDate];
    NSArray *array = [nextString componentsSeparatedByString:@" "];
    nextString = [array objectAtIndex:0];
    return nextString;
}

+(NSString*)getLastday:(NSString*)string{
    string = [TimeChange timeChage2:string];
    NSDate *lastDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    lastDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *lastString = [NSString stringWithFormat:@"%@",lastDate];
    NSArray *array = [lastString componentsSeparatedByString:@" "];
    lastString = [array objectAtIndex:0];
    return lastString;
}

+(NSString *)getLastMonth:(NSString *)string{
    string = [TimeChange timeChage2:string];
    NSDate *lastDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];

    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    lastDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *lastString = [NSString stringWithFormat:@"%@",lastDate];
    NSArray *array = [lastString componentsSeparatedByString:@" "];
    lastString = [array objectAtIndex:0];
    return lastString;
}

+(NSString *)getNextMonth:(NSString *)string{
    string = [TimeChange timeChage2:string];
    NSDate *lastDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:1];
    
    [adcomps setDay:0];
    lastDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *lastString = [NSString stringWithFormat:@"%@",lastDate];
    NSArray *array = [lastString componentsSeparatedByString:@" "];
    lastString = [array objectAtIndex:0];
    return lastString;
}

+(NSString *)getLastWeek:(NSString *)string{
    string = [TimeChange timeChage2:string];
    NSDate *lastDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:-6];
    lastDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *lastString = [NSString stringWithFormat:@"%@",lastDate];
    NSArray *array = [lastString componentsSeparatedByString:@" "];
    lastString = [array objectAtIndex:0];
    return lastString;
}

+(NSString *)getNextWeek:(NSString *)string{
    string = [TimeChange timeChage2:string];
    NSDate *lastDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:8];
    lastDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *lastString = [NSString stringWithFormat:@"%@",lastDate];
    NSArray *array = [lastString componentsSeparatedByString:@" "];
    lastString = [array objectAtIndex:0];
    return lastString;
}
@end
