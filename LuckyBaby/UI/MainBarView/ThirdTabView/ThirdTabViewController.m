//
//  ThirdTabViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "ThirdTabViewController.h"
#import "ThirdTableViewCell.h"
#import "youErYuanNetWork.h"
#import "shiPuViewController.h"
#import "keBiaoViewController.h"
#import "pingJiaViewController.h"
#import "chuQinViewController.h"
#import "BanjiQuanViewController.h"
#import "BanjiQunViewController.h"
#import "showWebViewController2.h"

@interface ThirdTabViewController ()
@property(nonatomic,strong)EGORefreshTableHeaderView *_refreshHeaderView;
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)HJHMyImageView *mainImageView;
@property(nonatomic,strong)NSArray *tongGaoArray;
@property(nonatomic,strong)HJHMyImageView *mengCengBgImageView;
@end

@implementation ThirdTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tongGaoArray = [NSArray array];
    [self setMainImageView];
    [self setMainTableView];
    [self setMengCengBgImageView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(withoutBindSuccess:) name:@"withoutBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(withoutBindFail:) name:@"withoutBindFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsSuccess:) name:@"getPlatformInformsSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsFail:) name:@"getPlatformInformsFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    NSString *userName = [DictionaryStringTool stringFromDictionary:dic forKey:@"userName"];
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    [youErYuanNetWork1 withoutBindWithUserName:userName];
}

-(void)withoutBindSuccess:(NSNotification*)noti{
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youErYuanNetWork1 getPlatformInformsWithchildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] page:@"0" pageSize:@"10"];
    self.mengCengBgImageView.userInteractionEnabled = NO;
}

-(void)withoutBindFail:(NSNotification*)noti{
    
}

-(void)getPlatformInformsSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [DictionaryStringTool stringFromDictionary:dic forKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.tongGaoArray = array;
    }
    [self._tableView reloadData];
}

-(void)getPlatformInformsFail:(NSNotification*)noti{
    
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]init];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, 0, ScreenWidth, 568 - 198 + 78);
    
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, -5, ScreenWidth, 568 - 198 + 78 - 88);
    }
    
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.tableHeaderView = self.mainImageView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.mainImageView = [[HJHMyImageView alloc]init];
    self.mainImageView.frame = CGRectMake(0, 0, ScreenWidth, 198 + 60);
    self.mainImageView.image = [UIImage imageNamed:@"mybaby_top_bg.png"];
    
    for (int i = 0; i < 6; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        [btn addTarget:self action:@selector(thirdViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i*53.3, 198, 53.3, 60);
        btn.tag = i;
        [self.mainImageView addSubview:btn];
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(0, 40, 53.3, 20);
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
        btn.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        switch (i) {
            case 0:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"turn_out_for_work_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"出勤";
            }
                break;
            case 1:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"class_group.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"班级群";
            }
                break;
            case 2:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"class_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"班级圈";
            }
                break;
            case 3:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"evaluate_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"评价";
                
            }
                break;
            case 4:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"class_schedule.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"课表";
                
            }
                break;
            case 5:
            {
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"cookbook_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(0, 5, 53.3, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"食谱";
                
            }
                break;
            default:
                break;
        }
    }
}

-(void)setMengCengBgImageView{
    self.mengCengBgImageView = [[HJHMyImageView alloc]init];
    self.mengCengBgImageView.frame = self.view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMengCengTip)];
    [self.mengCengBgImageView addGestureRecognizer:tap];
    [self.view addSubview:self.mengCengBgImageView];
}

#pragma mark - btnClick
-(void)showMengCengTip{
    KGTipView *tipV = [[KGTipView alloc]initWithTitle:nil context:@"请和幼儿园联系" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [tipV show];
}

-(void)thirdViewBtnClick:(HJHMyButton*)btn{
    switch (btn.tag) {
        case 0:
        {
            chuQinViewController *xiangC = [[chuQinViewController alloc]init];
            [self.navigationController pushViewController:xiangC animated:YES];
        }
            break;
        case 1:
        {
            BanjiQunViewController *qinB = [[BanjiQunViewController alloc]init];
            [self.navigationController pushViewController:qinB animated:YES];
        }
            break;
        case 2:
        {
            BanjiQuanViewController *babayM = [[BanjiQuanViewController alloc]init];
            [self.navigationController pushViewController:babayM animated:YES];
        }
            break;
        case 3:
        {
            pingJiaViewController *daVC = [[pingJiaViewController alloc]init];
            [self.navigationController pushViewController:daVC animated:YES];
        }
            break;
        case 4:
        {
            keBiaoViewController *daVC = [[keBiaoViewController alloc]init];
            [self.navigationController pushViewController:daVC animated:YES];
        }
            break;
        case 5:
        {
            shiPuViewController *daVC = [[shiPuViewController alloc]init];
            [self.navigationController pushViewController:daVC animated:YES];
        }
            break;
            
        default:
            break;
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
    if (self.tongGaoArray.count > 0) {
        return self.tongGaoArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    ThirdTableViewCell* comCell = (ThirdTableViewCell*)cell;
    NSDictionary *dic = [self.tongGaoArray objectAtIndex:indexPath.row];
    comCell.mainLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"infoTitle"];
    NSString *time = [DictionaryStringTool stringFromDictionary:dic forKey:@"datePublic"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:(time.length - 3)]];
    }
    comCell.smallLabel.text = time;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.tongGaoArray objectAtIndex:indexPath.row];
    NSString *knowId = [DictionaryStringTool stringFromDictionary:dic forKey:@"infoId"];
    NSString *title = [DictionaryStringTool stringFromDictionary:dic forKey:@"infoTitle"];
    showWebViewController2 *kwVC = [[showWebViewController2 alloc]initWithKnowId:knowId title:title];
    [self.navigationController pushViewController:kwVC animated:YES];
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
