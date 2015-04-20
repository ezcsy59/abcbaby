//
//  SY_DateViewController.m
//  SY_Date
//
//  Created by 孙悦 on 14-2-7.
//  Copyright (c) 2014年 孙悦. All rights reserved.
//

#import "SY_DateViewController.h"

@interface SY_DateViewController ()

@end

@implementation SY_DateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"工作计划";
    self.view.backgroundColor = [UIColor whiteColor];
    _mmMainFX = self.view.bounds.origin.x;
    _mmMainFY = [[UIBaseClass shareInstance] getViewFramOY];
    
    _scrollDate = 0;
    _btnDate = 0;
    
    [self initBase];
    
    [self initView];
    [self initDateView];
    
    [self initSwipeGestureRecognizerLeft];
    [self initSwipeGestureRecognizerRight];
    [self initSwipeGestureRecognizerLeft2];
    [self initSwipeGestureRecognizerRight2];
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[NSDate date]];
    //    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    
    
    [self httpFuction];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    if ([self.delegate2 respondsToSelector:@selector(swipReturnDate1:date2:)]) {
        [self.delegate2 swipReturnDate1:_timeString date2:[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]]];
    }
}

-(void)initBase
{
    _btnArray = [[NSMutableArray alloc]init];
    _changeBtnArrayR = [[NSMutableArray alloc]init];
    _changeBtnArrayL = [[NSMutableArray alloc]init];
    
    _changeWeek = 0;
    _btnSelectDate = 0;
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, 320, 40)];
    _dateView.backgroundColor = [UIColor clearColor];
    _changeDateR = [[UIView alloc]initWithFrame:CGRectMake(320, 48, 320, 40)];
    _changeDateL = [[UIView alloc]initWithFrame:CGRectMake(-320, 48, 320, 40)];
    _workView = [[UIView alloc]initWithFrame:CGRectMake(0, 146, 320, 460)];
    _changeWorkR = [[UIView alloc]initWithFrame:CGRectMake(320, 146, 320, 460)];
    _changeWorkL = [[UIView alloc]initWithFrame:CGRectMake(-320, 146, 320, 460)];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(320, iPhone5?0:500);
    //    _scrollView.pagingEnabled = YES;
    //    _scrollView.userInteractionEnabled = YES; // 是否滑动
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    _vFX = _mmMainFX;
    _vFY = _mmMainFY + 40;
    
    UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 1)];
    line1.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + 55;
    UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95, 320, 1)];
    line2.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + line2.frame.size.height + 12;
    dateLable = [[UILabel alloc]initWithFrame:CGRectMake(_vFX + 74, _vFY, 180, 15)];
    dateLable.text = _nowDateString;
    dateLable.font = [UIFont systemFontOfSize:15];
    dateLable.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    dateLable.backgroundColor = [UIColor clearColor];
    dateLable.center = CGPointMake(160, dateLable.center.y);
    dateLable.textAlignment = NSTextAlignmentCenter;
    
    _vFX = _vFX + 0;
    _vFY = _vFY + dateLable.frame.size.height + 12;
    UIImageView* line3 = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 1)];
    line3.image = [UIImage imageNamed:@"infoLine-200-1"];
    

    //btn Target
    
    [_scrollView addSubview:line1];
    [_scrollView addSubview:line2];
    [_scrollView addSubview:dateLable];
    [_scrollView addSubview:line3];
    
    /*
     重写主页webView
     */
    
//    [_scrollView addSubview:_changeWorkL];
//    [_scrollView addSubview:_changeWorkR];
    [_scrollView addSubview:_workView];
}

-(void)workViewR
{
    /*
     重写右view
     */
    
    [_scrollView addSubview:_changeWorkR];
}
-(void)workViewL
{
    /*
     重写左view
     */
    
    [_scrollView addSubview:_changeWorkL];
}

