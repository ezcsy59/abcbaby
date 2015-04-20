//
//  babyListViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "babyListViewController.h"
#import "PullTableView.h"
#import "BabyListTableViewCell.h"
#import "dongtaiNetWork.h"
#import "yaoQingViewController.h"
#import "tianjiaBabyViewController.h"

@interface babyListViewController ()<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,KGSelectViewDelegate>
@property(nonatomic,strong)EGORefreshTableHeaderView *_refreshHeaderView;
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSArray *babyListArray;
@property(nonatomic,strong)KGSelectView *SView;
@end

@implementation babyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"宝宝列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addBaby) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyListSuccess:) name:@"getBabyListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyListFail:) name:@"getBabyListFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setDefaultChildFamilySuccess:) name:@"setDefaultChildFamilySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setDefaultChildFamilyFail:) name:@"setDefaultChildFamilyFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    self.babyListArray = [NSArray array];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 getBabyListWithRelativesId:[DictionaryStringTool stringFromDictionary:dic forKey:@"relativesId"]];
}

-(void)getBabyListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if (array.count > 0) {
        self.babyListArray = array;
    }
    [self._tableView reloadData];
}

-(void)getBabyListFail:(NSNotification*)noti{
    
}

-(void)setDefaultChildFamilySuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setDefaultChildFamilyFail:(NSNotification*)noti{
    
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
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

#pragma mark - btnClick
-(void)addBaby{
    self.SView = [[KGSelectView alloc]initWithDictionary:@[@"我的宝宝",@"使用邀请码"] title:@"添加宝宝" cancelBtn:@"取消"];
    self.SView.delegate2 = self;
    [self.view addSubview:self.SView];
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
    return self.babyListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[BabyListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    BabyListTableViewCell* comCell = (BabyListTableViewCell*)cell;
    NSDictionary *dic = [self.babyListArray objectAtIndex:indexPath.row];
    
    [comCell.leftImageView setImageWithURL:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"] placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
    comCell.firstLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"nickName"];
    NSString *bString = [DictionaryStringTool stringFromDictionary:dic forKey:@"day"];
    int day = [bString intValue]/365;
    NSString *recordS = [DictionaryStringTool stringFromDictionary:dic forKey:@"recordCount"];
    comCell.secondLabel.text = [NSString stringWithFormat:@"%d岁,共有%@条记录",day,recordS];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.babyListArray objectAtIndex:indexPath.row];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 setDefaultChildFamilyWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamily"] childNicknameFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"nickName"]];
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

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
        tianjiaBabyViewController *qVC = [[tianjiaBabyViewController alloc]initWithStyle:0];
        [self.navigationController pushViewController:qVC animated:YES];
    }
    else if (tag == 1){
        yaoQingViewController *qVC = [[yaoQingViewController alloc]init];
        [self.navigationController pushViewController:qVC animated:YES];
    }
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)cancalSelectClicked{
    [self.SView removeFromSuperview];
    self.SView = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
