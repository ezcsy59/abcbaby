//
//  Tab1_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab1_insertFirstTabVC.h"
#import "TeacherNetWork.h"
#import "tongzhiXiangQingViewController.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab1_insertFirstTabVC ()
@property(nonatomic,strong)EGORefreshTableHeaderView *_refreshHeaderView;
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;

@property(nonatomic,assign)NSInteger currentPage;

@end

@implementation Tab1_insertFirstTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 0;
    self.fisrtXiangQingArray = [NSMutableArray array];
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsSuccess:) name:@"getPlatformInformsSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsFail:) name:@"getPlatformInformsFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet getPlatformInformsWithTeacherId:[DictionaryStringTool stringFromDictionary:dic forKey:@"teacherId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] deptId:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"]  platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]  appType:[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]  page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"20"];
}

#pragma mark -logic data
-(void)getPlatformInformsSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        if ([array isKindOfClass:[NSArray class]]) {
            if (self.currentPage == 0) {
                self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
            }
            else{
                for (NSDictionary *dic in array) {
                    [self.fisrtXiangQingArray addObject:dic];
                }
            }
        }
    }
    //************************
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
    [self._tableView reloadData];
}

-(void)getPlatformInformsFail:(NSNotification*)noti{
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 568 - 158) style:UITableViewStylePlain];
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, 0, ScreenWidth, 568 - 158 - 88);
    }
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
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
    return self.fisrtXiangQingArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    HJHMyImageView *leftImage = [[HJHMyImageView alloc]init];
    leftImage.backgroundColor = [UIColor clearColor];
    leftImage.userInteractionEnabled = NO;
    leftImage.frame = CGRectMake(10, 10, 60, 60);
    leftImage.layer.cornerRadius = 30;
    leftImage.layer.borderColor = [UIColor colorWithHexString:@"#7DCAE6"].CGColor;
    leftImage.layer.borderWidth = 2;
    [cell addSubview:leftImage];
    
    NSDictionary *dic = [self.fisrtXiangQingArray objectAtIndex:indexPath.row];
    NSString *time = [DictionaryStringTool stringFromDictionary:dic forKey:@"datePublic"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:(time.length - 3)]];
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    
    
    HJHMyLabel *label = [[HJHMyLabel alloc]init];
    
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 5, 60, 22);
    label.textColor = [UIColor blackColor];
    [leftImage addSubview:label];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 30, 60, 13);
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    [leftImage addSubview:label2];
    
    
    HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
    label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"infoTitle"];
    label3.font = [UIFont systemFontOfSize:18];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.frame = CGRectMake(80, 0, 120, 80);
    label3.textColor = [UIColor colorWithHexString:@"666666"];
    [cell addSubview:label3];
    
    HJHMyImageView *footImage2 = [[HJHMyImageView alloc]init];
    footImage2.frame = CGRectMake(0, 79.5, 320, 0.5);
    footImage2.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage2];
    
    if (array.count > 1) {
        NSString *time1 = [array objectAtIndex:0];
        NSArray *arrytime = [time1 componentsSeparatedByString:@"-"];
        
        label.text = [arrytime objectAtIndex:2];
        label2.text = [NSString stringWithFormat:@"%@.%@",[arrytime objectAtIndex:1],[arrytime objectAtIndex:0]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.fisrtXiangQingArray objectAtIndex:indexPath.row];
    tongzhiXiangQingViewController *bVC = [[tongzhiXiangQingViewController alloc]initWithInfoId:[DictionaryStringTool stringFromDictionary:dic forKey:@"infoId"]];
    [self.navigationController pushViewController:bVC animated:YES];
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
