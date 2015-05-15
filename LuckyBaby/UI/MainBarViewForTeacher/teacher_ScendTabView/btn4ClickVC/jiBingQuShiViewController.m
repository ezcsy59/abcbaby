//
//  youerChuQInViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-26.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "jiBingQuShiViewController.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#import "PICircularProgressView.h"
#import "SHView2.h"
@interface jiBingQuShiViewController ()<KGSelectDateViewDelegate,PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;
@property(nonatomic,strong)NSString *getDataTime;

@property(nonatomic,strong)NSMutableArray *jibingListArray;
@end

@implementation jiBingQuShiViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyInspectionClassWeekSuccess:) name:@"listDutyInspectionClassWeekSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyInspectionClassWeekFail:) name:@"listDutyInspectionClassWeekFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSString *timeString = [self.getDataTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDictionary *timeDic = [TimeChange getWeekday:timeString];
    
    NSString *startDate = [DictionaryStringTool stringFromDictionary:timeDic forKey:@"firstDate"];
    NSString *endDate = [DictionaryStringTool stringFromDictionary:timeDic forKey:@"eightWeekDate"];
    
    if ([startDate isKindOfClass:[NSString class]]) {
        NSArray *array = [startDate componentsSeparatedByString:@" "];
        startDate = [array objectAtIndex:0];
        startDate = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:startDate]];
    }
    
    if ([endDate isKindOfClass:[NSString class]]) {
        NSArray *array = [endDate componentsSeparatedByString:@" "];
        endDate = [array objectAtIndex:0];
        endDate = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:endDate]];
    }
    
    self.jibingListArray = [NSMutableArray array];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    
    //设置timeView栏的text
    NSDictionary *dict = [plistDataManager getDataWithKey:teacher_loginList];
    NSString *time4 = [DictionaryStringTool stringFromDictionary:dict forKey:@"semesterDateStart"];
    if(time4.length >= 3){
        time4 = [TimeChange timeChage:[time4 substringToIndex:time4.length - 3]];
    }
    NSArray *array2 = [time4 componentsSeparatedByString:@" "];
    time4 = [array2 objectAtIndex:0];
    
    NSString *time5 = startDate;
    if(time5.length >= 3){
        time5 = [TimeChange timeChage:[time5 substringToIndex:time5.length - 3]];
    }
    NSArray *array3 = [time5 componentsSeparatedByString:@" "];
    time5 = [array3 objectAtIndex:0];
    
    NSString *time6 = endDate;
    if(time6.length >= 3){
        time6 = [TimeChange timeChage:[time6 substringToIndex:time6.length - 3]];
    }
    NSArray *array4 = [time6 componentsSeparatedByString:@" "];
    time6 = [array4 objectAtIndex:0];
    
    NSLog(@"%@,%@,%@",time4,time5,time6);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [formatter dateFromString:time4];
    NSDate *datenow2 = [formatter dateFromString:time5];
    NSDate *datenow3 = [formatter dateFromString:time6];
    int day = [[TimeChange compareTowTime:datenow2 andTime2:datenow] integerValue];
    day = day/7 + 1;
    
    int day2 = [[TimeChange compareTowTime:datenow3 andTime2:datenow] integerValue];
    day2 = day2/7 + 1;
    
    self.timeImageView.timelabel.text = [NSString stringWithFormat:@"第%d周-第%d周 ",day,day2];
    
    [tNet listDutyInspectionClassWeekWithInspDateStart:startDate inspDateEnd:endDate platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
}

-(void)listDutyInspectionClassWeekSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if (arr.count > 0) {
        [self.jibingListArray removeAllObjects];
        for (int i = 1; i < 8; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [self.jibingListArray addObject:array];
        }
        int j = 1;
        for (NSDictionary *dic in arr) {
            for (int i = 1; i < 8; i++) {
                NSString *string = [NSString stringWithFormat:@"item%d",i];
                NSString *value = [DictionaryStringTool stringFromDictionary:dic forKey:string];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",value] floatValue]] forKey:[NSNumber numberWithInt:j]];
                [[self.jibingListArray objectAtIndex:i - 1] addObject:dict];
            }
            j++;
        }
        if (j < 10) {
            for (int i = j; i < 10; i++) {
                for (NSMutableArray *array in self.jibingListArray) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:@"0" forKey:[NSNumber numberWithInt:i]];
                    [array addObject:dict];
                }
            }
        }
        
    }
    [self._tableView reloadData];
}

-(void)listDutyInspectionClassWeekFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    NSDictionary *dict = [plistDataManager getDataWithKey:teacher_loginList];
    NSString *time3 = [DictionaryStringTool stringFromDictionary:dict forKey:@"semesterDateStart"];
    if(time3.length >= 3){
        time3 = [TimeChange timeChage:[time3 substringToIndex:time3.length - 3]];
    }
    NSArray *array = [time3 componentsSeparatedByString:@" "];
    time3 = [array objectAtIndex:0];
    NSLog(@"%@",time3);
    self.getDataTime = time3;
    
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"疾病趋势";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    
    [self setMainImageView];
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, [self getNavHight] + 60, ScreenWidth, (iPhone5?586:480) - [self getNavHight] - 60) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    //self._tableView.tableHeaderView = self.headerImageView;
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.timeImageView = [[KGSelectDateView alloc]initWithDateChanegSize:7];
    self.timeImageView.frame = CGRectMake(0, [self getNavHight], 320, 60);
    self.timeImageView.delegate2 = self;
    [self.view addSubview:self.timeImageView];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.jibingListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
    switch (indexPath.row) {
        case 0:
        {
            label3.text = @"发热";
        }
            break;
        case 1:
        {
            label3.text = @"咳嗽";
        }
            break;
        case 2:
        {
            label3.text = @"皮疹";
        }
            break;
        case 3:
        {
            label3.text = @"眼结膜充血";
        }
            break;
        case 4:
        {
            label3.text = @"腮腺肿大";
        }
            break;
        case 5:
        {
            label3.text = @"黄疸";
        }
            break;
        case 6:
        {
            label3.text = @"其他";
        }
            break;
            
        default:
            break;
    }
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:18];
    label3.frame = CGRectMake(0, 0, 320, 50);
    label3.textColor = [UIColor grayColor];
    [cell addSubview:label3];

    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[self.jibingListArray objectAtIndex:indexPath.row]];
    NSMutableArray *arrayX = [[NSMutableArray alloc]initWithArray:@[@{@1:@""},@{@2:@""},@{@3:@""},@{@4:@""},@{@5:@""},@{@6:@""},@{@7:@""},@{@8:@""}]];
    NSLog(@"%@",array);
    SHView2 *sV = [[SHView2 alloc]initWithFrame:CGRectZero andxAxisValues:arrayX plottingValues:array plottingPointsLabels:array];
    [cell addSubview:sV];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    HJHMyImageView *bgLayerImage = [[HJHMyImageView alloc]init];
    bgLayerImage.frame = CGRectMake(10, 10, 300, 180);
    bgLayerImage.backgroundColor = [UIColor clearColor];
    bgLayerImage.layer.cornerRadius = 5.0;
    bgLayerImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bgLayerImage.layer.borderWidth = 1;
    [cell addSubview:bgLayerImage];
    
    cell.userInteractionEnabled = YES;
    sV.userInteractionEnabled = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - pullTableViewDelegate


-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
}


-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    NSLog(@"hello");
    NSLog(@"%@",pullTableView);
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
}

-(void)refreshListDataBack{
    [self pullTableRefresh:(PullTableView*)self._tableView];
}

-(void)loadMoreListDataBack{
    [self pullTableViewLoadMore:(PullTableView*)self._tableView];
}

-(void)changeStyle{
    NSDate* date = [NSDate date];
    ((PullTableView*)self._tableView).pullLastRefreshDate = date;
    ((PullTableView*)self._tableView).pullTableIsRefreshing = NO;
    ((PullTableView*)self._tableView).pullTableIsLoadingMore = NO;
}

-(void)pullTableRefresh:(PullTableView*)pullTableView
{
    NSDate* date = [NSDate date];
    pullTableView.pullLastRefreshDate = date;
    pullTableView.pullTableIsRefreshing = NO;
    pullTableView.loadMoreView.isLoading = NO;
}

-(void)pullTableViewLoadMore:(PullTableView*)pullTableView
{
    NSDate* date = [NSDate date];
    pullTableView.pullLastRefreshDate = date;
    pullTableView.pullTableIsLoadingMore = NO;
    pullTableView.refreshView.isLoading = NO;
}

#pragma mark - KGSelectDateViewDelegate
-(void)changeDateWithStartDate:(NSString *)startDate endDate:(NSString *)endDate isLetfBtnClick:(BOOL)isLetfBtnClick{
    if (isLetfBtnClick) {
        self.getDataTime = [TimeChange getLastWeek:self.getDataTime];
    }
    else{
        self.getDataTime = [TimeChange getNextWeek:self.getDataTime];
    }
    [self getData];
}


@end
