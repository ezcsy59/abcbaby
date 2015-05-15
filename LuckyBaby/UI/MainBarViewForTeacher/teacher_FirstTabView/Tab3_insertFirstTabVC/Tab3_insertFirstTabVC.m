//
//  Tab3_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab3_insertFirstTabVC.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#import "PICircularProgressView.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab3_insertFirstTabVC ()<KGSelectDateViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;

@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;
@property(nonatomic,strong)NSMutableDictionary *fisrtXiangQingDic;
@property(nonatomic,strong)NSString *getDataTime;

@property(nonatomic,strong)HJHMyImageView *footImageView;
@property(nonatomic,strong)HJHMyImageView *headerImageView;
@property(nonatomic,strong)PICircularProgressView *cpV;
@property(nonatomic,strong)HJHMyButton *sSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_sSelectBtn;
@end

@implementation Tab3_insertFirstTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyInspectionClassWithGradeSuccess:) name:@"listDutyInspectionClassWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyInspectionClassWithGradeFail:) name:@"listDutyInspectionClassWithGradeFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyPlatformSuccess:) name:@"getInspectionDailyPlatformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInspectionDailyPlatformFail:) name:@"getInspectionDailyPlatformFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.cpV.progress = 0;
    [self.fisrtXiangQingArray removeAllObjects];
    self.fisrtXiangQingDic = [NSMutableDictionary dictionary];
    self.fisrtXiangQingArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet listDutyInspectionClassWithGradeWithMsgDate:self.getDataTime platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
    
}

#pragma mark -logic data
-(void)listDutyInspectionClassWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
    }
    [self._tableView reloadData];
    //************************
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dict = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet getInspectionDailyPlatformWithMsgDate:self.getDataTime platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"]];
}

-(void)listDutyInspectionClassWithGradeFail:(NSNotification*)noti{
    
}

-(void)getInspectionDailyPlatformSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    //************************
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self.fisrtXiangQingDic = [[NSMutableDictionary alloc]initWithDictionary:dict];
    }
    [self._tableView reloadData];
}

-(void)getInspectionDailyPlatformFail:(NSNotification*)noti{
    
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
    self._tableView.tableHeaderView = self.headerImageView;
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.headerImageView = [[HJHMyImageView alloc]init];
    self.headerImageView.frame = CGRectMake(0, 0, 320, 235);
    self.timeImageView = [[KGSelectDateView alloc]initWithDateChanegSize:1];
    self.timeImageView.delegate2 = self;
    [self.view addSubview:self.timeImageView];
    
    self.cpV = [[PICircularProgressView alloc]init];
    self.cpV.frame = CGRectMake(100, 10, 120, 120);
    [self.headerImageView addSubview:self.cpV];
    self.cpV.progress = 0;
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    label1.text = @"晨检正常率";
    label1.font = [UIFont systemFontOfSize:20];
    label1.frame = CGRectMake(0, 160, 320, 20);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    [self.headerImageView addSubview:label1];
    //    self.timeImageView.frame = CGRectMake(0, 0, ScreenWidth, 198 + 60);
    
    self.sSelectBtn = [[HJHMyButton alloc]init];
    self.sSelectBtn.frame = CGRectMake(15, 190, 290/2, 40);
    [self.sSelectBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.sSelectBtn setTitleColor:[UIColor colorWithHexString:@"7FC369"] forState:UIControlStateSelected];
    [self.sSelectBtn setTitle:@"症状分布" forState:UIControlStateNormal];
    self.sSelectBtn.selected = YES;
    self.sSelectBtn.tag = 1002;
    self.sSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"7FC369"].CGColor;
    self.sSelectBtn.layer.borderWidth = 0.5;
    [self.sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerImageView addSubview:self.sSelectBtn];
    
    self.s_sSelectBtn = [[HJHMyButton alloc]init];
    self.s_sSelectBtn.frame = CGRectMake(15 + 290/2 - 0.5, 190, 290/2, 40);
    [self.s_sSelectBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.s_sSelectBtn setTitleColor:[UIColor colorWithHexString:@"7FC369"] forState:UIControlStateSelected];
    self.s_sSelectBtn.tag = 1001;
    self.s_sSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"7FC369"].CGColor;
    self.s_sSelectBtn.layer.borderWidth = 0.5;
    [self.s_sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.s_sSelectBtn setTitle:@"班级分布" forState:UIControlStateNormal];
    [self.headerImageView addSubview:self.s_sSelectBtn];
}

#pragma mark - btnClick
-(void)selectSexBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        self.s_sSelectBtn.selected = YES;
        self.sSelectBtn.selected = NO;
    }
    else if (btn.tag == 1002){
        self.s_sSelectBtn.selected = NO;
        self.sSelectBtn.selected = YES;
    }
    [self._tableView reloadData];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    // Return the number of sections.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sSelectBtn.selected == YES) {
        return 7;
    }
    else{
        return self.fisrtXiangQingArray.count;
    }
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
    NSDictionary *dic = [NSDictionary dictionary];
    if(self.fisrtXiangQingArray.count > indexPath.row){
         dic = [self.fisrtXiangQingArray objectAtIndex:indexPath.row];
    }
   
    if (self.fisrtXiangQingArray.count > 0) {
        self.cpV.progress = 1;
    }
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    
    label1.font = [UIFont systemFontOfSize:14];
    label1.frame = CGRectMake(10, 0, 100, 40);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label1];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    
    label2.font = [UIFont systemFontOfSize:14];
    label2.frame = CGRectMake(240, 0, 40, 40);
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label2];
    
    if (self.sSelectBtn.selected == YES) {
        switch (indexPath.row) {
            case 0:
            {
                label1.text = @"发热";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item1"];
            }
                break;
            case 1:
            {
                label1.text = @"咳嗽";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item2"];
            }
                break;
            case 2:
            {
                label1.text = @"皮疹";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item3"];
            }
                break;
            case 3:
            {
                label1.text = @"眼结膜充血";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item4"];
            }
                break;
            case 4:
            {
                label1.text = @"腮腺肿大";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item5"];
            }
                break;
            case 5:
            {
                label1.text = @"黄疸";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item6"];
            }
                break;
            case 6:
            {
                label1.text = @"其他";
                label2.text = [DictionaryStringTool stringFromDictionary:self.fisrtXiangQingDic forKey:@"item7"];
            }
                break;
                
            default:
                break;
        }
    }
    else{
        label1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"dispOrder"];
    }
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0,39, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:endDate]];
    [self getData];
}
@end
