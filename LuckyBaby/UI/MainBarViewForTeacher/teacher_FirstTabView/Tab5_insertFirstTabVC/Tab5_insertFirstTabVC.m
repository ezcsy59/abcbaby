//
//  Tab5_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab5_insertFirstTabVC.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab5_insertFirstTabVC ()<KGSelectDateViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;

@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;

@property(nonatomic,strong)NSString *getDataTime;

@property(nonatomic,strong)HJHMyImageView *footImageView;
@end

@implementation Tab5_insertFirstTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listChildOffApplyWithGradeSuccess:) name:@"listChildOffApplyWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listChildOffApplyWithGradeFail:) name:@"listChildOffApplyWithGradeFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(approveChildOffApplyWithGradeSuccess:) name:@"approveChildOffApplyWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listChildOffApplyWithGradeFail:) name:@"approveChildOffApplyWithGradeFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.fisrtXiangQingArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet listChildOffApplyWithGradeWithMsgDate:self.getDataTime classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]];
    
}

#pragma mark -logic data
-(void)listChildOffApplyWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
        [self._tableView reloadData];
    }
    //************************
}

-(void)listChildOffApplyWithGradeFail:(NSNotification*)noti{
    
}

-(void)approveChildOffApplyWithGradeSuccess:(NSNotification*)noti{
    [self getData];
    //************************
}

-(void)approveChildOffApplyWithGradeFail:(NSNotification*)noti{
    
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
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 568 - 218) style:UITableViewStylePlain];
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, 60, ScreenWidth, 568 - 218 - 88);
    }
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
//    self._tableView.tableHeaderView = self.timeImageView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.timeImageView = [[KGSelectDateView alloc]initWithDateChanegSize:1];
    self.timeImageView.delegate2 = self;
    [self.view addSubview:self.timeImageView];
    //    self.timeImageView.frame = CGRectMake(0, 0, ScreenWidth, 198 + 60);
    
    self.footImageView = [[HJHMyImageView alloc]init];
    [self.view addSubview:self.footImageView];
}

#pragma mark - btnClick
-(void)qingjiaQueRen:(HJHMyButton*)btn{
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dict = [self.fisrtXiangQingArray objectAtIndex:btn.tag];
    [tNet approveChildOffApplyWithGradeWithMsgDate:self.getDataTime applyId:[DictionaryStringTool stringFromDictionary:dict forKey:@"applyId"]];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fisrtXiangQingArray.count;
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
    NSDictionary *dic = [self.fisrtXiangQingArray objectAtIndex:indexPath.row];
    
    HJHMyImageView *leftImage = [[HJHMyImageView alloc]init];
    leftImage.backgroundColor = [UIColor clearColor];
    [leftImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"]] placeholderImage:nil];
    leftImage.clipsToBounds = YES;
    leftImage.userInteractionEnabled = NO;
    leftImage.frame = CGRectMake(10, 10, 60, 60);
    leftImage.layer.cornerRadius = 30;
    leftImage.layer.borderColor = [UIColor colorWithHexString:@"#7DCAE6"].CGColor;
    leftImage.layer.borderWidth = 2;
    [cell addSubview:leftImage];
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    NSString *string;
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"offType"] integerValue] == 1) {
        string = @"事假";
    }
    else if([[DictionaryStringTool stringFromDictionary:dic forKey:@"offType"] integerValue] == 2){
        string = @"病假";
    }
    else{
        string = @"其他";
    }
    label1.text = [NSString stringWithFormat:@"%@",[DictionaryStringTool stringFromDictionary:dic forKey:@"childName"]];
    label1.font = [UIFont systemFontOfSize:20];
    label1.frame = CGRectMake(80, 10, 200, 20);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor blackColor];
    [cell addSubview:label1];
    
    NSString *time = [DictionaryStringTool stringFromDictionary:dic forKey:@"offDateStart"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:(time.length - 3)]];
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    time = [array objectAtIndex:0];
    
    NSString *time2 = [DictionaryStringTool stringFromDictionary:dic forKey:@"offDateEnd"];
    if (time2.length >= 3) {
        time2 = [TimeChange timeChage:[time2 substringToIndex:(time2.length - 3)]];
    }
    NSArray *array2 = [time2 componentsSeparatedByString:@" "];
    time2 = [array2 objectAtIndex:0];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    label2.text = [NSString stringWithFormat:@"类型:%@",string];
    label2.font = [UIFont systemFontOfSize:14];
    label2.frame = CGRectMake(80, 10 + 23, 200, 20);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label2];
    
    HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
    label3.text = [NSString stringWithFormat:@"日期:%@至%@",time,time2];
    label3.font = [UIFont systemFontOfSize:14];
    label3.frame = CGRectMake(80, 10 + 23*2, 200, 20);
    label3.textAlignment = NSTextAlignmentLeft;
    label3.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label3];
    
    HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
    label4.text = [NSString stringWithFormat:@"原因:%@",[DictionaryStringTool stringFromDictionary:dic forKey:@"offReason"]];
    label4.font = [UIFont systemFontOfSize:14];
    label4.frame = CGRectMake(80, 10 + 23*3, 200, 20);
    label4.textAlignment = NSTextAlignmentLeft;
    label4.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label4];
    
    HJHMyButton *firsttimeBtn = [[HJHMyButton alloc]init];
    firsttimeBtn.frame = CGRectMake(240, 10, 60, 30);
    [firsttimeBtn setTitle:@"出勤情况" forState:UIControlStateNormal];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"readDatetime"]integerValue] != 0) {
        [firsttimeBtn setBackgroundColor:[UIColor colorWithHexString:@"666666"]];
        [firsttimeBtn setTitle:@"已确认" forState:UIControlStateNormal];
        firsttimeBtn.userInteractionEnabled = NO;
    }
    else{
        [firsttimeBtn setBackgroundColor:[UIColor colorWithHexString:@"7DCAE6"]];
        [firsttimeBtn setTitle:@"确认" forState:UIControlStateNormal];
        firsttimeBtn.userInteractionEnabled = YES;
        firsttimeBtn.tag = indexPath.row;
        [firsttimeBtn addTarget:self action:@selector(qingjiaQueRen:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    firsttimeBtn.layer.cornerRadius = 5;
    [cell addSubview:firsttimeBtn];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 99, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
