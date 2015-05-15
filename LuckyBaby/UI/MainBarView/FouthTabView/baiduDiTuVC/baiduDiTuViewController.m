//
//  baiduDiTuViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-18.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "baiduDiTuViewController.h"
#import "youErYuanNetWork.h"
#import "baiduViewController.h"
#import "TQRichTextView.h"

@interface baiduDiTuViewController ()<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,baiduViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSArray *dituListArray;
@property(nonatomic,strong)baiduViewController *TV2;
@end

@implementation baiduDiTuViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    self.TV2 = [[baiduViewController alloc]init];
    self.TV2.searchName = @"幼儿园";
    self.TV2.delegate2 = self;
    [self.TV2 beginDingWei];
    [self addChildViewController:self.TV2];
    self.TV2.view.frame = CGRectZero;
    self.TV2.view.clipsToBounds = YES;
    [self.view addSubview:self.TV2.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dituListArray = [NSArray array];
    
    self.headNavView.titleLabel.text = @"周边幼儿园";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"地图" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];

    
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
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
    return self.dituListArray.count;
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
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
    NSDictionary *dic = [self.dituListArray objectAtIndex:indexPath.row];
    nameLabel.text = [dic objectForKey:@"locationName"];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    nameLabel.frame = CGRectMake(10, 10, 300, 20);
    [cell addSubview:nameLabel];
    
    TQRichTextView *diDianLabel = [[TQRichTextView alloc]init];
    diDianLabel.text = [NSString stringWithFormat:@"[p1000]%@",[dic objectForKey:@"locationAdress"]];
    diDianLabel.font = [UIFont systemFontOfSize:18];
    diDianLabel.backgroundColor = [UIColor clearColor];
    diDianLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
    diDianLabel.frame = CGRectMake(10, 40, 300, 20);
    [cell addSubview:diDianLabel];
    
    TQRichTextView *phoneLabel = [[TQRichTextView alloc]init];
    phoneLabel.text = [NSString stringWithFormat:@"[p1002]%@",[dic objectForKey:@"locationPhone"]];
    phoneLabel.font = [UIFont systemFontOfSize:18];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor colorWithHexString:@"666666"];
    phoneLabel.frame = CGRectMake(10, 70, 300, 20);
    [cell addSubview:phoneLabel];
    
    HJHMyLabel *distanceLabel = [[HJHMyLabel alloc]init];
    NSString *distance = [dic objectForKey:@"locationDistance"];
    float fldis = [distance floatValue]/10000;
    distanceLabel.text = [NSString stringWithFormat:@"%.2f米",fldis];
    distanceLabel.font = [UIFont systemFontOfSize:18];
    distanceLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    distanceLabel.frame = CGRectMake(220, 70, 100, 20);
    [cell addSubview:distanceLabel];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 99, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dituListArray objectAtIndex:indexPath.row];
    NSString *nameLabel = [dic objectForKey:@"locationName"];
    baiduViewController *TV = [[baiduViewController alloc]init];
    TV.searchName = nameLabel;
    [self.navigationController pushViewController:TV animated:YES];
}

#pragma mark - btnClick
-(void)addData{
    baiduViewController *TV = [[baiduViewController alloc]init];
    TV.searchName = @"幼儿园";
    [self.navigationController pushViewController:TV animated:YES];
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

#pragma mark - baiduDelegate
-(void)popBackWith:(NSMutableArray *)locationArray{
    self.dituListArray = locationArray;
    [self.TV2 removeFromParentViewController];
    self.TV2 = nil;
    [self._tableView reloadData];
}
@end
