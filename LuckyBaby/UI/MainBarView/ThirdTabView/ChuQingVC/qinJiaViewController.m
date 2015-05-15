//
//  qinJiaViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "qinJiaViewController.h"
#import "youErYuanNetWork.h"

@interface qinJiaViewController ()<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSMutableArray *qingjiaListArray;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation qinJiaViewController

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 0;
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyOffApplySuccess:) name:@"listDutyOffApplySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDutyOffApplyFail:) name:@"listDutyOffApplyFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youE listDutyOffApplyWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
}

-(void)listDutyOffApplySuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if([array isKindOfClass:[NSArray class]]){
        if ([array isKindOfClass:[NSArray class]]) {
            if (self.currentPage == 0) {
                self.qingjiaListArray = [[NSMutableArray alloc]initWithArray:array];
            }
            else{
                for (NSDictionary *dic in array) {
                    [self.qingjiaListArray addObject:dic];
                }
            }
        }
    }
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
    [self._tableView reloadData];
}

-(void)listDutyOffApplyFail:(NSNotification*)noti{
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qingjiaListArray = [NSMutableArray array];
    
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (iPhone5?568:480) - 44 - 70) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.qingjiaListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    NSDictionary *dic = [self.qingjiaListArray objectAtIndex:indexPath.row];
    
    HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    zuijinLabel.textColor = [UIColor blackColor];
    NSString *time1 = [DictionaryStringTool stringFromDictionary:dic forKey:@"offDateStart"];
    NSString *time2 = [DictionaryStringTool stringFromDictionary:dic forKey:@"offDateEnd"];
    if(time1.length >= 3){
        time1 = [TimeChange timeChage:[time1 substringToIndex:time1.length - 3]];
    }
    NSArray *array = [time1 componentsSeparatedByString:@" "];
    time1 = [array objectAtIndex:0];
    if(time2.length >= 3){
        time2 = [TimeChange timeChage:[time2 substringToIndex:time2.length - 3]];
    }
    array = [time2 componentsSeparatedByString:@" "];
    time2 = [array objectAtIndex:0];
    zuijinLabel.text = [NSString stringWithFormat:@"时间:%@到%@",time1,time2];
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:16];
    [cell addSubview:zuijinLabel];
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 40, 300, 20)];
    label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    label1.text = [NSString stringWithFormat:@"理由:%@",[DictionaryStringTool stringFromDictionary:dic forKey:@"offReason"]];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:15];
    [cell addSubview:label1];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 69, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark - pullTableViewDelegate
-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    //    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    self.currentPage ++;
    [self getData];
}


-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    NSLog(@"hello");
    NSLog(@"%@",pullTableView);
    //    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    self.currentPage = 0;
    [self getData];
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

@end