#pragma mark-
#pragma mark Push
-(void)pushBS
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushBP
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushBMI
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushAppoint
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushHealth
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushManage
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark-
#pragma mark Date
-(void)initDateView
{
    for (int i = 0; i < 7; i++)
    {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(320/7*i, 13, 320/7, 15)];
        lab.font = [UIFont boldSystemFontOfSize:15];
        lab.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        lab.backgroundColor = [UIColor clearColor];
        NSString* week;
        switch (i) {
            case 0:{
                week=@"日";
                break;
            }
            case 1:{
                week=@"一";
                break;
            }
            case 2:{
                week=@"二";
                break;
            }
            case 3:{
                week=@"三";
                break;
            }
            case 4:{
                week=@"四";
                break;
            }
            case 5:{
                week=@"五";
                break;
            }
            case 6:{
                week=@"六";
                break;
            }
                
                
            default:
                break;
        }
        lab.text = [NSString stringWithFormat:@"%@",week];
        lab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:lab];
    }
    
    NSMutableArray* tempArr = [self switchDay];
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
//            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            lab.tag = 0;
            _btnSelectDate = i;
        }
        [_btnArray addObject:lab];
        [_dateView addSubview:lab];
    }
    //设置tag
    for (int i = 0; i < _btnSelectDate; i++)
    {
        int tagInt = i - _btnSelectDate;
        UIButton* tempBtn = [_btnArray objectAtIndex:i];
        tempBtn.tag = tagInt;
    }
    for (int i = 1; i < 7 - _btnSelectDate; i++)
    {
        int tagInt = i;
        UIButton* tempBtn = [_btnArray objectAtIndex:_btnSelectDate + i];
        tempBtn.tag = tagInt;
    }
    
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
//            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayR addObject:lab];
        [_changeDateR addSubview:lab];
    }
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
//            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayL addObject:lab];
        [_changeDateL addSubview:lab];
    }
    
    [_scrollView addSubview:_changeDateR];
    [_scrollView addSubview:_changeDateL];
    [_scrollView addSubview:_dateView];
}

-(NSMutableArray*)switchDay
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    switch ([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]]) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
    
    NSLog(@"%d , %d", head, foot);
    
    //    NSLog(@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:-1]]);
    
    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:i]]];
        [array addObject:str];
    }
    
    [array addObject:[NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:0]]]];
    
    //sy 添加日期
    int tempNum = 1;
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:tempNum]]];
        [array addObject:str];
        tempNum++;
    }
    
    NSLog(@"weekArray = %d", [array count]);
    
    return array;
}

-(NSInteger)weekDate:(NSDate*)date
{
    // 获取当前年月日和周几
    //    NSDate *_date=[NSDate date];
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    
    //    _scrollDate
    //    + (NSInteger)getMonthWithDate:(NSDate*)date;
    //    + (NSInteger)getDayWithDate:(NSDate*)date;
    //    + (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval;
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateStr = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    
//    _nowDateString = [[NSString alloc]initWithFormat:@"%@ 星期%@", dateStr, _dayNum];
    _nowDateString = [[NSString alloc]initWithFormat:@"%@", dateStr];
    dateLable.text = _nowDateString;
    NSLog(@"week = %@", _dayNum);
    
    return dayInt;
}

-(void)selectData:(id)sender
{
    UIButton* sendBtn = sender;
    NSLog(@"btn = %@", sendBtn.titleLabel.text);
    NSLog(@"btn.tag = %d", sendBtn.tag);
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if ([tmpBtn.titleLabel.text isEqualToString:sendBtn.titleLabel.text])
        {
//            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
    if ([sendBtn.titleLabel.text isEqualToString:@"29"])
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    else
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    
    
    _btnDate = sendBtn.tag;
    
    //按日期确定星期
    
    [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
    
    NSLog(@"%@",_nowDateString);
    
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]]; // _scrollDate
    
    if ([self.delegate2 respondsToSelector:@selector(selectDatedWithTag:)]) {
        [self.delegate2 selectDatedWithTag:sendBtn.tag];
    }
    [self httpFuction];
}

