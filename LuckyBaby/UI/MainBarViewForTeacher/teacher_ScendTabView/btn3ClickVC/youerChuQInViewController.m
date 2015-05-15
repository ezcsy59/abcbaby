//
//  youerChuQInViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-26.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "youerChuQInViewController.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#import "PICircularProgressView.h"
@interface youerChuQInViewController ()<KGSelectDateViewDelegate,PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;
@property(nonatomic,strong)NSString *getDataTime;
@property(nonatomic,strong)NSString *getDataTimeAfterOneDay;
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)PICircularProgressView *cpV;

@property(nonatomic,strong)HJHMyButton *sSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_sSelectBtn;

@property(nonatomic,strong)HJHMyImageView *headerImageInsideStyleImageV1;
@property(nonatomic,strong)HJHMyImageView *headerImageInsideStyleImageV2;

@property(nonatomic,strong)NSArray *youerChuqinArray;
@end

@implementation youerChuQInViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSemesterExceptionSuccess:) name:@"getSemesterExceptionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSemesterExceptionWeekFail:) name:@"getSemesterExceptionWeekFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDutyInspectionClassSuccess:) name:@"getDutyInspectionClassSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDutyInspectionClassFail:) name:@"getDutyInspectionClassFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyPlatformSuccess:) name:@"getInspectionDailyPlatformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyPlatformFail:) name:@"getInspectionDailyPlatformFail" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.youerChuqinArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 0) {
        if (self.s_sSelectBtn.selected == NO) {
            [tNet getSemesterExceptionWithPlatformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] dateStart:self.getDataTime dateEnd:self.getDataTimeAfterOneDay];
        }
        else{
            [tNet getDutyInspectionClassWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] dateStart:self.getDataTime dateEnd:self.getDataTime];
        }
    }
    else{
        [tNet getInspectionDailyPlatformWithMsgDate:self.getDataTime platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
    }
}

#pragma mark -logic data
-(void)getSemesterExceptionSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.youerChuqinArray = [[NSMutableArray alloc]initWithArray:array];
    }
    [self._tableView reloadData];
    //************************
}

-(void)getSemesterExceptionWeekFail:(NSNotification*)noti{
    
}

-(void)getDutyInspectionClassSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.youerChuqinArray = [[NSMutableArray alloc]initWithArray:array];
    }
    [self._tableView reloadData];
    //************************
}

-(void)getDutyInspectionClassFail:(NSNotification*)noti{
    
}

-(void)getInspectionDailyPlatformSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.youerChuqinArray = [[NSMutableArray alloc]initWithArray:array];
    }
    [self._tableView reloadData];
    //************************
}

-(void)getInspectionDailyPlatformFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"幼儿出勤";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    
    
    [self setMainImageView];
    [self setMainTableView];
    
    NSDate *date = [NSDate date];
    NSString *string = [date description];
    NSArray *array = [string componentsSeparatedByString:@" "];
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:[array objectAtIndex:0]]];
    self.getDataTimeAfterOneDay = [NSString stringWithFormat:@"%@000",[TimeChange getNextday:[TimeChange timeChage2:[array objectAtIndex:0]]]];
    
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 0) {
        [self setHeadTapBar];
    }
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
    self._tableView.tableHeaderView = self.headerImageView;
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.timeImageView = [[KGSelectDateView alloc]initWithDateChanegSize:1];
    self.timeImageView.frame = CGRectMake(0, [self getNavHight], 320, 60);
    self.timeImageView.delegate2 = self;
    [self.view addSubview:self.timeImageView];
    
    self.headerImageView = [[HJHMyImageView alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 1) {
        self.headerImageView.frame = CGRectMake(0, 0, 320, 187);
        
        self.cpV = [[PICircularProgressView alloc]init];
        self.cpV.frame = CGRectMake(100, 10, 120, 120);
        [self.headerImageView addSubview:self.cpV];
        self.cpV.progress = 0;
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
        label1.text = @"月度出勤率";
        label1.font = [UIFont systemFontOfSize:20];
        label1.frame = CGRectMake(0, 160, 320, 20);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        [self.headerImageView addSubview:label1];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(15, 185, 290, 2);
        footImage.backgroundColor = [UIColor colorWithHexString:@"7FC369"];
        [self.headerImageView addSubview:footImage];
    }
    else{
        self.headerImageView.frame = CGRectMake(0, 0, 320, 50);
        
        self.headerImageInsideStyleImageV1 = [[HJHMyImageView alloc]init];
        self.headerImageInsideStyleImageV1.frame = self.headerImageView.bounds;
        [self.headerImageView addSubview:self.headerImageInsideStyleImageV1];
        for (int i = 0; i < 4; i++) {
            HJHMyLabel *label = [[HJHMyLabel alloc]init];
            label.frame = CGRectMake(80 * i, 0, 30, 50);
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            [self.headerImageInsideStyleImageV1 addSubview:label];
            
            HJHMyImageView *colorImage = [[HJHMyImageView alloc]init];
            colorImage.layer.cornerRadius = 5.0;
            colorImage.frame = CGRectMake(32 + 80 * i, 10, 45, 30);
            [self.headerImageInsideStyleImageV1 addSubview:colorImage];
            switch (i) {
                case 0:
                {
                    label.text = @"正常";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"75DC97"];
                }
                    break;
                case 1:
                {
                    label.text = @"事假";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"FEBF3E"];
                }
                    break;
                case 2:
                {
                    label.text = @"病假";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"FF9676"];
                }
                    break;
                case 3:
                {
                    label.text = @"缺勤";
                    colorImage.backgroundColor = [UIColor grayColor];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        self.headerImageInsideStyleImageV2 = [[HJHMyImageView alloc]init];
        self.headerImageInsideStyleImageV2.frame = self.headerImageView.bounds;
        self.headerImageInsideStyleImageV2.hidden = YES;
        [self.headerImageView addSubview:self.headerImageInsideStyleImageV2];
        for (int i = 0; i < 4; i++) {
            HJHMyLabel *label = [[HJHMyLabel alloc]init];
            label.frame = CGRectMake(80 * i, 0, 30, 50);
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 2;
            [self.headerImageInsideStyleImageV2 addSubview:label];
            
            HJHMyImageView *colorImage = [[HJHMyImageView alloc]init];
            colorImage.layer.cornerRadius = 5.0;
            colorImage.frame = CGRectMake(32 + 80 * i, 10, 45, 30);
            [self.headerImageInsideStyleImageV2 addSubview:colorImage];
            switch (i) {
                case 0:
                {
                    label.text = @"正常";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"75DC97"];
                }
                    break;
                case 1:
                {
                    label.text = @"重点观察";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"FEBF3E"];
                }
                    break;
                case 2:
                {
                    label.text = @"家长带回";
                    colorImage.backgroundColor = [UIColor colorWithHexString:@"FF9676"];
                }
                    break;
                case 3:
                {
                    label.text = @"未晨检";
                    colorImage.backgroundColor = [UIColor grayColor];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 49, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [self.headerImageView addSubview:footImage];
    }
}

-(void)setHeadTapBar{
    self.sSelectBtn = [[HJHMyButton alloc]init];
    self.sSelectBtn.frame = CGRectMake(0, [self getNavHight], 320/2, 40);
    [self.sSelectBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.sSelectBtn setTitleColor:[UIColor colorWithHexString:@"7FC369"] forState:UIControlStateSelected];
    [self.sSelectBtn setTitle:@"幼儿出勤" forState:UIControlStateNormal];
    self.sSelectBtn.selected = YES;
    self.sSelectBtn.tag = 1002;
    self.sSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"7FC369"].CGColor;
    self.sSelectBtn.layer.borderWidth = 0.5;
    [self.sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sSelectBtn];
    
    self.s_sSelectBtn = [[HJHMyButton alloc]init];
    self.s_sSelectBtn.frame = CGRectMake(320/2 - 0.5, [self getNavHight], 320/2, 40);
    [self.s_sSelectBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.s_sSelectBtn setTitleColor:[UIColor colorWithHexString:@"7FC369"] forState:UIControlStateSelected];
    self.s_sSelectBtn.tag = 1001;
    self.s_sSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"7FC369"].CGColor;
    self.s_sSelectBtn.layer.borderWidth = 0.5;
    [self.s_sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.s_sSelectBtn setTitle:@"幼儿晨检" forState:UIControlStateNormal];
    [self.view addSubview:self.s_sSelectBtn];
    
    CGRect r = self._tableView.frame;
    r.origin.y += 40;
    r.size.height -= 40;
    self._tableView.frame = r;
    
    CGRect r1 = self.headerImageView.frame;
    r1.origin.y += 40;
    self.headerImageView.frame = r1;
    
    CGRect r2 = self.timeImageView.frame;
    r2.origin.y += 40;
    self.timeImageView.frame = r2;
}

#pragma mark - btnClick
-(void)selectSexBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        self.s_sSelectBtn.selected = YES;
        self.sSelectBtn.selected = NO;
        
        self.headerImageInsideStyleImageV1.hidden = YES;
        self.headerImageInsideStyleImageV2.hidden = NO;
        
        TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
        NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
        [tNet getDutyInspectionClassWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] dateStart:self.getDataTime dateEnd:self.getDataTime];
    }
    else if (btn.tag == 1002){
        self.headerImageInsideStyleImageV1.hidden = NO;
        self.headerImageInsideStyleImageV2.hidden = YES;
        
        self.s_sSelectBtn.selected = NO;
        self.sSelectBtn.selected = YES;
        TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
        NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
        
        [tNet getSemesterExceptionWithPlatformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] dateStart:self.getDataTime dateEnd:self.getDataTime];
    }
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
    return 1;
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
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 40;
    }
    return 40;
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
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:startDate]];
    self.getDataTimeAfterOneDay = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:endDate]];
    [self getData];
}


@end
