//
//  tiXingViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-18.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "tiXingViewController.h"
#import "LoginNetWork.h"
#import "TQRichTextView.h"
#import "addTiXingViewController.h"

@interface tiXingViewController ()<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSMutableArray *tiXingListArray;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation tiXingViewController

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 0;
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listAlertSuccess:) name:@"listAlertSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listAlertFail:) name:@"listAlertFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    LoginNetWork *loginN = [[LoginNetWork alloc]init];
    [loginN listAlertWithPage:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
}

-(void)listAlertSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        if (self.currentPage == 0) {
            self.tiXingListArray = [[NSMutableArray alloc]initWithArray:array];
        }
        else{
            for (NSDictionary *dic in array) {
                [self.tiXingListArray addObject:dic];
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

-(void)listAlertFail:(NSNotification*)noti{
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tiXingListArray = [NSMutableArray array];
    
    self.headNavView.titleLabel.text = @"提醒";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
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
    return self.tiXingListArray.count;
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
    NSDictionary *dic = [self.tiXingListArray objectAtIndex:indexPath.row];
    nameLabel.text = [dic objectForKey:@"alertName"];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    nameLabel.frame = CGRectMake(10, 10, 300, 20);
    [cell addSubview:nameLabel];
    
    TQRichTextView *diDianLabel = [[TQRichTextView alloc]initWithFrame:CGRectMake(0, 0, 300, 0)];
    diDianLabel.text = [NSString stringWithFormat:@"描述:%@",[dic objectForKey:@"alertDesc"]];
    diDianLabel.font = [UIFont systemFontOfSize:16];
    diDianLabel.backgroundColor = [UIColor clearColor];
    diDianLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    diDianLabel.frame = CGRectMake(10, 40, 300, diDianLabel.drawheigth);
    [cell addSubview:diDianLabel];
    
    NSString *repickTime = [dic objectForKey:@"weekDays"];
    if ([dic objectForKey:@"isRepeat"]) {
        repickTime = [NSString stringWithFormat:@"%@重复",repickTime];
    }
    
    HJHMyLabel *phoneLabel = [[HJHMyLabel alloc]init];
    phoneLabel.text = [NSString stringWithFormat:@"时间:%@",repickTime];
    phoneLabel.font = [UIFont systemFontOfSize:16];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor colorWithHexString:@"666666"];
    phoneLabel.frame = CGRectMake(10, diDianLabel.drawheigth + 40 + 10, 300, 20);
    [cell addSubview:phoneLabel];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, diDianLabel.drawheigth + 40 + 35, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.tiXingListArray objectAtIndex:indexPath.row];
    TQRichTextView *diDianLabel = [[TQRichTextView alloc]initWithFrame:CGRectMake(0, 0, 300, 0)];
    diDianLabel.text = [NSString stringWithFormat:@"描述:%@",[dic objectForKey:@"alertDesc"]];
    diDianLabel.font = [UIFont systemFontOfSize:16];
    diDianLabel.backgroundColor = [UIColor clearColor];
    diDianLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    diDianLabel.frame = CGRectMake(10, 40, 300, diDianLabel.drawheigth);
    return diDianLabel.drawheigth + 40 + 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - btnClick
-(void)addData{
    addTiXingViewController *aVC = [[addTiXingViewController alloc]init];
    [self.navigationController pushViewController:aVC animated:YES];
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
