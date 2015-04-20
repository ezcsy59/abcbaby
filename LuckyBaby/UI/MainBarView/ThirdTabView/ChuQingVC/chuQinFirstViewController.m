//
//  chuQinFirstViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "chuQinFirstViewController.h"
#import "KGCalendarView.h"
#import "CLMView.h"
#import "youErYuanNetWork.h"
#import "selectDateViewController.h"

@interface chuQinFirstViewController ()<KGCalendarViewDelegate>
@property(nonatomic,strong) UIScrollView *srollV;
@end

@implementation chuQinFirstViewController

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *useD = [NSUserDefaults standardUserDefaults];
    NSString *string = [useD objectForKey:@"firstIn"];
    if ([string isKindOfClass:[NSString class]]) {
        if (![string isEqualToString:@"1"]) {
            [useD setValue:@"1" forKey:@"firstIn"];
            [useD synchronize];
            [self getData];
        }
        else{
            [useD setValue:@"0" forKey:@"firstIn"];
            [useD synchronize];
        }
    }
    else{
        [useD setValue:@"1" forKey:@"firstIn"];
        [useD synchronize];
        [self getData];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSemesterExceptionSuccess:) name:@"getSemesterExceptionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSemesterExceptionFail:) name:@"getSemesterExceptionFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults *useD = [NSUserDefaults standardUserDefaults];
    [useD setValue:@"0" forKey:@"firstIn"];
    [useD synchronize];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youE getSemesterExceptionWithPlatformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] dateStart:@"" dateEnd:@""];
}

-(void)getSemesterExceptionSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    
    
}

-(void)getSemesterExceptionFail:(NSNotification*)noti{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithHexString:@"f1f1f1"];
    self.srollV = [[UIScrollView alloc]init];
    self.srollV.frame = CGRectMake(0, 0, 320, (iPhone5?568:480) - 60);
    [self.srollV setContentSize:CGSizeMake(320, 568 - 60)];
    self.srollV.showsHorizontalScrollIndicator = NO;
    self.srollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.srollV];
    
    [self setPingTu];
    
    [self addBreakLink];
    
    [self performSelector:@selector(setMainView) withObject:nil afterDelay:0.5];
    
    
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    KGCalendarView *kVC = [[KGCalendarView alloc]initWithFrame:self.view.frame];
    kVC.delegate2 = self;
    [self.srollV addSubview:kVC];
}

-(void)addBreakLink{
    HJHMyImageView *breakLine = [[HJHMyImageView alloc]init];
    breakLine.frame = CGRectMake(0, 295, 320, 1);
    breakLine.backgroundColor = [UIColor colorWithHexString:@"4DD0C8"];
    [self.srollV addSubview:breakLine];
}

-(void)setPingTu{
    CLMView *cv = [[CLMView alloc] initWithFrame:CGRectMake(-30, 150, 320, 480)];
    cv.titleArr = [NSArray	arrayWithObjects:@"出勤12天", @"事假0天", @"病假0天",nil];
    cv.valueArr = [NSArray arrayWithObjects:[NSNumber numberWithFloat:70],[NSNumber numberWithFloat:20],\
                   [NSNumber numberWithFloat:10],nil];
    cv.colorArr = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"4DD0C8"], [UIColor colorWithHexString:@"F08221"], [UIColor colorWithHexString:@"D1D1D1"],nil];
    
    [self.srollV addSubview: cv];
    
    HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(28, 410, 300, 20)];
    zuijinLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    zuijinLabel.text = @"出勤率100.00%";
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:15];
    [self.srollV addSubview:zuijinLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - KGCalendarViewDelegate
-(void)SelectDate:(NSDate *)date{
    selectDateViewController *sVC = [[selectDateViewController alloc]init];
    [self.navigationController pushViewController:sVC animated:YES];
}

@end
