//
//  selectClassViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "selectClassViewController.h"
#import "TeacherNetWork.h"
#import "T_keBiaoViewController.h"
#import "BanjiQuanViewController.h"
#import "banJi_xiangCeViewController.h"

@interface selectClassViewController ()<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *classListArray;
@property(nonatomic,assign)int cout1;
@property(nonatomic,assign)int cout2;
@property(nonatomic,assign)int cout3;
@end

@implementation selectClassViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listClassWithGradeSuccess:) name:@"listClassWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listClassWithGradeFail:) name:@"listClassWithGradeFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.classListArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet listClassWithGradeWithTeacherId:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] appType:[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"]];
}

#pragma mark -logic data
-(void)listClassWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.classListArray = [[NSMutableArray alloc]initWithArray:array];
    }
    [self._tableView reloadData];
    //************************
}

-(void)listClassWithGradeFail:(NSNotification*)noti{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"选择班级";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
    self.classListArray = [NSArray array];
    
    [self setMainTableView];
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

#pragma mark - tableViewDelegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        self.cout1 = 0;
        for (NSDictionary *dic in self.classListArray) {
            if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"gradeType"]integerValue] == 1) {
                self.cout1++;
            }
        }
        return self.cout1;
    }
    if (section == 1) {
        self.cout2 = 0;
        for (NSDictionary *dic in self.classListArray) {
            if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"gradeType"]integerValue] == 2) {
                self.cout2++;
            }
        }
        return self.cout2;
    }
    if (section == 2) {
        self.cout3 = 0;
        for (NSDictionary *dic in self.classListArray) {
            if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"gradeType"]integerValue] == 3) {
                self.cout3 ++;
            }
        }
        return self.cout3;
    }
    // Return the number of rows in the section.
    return 0;
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
    
    if (indexPath.section == 0) {
        NSDictionary *dic = [self.classListArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(0, 0, 320, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.section == 1) {
        NSDictionary *dic = [self.classListArray objectAtIndex:indexPath.row + self.cout1];
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(0, 0, 320, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.section == 2) {
        NSDictionary *dic = [self.classListArray objectAtIndex:indexPath.row + self.cout1 + self.cout2];
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(0, 0, 320, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic;
    if (indexPath.section == 2) {
        dic = [self.classListArray objectAtIndex:indexPath.row + self.cout1 + self.cout2];
    }
    if (indexPath.section == 0) {
        dic = [self.classListArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 1) {
        dic = [self.classListArray objectAtIndex:indexPath.row + self.cout1];
    }
    if (self.style == 3) {
        T_keBiaoViewController *kVC = [[T_keBiaoViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]];
        [self.navigationController pushViewController:kVC animated:YES];
    }
    if (self.style == 2) {
        BanjiQuanViewController *bVC = [[BanjiQuanViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] className:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"]];
        [self.navigationController pushViewController:bVC animated:YES];
    }
    if (self.style == 1) {
        banJi_xiangCeViewController *bVC = [[banJi_xiangCeViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] className:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"] style:1];
        [self.navigationController pushViewController:bVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    if(section == 0){
        return @"小班";
    }
    if(section == 1){
        return @"中班";
    }
    if(section == 2){
        return @"大班";
    }
    return @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
