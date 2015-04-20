//
//  KGCalendarView.m
//  KGCalendarView
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "KGCalendarView.h"
#import "NSDate+FSExtension.h"

#define kPink [UIColor colorWithRed:198/255.0 green:51/255.0 blue:42/255.0 alpha:1.0]
#define kBlue [UIColor colorWithRed:31/255.0 green:119/255.0 blue:219/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]

@interface KGCalendarView ()

@property (strong, nonatomic) NSCalendar *currentCalendar;

@end

@implementation KGCalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setMainView];
    }
    return self;
}

-(void)setMainView{
    self.calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(10, 40, 300, 260)];
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    [self addSubview:self.calendar];
    
    self.currentCalendar = [NSCalendar currentCalendar];
    _flow = _calendar.flow;
    _firstWeekday = _calendar.firstWeekday;
}

#pragma mark - FSCalendarDataSource

- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
{
    if (!_lunar) {
        return nil;
    }
    return nil;
}

- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
{
//    return date.fs_day == 3;
    return NO;
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
//    BOOL shouldSelect = date.fs_day != 7;
//    if (!shouldSelect) {
//        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
//                                    message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]]
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil, nil] show];
//    }
//    return shouldSelect;
    [self.delegate2 SelectDate:date];
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to month %@",[calendar.currentMonth fs_stringWithFormat:@"MMMM yyyy"]);
}

#pragma mark - Setter

- (void)setTheme:(NSInteger)theme
{
    if (_theme != theme) {
        _theme = theme;
        switch (theme) {
            case 0:
            {
                [_calendar setWeekdayTextColor:kBlueText];
                [_calendar setHeaderTitleColor:kBlueText];
                [_calendar setEventColor:[kBlueText colorWithAlphaComponent:0.75]];
                [_calendar setSelectionColor:kBlue];
                [_calendar setHeaderDateFormat:@"MMMM yyyy"];
                [_calendar setMinDissolvedAlpha:0.2];
                [_calendar setTodayColor:kPink];
                [_calendar setCellStyle:FSCalendarCellStyleCircle];
                break;
            }
            case 1:
            {
                [_calendar setWeekdayTextColor:[UIColor redColor]];
                [_calendar setHeaderTitleColor:[UIColor darkGrayColor]];
                [_calendar setEventColor:[UIColor greenColor]];
                [_calendar setSelectionColor:[UIColor blueColor]];
                [_calendar setHeaderDateFormat:@"yyyy-MM"];
                [_calendar setMinDissolvedAlpha:1.0];
                [_calendar setTodayColor:[UIColor redColor]];
                [_calendar setCellStyle:FSCalendarCellStyleCircle];
                break;
            }
            case 2:
            {
                [_calendar setWeekdayTextColor:[UIColor redColor]];
                [_calendar setHeaderTitleColor:[UIColor redColor]];
                [_calendar setEventColor:[UIColor greenColor]];
                [_calendar setSelectionColor:[UIColor blueColor]];
                [_calendar setHeaderDateFormat:@"yyyy/MM"];
                [_calendar setMinDissolvedAlpha:1.0];
                [_calendar setCellStyle:FSCalendarCellStyleRectangle];
                [_calendar setTodayColor:[UIColor orangeColor]];
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)setLunar:(BOOL)lunar
{
    if (_lunar != lunar) {
        _lunar = lunar;
        [_calendar reloadData];
    }
}

- (void)setFlow:(FSCalendarFlow)flow
{
    if (_flow != flow) {
        _flow = flow;
        _calendar.flow = flow;
        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
                                    message:[NSString stringWithFormat:@"Now swipe %@",@[@"Vertically", @"Horizontally"][_calendar.flow]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _calendar.selectedDate = selectedDate;
}

- (void)setFirstWeekday:(NSUInteger)firstWeekday
{
    if (_firstWeekday != firstWeekday) {
        _firstWeekday = firstWeekday;
        _calendar.firstWeekday = firstWeekday;
    }
}

@end
