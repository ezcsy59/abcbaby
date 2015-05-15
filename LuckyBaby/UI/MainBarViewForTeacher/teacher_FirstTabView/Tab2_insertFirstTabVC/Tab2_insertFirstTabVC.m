//
//  Tab2_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab2_insertFirstTabVC.h"
#import "TeacherNetWork.h"
#import "KGSelectDateView.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab2_insertFirstTabVC ()<KGSelectDateViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)KGSelectDateView *timeImageView;

@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;

@property(nonatomic,strong)NSString *getDataTime;

@property(nonatomic,strong)HJHMyImageView *footImageView;
@end

@implementation Tab2_insertFirstTabVC

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
        [self._tableView reloadData];
    }
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
    self.footImageView.frame = CGRectMake(0, 568 - 208, ScreenWidth, 50);
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    label1.text = @"总计";
    label1.font = [UIFont systemFontOfSize:16];
    label1.frame = CGRectMake(0, 0, 53, 50);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    [self.footImageView addSubview:label1];
    
    HJHMyButton *Btn1 = [[HJHMyButton alloc]init];
    Btn1.frame = CGRectMake(53, 10, 30, 30);
    [Btn1 setBackgroundColor:[UIColor colorWithHexString:@"75DC97"]];
    Btn1.layer.cornerRadius = 15;
    Btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [Btn1 setContentMode:UIViewContentModeScaleAspectFill];
    [Btn1 setTitle:[DictionaryStringTool stringFromDictionary:dict forKey:@"inspQty"] forState:UIControlStateNormal];
    [self.footImageView addSubview:Btn1];
    
    HJHMyButton *Btn2 = [[HJHMyButton alloc]init];
    Btn2.frame = CGRectMake(53*2, 10, 30, 30);
    [Btn2 setBackgroundColor:[UIColor colorWithHexString:@"FEBF3E"]];
    Btn2.layer.cornerRadius = 15;
    Btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [Btn2 setTitle:[DictionaryStringTool stringFromDictionary:dict forKey:@"offCase"] forState:UIControlStateNormal];
    [self.footImageView addSubview:Btn2];
    
    HJHMyButton *Btn3 = [[HJHMyButton alloc]init];
    Btn3.frame = CGRectMake(53*3, 10, 30, 30);
    [Btn3 setBackgroundColor:[UIColor colorWithHexString:@"FF9676"]];
    Btn3.layer.cornerRadius = 15;
    Btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [Btn3 setContentMode:UIViewContentModeScaleAspectFit];
    [Btn3 setTitle:[DictionaryStringTool stringFromDictionary:dict forKey:@"offDisease"] forState:UIControlStateNormal];
    [self.footImageView addSubview:Btn3];
    
    HJHMyButton *Btn4 = [[HJHMyButton alloc]init];
    Btn4.frame = CGRectMake(53*4, 10, 30, 30);
    [Btn4 setBackgroundColor:[UIColor colorWithHexString:@"0000ff"]];
    Btn4.layer.cornerRadius = 15;
    Btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    [Btn4 setContentMode:UIViewContentModeScaleAspectFit];
    [Btn4 setTitle:[DictionaryStringTool stringFromDictionary:dict forKey:@"totalQty"] forState:UIControlStateNormal];
    [self.footImageView addSubview:Btn4];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    label2.text = [NSString stringWithFormat:@"%.2f",[[DictionaryStringTool stringFromDictionary:dict forKey:@"dutyRatio"] floatValue]];
    label2.font = [UIFont systemFontOfSize:16];
    label2.frame = CGRectMake(53*5, 0, 53, 50);
    
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor blackColor];
    [self.footImageView addSubview:label2];

    [self._tableView reloadData];
    //************************
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
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 568 - 258) style:UITableViewStylePlain];
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, 0, ScreenWidth, 568 - 258 - 88);
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

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.fisrtXiangQingArray.count > 0){
        return 1 + self.fisrtXiangQingArray.count;
    }
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
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
        HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
        label1.text = @"班级";
        label1.font = [UIFont systemFontOfSize:16];
        label1.frame = CGRectMake(0, 0, 53, 40);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        [cell addSubview:label1];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"出勤";
        label2.font = [UIFont systemFontOfSize:16];
        label2.frame = CGRectMake(53, 0, 53, 40);
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"事假";
        label3.font = [UIFont systemFontOfSize:16];
        label3.frame = CGRectMake(53*2, 0, 53, 40);
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
        label4.text = @"病假";
        label4.font = [UIFont systemFontOfSize:16];
        label4.frame = CGRectMake(53*3, 0, 53, 40);
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = [UIColor blackColor];
        [cell addSubview:label4];
        
        HJHMyLabel *label5 = [[HJHMyLabel alloc]init];
        label5.text = @"缺勤";
        label5.font = [UIFont systemFontOfSize:16];
        label5.frame = CGRectMake(53*4, 0, 53, 40);
        label5.textAlignment = NSTextAlignmentCenter;
        label5.textColor = [UIColor blackColor];
        [cell addSubview:label5];
        
        HJHMyLabel *label6 = [[HJHMyLabel alloc]init];
        label6.text = @"出勤率";
        label6.font = [UIFont systemFontOfSize:16];
        label6.frame = CGRectMake(53*5, 0, 53, 40);
        label6.textAlignment = NSTextAlignmentCenter;
        label6.textColor = [UIColor blackColor];
        [cell addSubview:label6];
    }
    else{
        NSDictionary *dic = [self.fisrtXiangQingArray objectAtIndex:indexPath.row - 1];
        HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
        label1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label1.font = [UIFont systemFontOfSize:16];
        label1.frame = CGRectMake(0, 0, 53, 40);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        [cell addSubview:label1];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = [NSString stringWithFormat:@"%d",[[DictionaryStringTool stringFromDictionary:dic forKey:@"dispOrder"] integerValue]];
        label2.font = [UIFont systemFontOfSize:16];
        label2.frame = CGRectMake(53, 0, 53, 40);
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [NSString stringWithFormat:@"%d",[[DictionaryStringTool stringFromDictionary:dic forKey:@"offCaseQty"] integerValue]];
        label3.font = [UIFont systemFontOfSize:16];
        label3.frame = CGRectMake(53*2, 0, 53, 40);
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
        label4.text = [NSString stringWithFormat:@"%d",[[DictionaryStringTool stringFromDictionary:dic forKey:@"offDiseaseQty"] integerValue]];
        label4.font = [UIFont systemFontOfSize:16];
        label4.frame = CGRectMake(53*3, 0, 53, 40);
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = [UIColor blackColor];
        [cell addSubview:label4];
        
        HJHMyLabel *label5 = [[HJHMyLabel alloc]init];
        label5.text = [NSString stringWithFormat:@"%d",[[DictionaryStringTool stringFromDictionary:dic forKey:@"totalQty"] integerValue]];
        label5.font = [UIFont systemFontOfSize:16];
        label5.frame = CGRectMake(53*4, 0, 53, 40);
        label5.textAlignment = NSTextAlignmentCenter;
        label5.textColor = [UIColor blackColor];
        [cell addSubview:label5];
        
        HJHMyLabel *label6 = [[HJHMyLabel alloc]init];
        label6.text = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@.0",[DictionaryStringTool stringFromDictionary:dic forKey:@"dutyRatio"]] floatValue]];
        label6.font = [UIFont systemFontOfSize:16];
        label6.frame = CGRectMake(53*5, 0, 53, 40);
        label6.textAlignment = NSTextAlignmentCenter;
        label6.textColor = [UIColor blackColor];
        [cell addSubview:label6];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 39, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
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
    self.getDataTime = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:endDate]];
    [self getData];
}
@end
