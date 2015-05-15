//
//  Tab4_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab4_insertFirstTabVC.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#import "PICircularProgressView.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab4_insertFirstTabVC ()<KGSelectDateViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;

@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;

@property(nonatomic,strong)NSString *getDataTime;
@property(nonatomic,strong)PICircularProgressView *cpV;

@property(nonatomic,strong)HJHMyImageView *footImageView;
@end

@implementation Tab4_insertFirstTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyClassWithGradeSuccess:) name:@"getInspectionDailyClassWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyClassWithGradeFail:) name:@"getInspectionDailyClassWithGradeFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.fisrtXiangQingArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet getInspectionDailyClassWithGradeWithMsgDate:self.getDataTime classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]];
    
}

#pragma mark -logic data
-(void)getInspectionDailyClassWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
        [self._tableView reloadData];
    }
    //************************
}

-(void)getInspectionDailyClassWithGradeFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMainImageView];
    [self setMainTableView];
    
    NSDate *date = [NSDate date];
    NSString *string = [date description];
    NSArray *array = [string componentsSeparatedByString:@" "];
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:[array objectAtIndex:0]]];
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 568 - 218) style:UITableViewStylePlain];
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, 60, ScreenWidth, 568 - 218 - 88);
    }
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.bounces = NO;
//    self._tableView.tableHeaderView = self.timeImageView;
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.timeImageView = [[KGSelectDateView alloc]initWithDateChanegSize:1];
    self.timeImageView.delegate2 = self;
    //    self.timeImageView.frame = CGRectMake(0, 0, ScreenWidth, 198 + 60);
    [self.view addSubview:self.timeImageView];
    self.footImageView = [[HJHMyImageView alloc]init];
    [self.view addSubview:self.footImageView];
}

#pragma mark - btnClick

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    if(indexPath.row == 0){
        self.cpV = [[PICircularProgressView alloc]init];
        self.cpV.frame = CGRectMake(10, 65, 120, 120);
        [cell addSubview:self.cpV];
        self.cpV.progress = 0;
        
        HJHMyButton *firsttimeBtn = [[HJHMyButton alloc]init];
        firsttimeBtn.frame = CGRectMake(100, 10, 80, 35);
        [firsttimeBtn setTitle:@"出勤情况" forState:UIControlStateNormal];
        [firsttimeBtn setBackgroundColor:[UIColor colorWithHexString:@"#89D3E9"]];
        firsttimeBtn.layer.cornerRadius = 5;
        [cell addSubview:firsttimeBtn];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
        label1.text = @"总计0人，出勤率0%";
        label1.font = [UIFont systemFontOfSize:16];
        label1.frame = CGRectMake(140, 65, 160, 20);
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = [UIColor blackColor];
        [cell addSubview:label1];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"出勤0";
        label2.font = [UIFont systemFontOfSize:16];
        label2.frame = CGRectMake(165, 90, 160, 20);
        label2.textAlignment = NSTextAlignmentLeft;
        label2.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"事假0";
        label3.font = [UIFont systemFontOfSize:16];
        label3.frame = CGRectMake(165, 115, 160, 20);
        label3.textAlignment = NSTextAlignmentLeft;
        label3.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label3];
        
        HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
        label4.text = @"病假0";
        label4.font = [UIFont systemFontOfSize:16];
        label4.frame = CGRectMake(165, 140, 160, 20);
        label4.textAlignment = NSTextAlignmentLeft;
        label4.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label4];
        
        HJHMyLabel *label5 = [[HJHMyLabel alloc]init];
        label5.text = @"缺勤0";
        label5.font = [UIFont systemFontOfSize:16];
        label5.frame = CGRectMake(165, 165, 160, 20);
        label5.textAlignment = NSTextAlignmentLeft;
        label5.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label5];
    }
    else{
        self.cpV = [[PICircularProgressView alloc]init];
        self.cpV.frame = CGRectMake(10, 65, 120, 120);
        [cell addSubview:self.cpV];
        self.cpV.progress = 0;
        
        HJHMyButton *firsttimeBtn = [[HJHMyButton alloc]init];
        firsttimeBtn.frame = CGRectMake(100, 10, 80, 35);
        [firsttimeBtn setTitle:@"晨检情况" forState:UIControlStateNormal];
        [firsttimeBtn setBackgroundColor:[UIColor colorWithHexString:@"#7FC369"]];
        firsttimeBtn.layer.cornerRadius = 5;
        [cell addSubview:firsttimeBtn];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
        label1.text = @"晨检0人，未晨检0人";
        label1.font = [UIFont systemFontOfSize:16];
        label1.frame = CGRectMake(140, 65, 160, 20);
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = [UIColor blackColor];
        [cell addSubview:label1];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"健康正常0";
        label2.font = [UIFont systemFontOfSize:16];
        label2.frame = CGRectMake(165, 90, 160, 20);
        label2.textAlignment = NSTextAlignmentLeft;
        label2.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"重点观察0";
        label3.font = [UIFont systemFontOfSize:16];
        label3.frame = CGRectMake(165, 115, 160, 20);
        label3.textAlignment = NSTextAlignmentLeft;
        label3.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label3];
        
        HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
        label4.text = @"家长带回0";
        label4.font = [UIFont systemFontOfSize:16];
        label4.frame = CGRectMake(165, 140, 160, 20);
        label4.textAlignment = NSTextAlignmentLeft;
        label4.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label4];
        
        HJHMyLabel *label5 = [[HJHMyLabel alloc]init];
        label5.text = @"未晨检0";
        label5.font = [UIFont systemFontOfSize:16];
        label5.frame = CGRectMake(165, 165, 160, 20);
        label5.textAlignment = NSTextAlignmentLeft;
        label5.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:label5];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
-(void)changeDateWithStartDate:(NSString *)startDate endDate:(NSString *)endDate{
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:endDate]];
    [self getData];
}
@end