#pragma mark -
#pragma mark setButtonTitle
-(void)setBtnTitle  // 修改Btn的日期
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
    }
}
-(void)setBtnTitleR
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    for (int i = 0; i < [_changeBtnArrayR count]; i++)
    {
        [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayR objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
//            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}
-(void)setBtnTitleL
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    for (int i = 0; i < [_changeBtnArrayL count]; i++)
    {
        [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayL objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
//            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}

#pragma mark -
#pragma mark UISwipeGestureRecognizer
-(void)initSwipeGestureRecognizerLeft
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerLeft2
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_workView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerRight
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerRight2
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [_workView addGestureRecognizer:oneFingerSwipeUp];
}

- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate += 7;
    
    _changeWeek += 7;
    [self setBtnTitleR];
    [self workViewR];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
//    NSString* scollTime = [scDateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
//    [self timeHidenButton:scollTime];
    
    CGRect oldFrame = _dateView.frame;
    CGRect oldFrameWork = _workView.frame;
    CGRect changeFrameDate = _changeDateR.frame;
    CGRect changeFrameWork = _changeWorkR.frame;
    
    [UIView animateWithDuration:0.75f
                            delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                    UIViewAnimationOptionBeginFromCurrentState)
                        animations:^(void) {
                            [_dateView setFrame:CGRectMake(-320, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(-320, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateR setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                            [_changeWorkR setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                        }
                        completion:^(BOOL finished) {
                            [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateR setFrame:changeFrameDate];
                            [_changeWorkR setFrame:changeFrameWork];
                            [self setBtnTitle];
                            [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];

                            NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                            [dateformat setDateFormat:@"yyyyMMdd"];
                            _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
                            if ([self.delegate2 respondsToSelector:@selector(swipReturnDate1:date2:)]) {
                                [self.delegate2 swipReturnDate1:[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]] date2:[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]]];
                            }
                            [self httpFuction];
                            
                        }];
    
}
- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate -= 7;
    
    _changeWeek -= 7;
    //    [self setBtnTitle];
    [self setBtnTitleL];
    [self workViewL];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
//    NSString* scollTime = [scDateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
//    [self timeHidenButton:scollTime];
    
    
    CGRect oldFrame = _dateView.frame;
    CGRect oldFrameWork = _workView.frame;
    CGRect changeFrameDate = _changeDateL.frame;
    CGRect changeFrameWork = _changeWorkL.frame;
    
    [UIView animateWithDuration:0.75f
                            delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                    UIViewAnimationOptionBeginFromCurrentState)
                        animations:^(void) {
                            [_dateView setFrame:CGRectMake(320, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(320, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateL setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                            [_changeWorkL setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                        }
                        completion:^(BOOL finished) {
                            [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateL setFrame:changeFrameDate];
                            [_changeWorkL setFrame:changeFrameWork];
                            [self setBtnTitle];
                            [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];

                            NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                            [dateformat setDateFormat:@"yyyyMMdd"];
                            _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
                            NSLog(@"%@,%@",[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]],[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]]);
                            if ([self.delegate2 respondsToSelector:@selector(swipReturnDate1:date2:)]) {
                                [self.delegate2 swipReturnDate1:[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]] date2:[dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]]];
                            }

                            [self httpFuction];

                        }];
    
}


#pragma mark -
#pragma mark TimeHidenButton

-(void)timeHidenButton:(NSString*)timeStr
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    NSString* nowTimeStr = [dateformat stringFromDate:[NSDate date]];
    int nowTime = [nowTimeStr integerValue];
    int selectTime = [timeStr integerValue];
    
    if (selectTime > nowTime)
    {
        [_workView setFrame:CGRectMake(0, 146 - 61*3, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146 - 61*3, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146 - 61*3, 320, 460)];
    }
    else
    {
        [_workView setFrame:CGRectMake(0, 146, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146, 320, 460)];
    }
}



#pragma mark -
#pragma mark request delegate

-(void)httpFuction
{
    NSLog(@"%s",__FUNCTION__);
}

@end
