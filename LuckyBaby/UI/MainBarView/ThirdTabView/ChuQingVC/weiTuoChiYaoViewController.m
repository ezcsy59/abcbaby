//
//  weiTuoChiYaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "weiTuoChiYaoViewController.h"

#import "youErYuanNetWork.h"
#import "TQRichTextView.h"

@interface weiTuoChiYaoViewController ()<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSArray *qingjiaListArray;
@end

@implementation weiTuoChiYaoViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listMedicineSuccess:) name:@"listMedicineSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listMedicineFail:) name:@"listMedicineFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youE listMedicineWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] page:@"0" pageSize:@"10"];
}

-(void)listMedicineSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if([array isKindOfClass:[NSArray class]]){
        self.qingjiaListArray = array;
    }
    [self._tableView reloadData];
}

-(void)listMedicineFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qingjiaListArray = [NSArray array];
    
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (iPhone5?568:480) - 114) style:UITableViewStylePlain];
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
    zuijinLabel.text = [NSString stringWithFormat:@"名称:%@",[DictionaryStringTool stringFromDictionary:dic forKey:@"medicineName"]];
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:16];
    [cell addSubview:zuijinLabel];
    
    NSString *time1 = [DictionaryStringTool stringFromDictionary:dic forKey:@"createdDatetime"];
    if(time1.length >= 3){
        time1 = [TimeChange timeChage:[time1 substringToIndex:time1.length - 3]];
    }
    NSArray *array = [time1 componentsSeparatedByString:@" "];
    time1 = [array objectAtIndex:0];
    TQRichTextView *label1 = [[TQRichTextView alloc]initWithFrame:CGRectMake(10, 40, 300, 20)];
    label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    label1.text = [NSString stringWithFormat:@"时间:%@",time1];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:15];
    label1.frame = CGRectMake(10, 40, 300, label1.drawheigth);
    [cell addSubview:label1];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 69.5, 320, 0.5);
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

@end
