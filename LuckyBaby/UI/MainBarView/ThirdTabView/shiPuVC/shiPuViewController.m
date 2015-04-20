//
//  shiPuViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "shiPuViewController.h"
#import "SY_DateViewController.h"
#import "youErYuanNetWork.h"

@interface shiPuViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SY_DateViewControllerDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *shiPuArray;
@property(nonatomic,strong)NSString *date1;
@property(nonatomic,strong)NSString *date2;

@property(nonatomic,strong)NSMutableDictionary *dateDic;

@property(nonatomic,assign)int currentDay;
@end

@implementation shiPuViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMealSchedulePlatformSuccess:) name:@"getMealSchedulePlatformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMealSchedulePlatformFail:) name:@"getMealSchedulePlatformFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    self.shiPuArray = [NSArray array];
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    
    NSArray *array = [NSArray array];
    NSString *time1 = [DictionaryStringTool stringFromDictionary:self.dateDic forKey:@"firstDate"];
    array = [time1 componentsSeparatedByString:@" "];
    time1 = [array objectAtIndex:0];
    
    NSString *time2 = [DictionaryStringTool stringFromDictionary:self.dateDic forKey:@"nextDate"];
    array = [time2 componentsSeparatedByString:@" "];
    time2 = [array objectAtIndex:0];
    
    time1 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:time1]];
    time2 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:time2]];
    
    [youErYuanNetWork1 getMealSchedulePlatformWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] dateStart:time1 dateEnd:time2];
}

-(void)getMealSchedulePlatformSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if([array isKindOfClass:[NSArray class]]){
        self.shiPuArray = array;
        [self._tableView reloadData];
    }
    else{
        self.shiPuArray = [NSArray array];
        [self._tableView reloadData];
    }
}

-(void)getMealSchedulePlatformFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateDic = [NSMutableDictionary dictionary];
    self.headNavView.titleLabel.text = @"食谱";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    SY_DateViewController *sDateVC = [[SY_DateViewController alloc]init];
    sDateVC.view.frame = CGRectMake(0, [self getNavHight], 320, (iPhone5?568:480) - [self getNavHight]);
    sDateVC.delegate2 = self;
    [self.view addSubview:sDateVC.view];
    [self addChildViewController:sDateVC];
    
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 135, ScreenWidth, (iPhone5?568:480) - [self getNavHight] - 135) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
    
    [sDateVC.scrollView addSubview:self._tableView];

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
    return self.shiPuArray.count;
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
    NSDictionary *dic = [self.shiPuArray objectAtIndex:self.currentDay];
    
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    nameLabel.frame = CGRectMake(40, 0, 80, 40);
    [cell addSubview:nameLabel];
    
    if (indexPath.row == 0) {
        nameLabel.text = @"早餐";
        HJHMyLabel *nameLabel2 = [[HJHMyLabel alloc]init];
        nameLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"m1"];
        nameLabel2.font = [UIFont systemFontOfSize:18];
        nameLabel2.textColor = [UIColor colorWithHexString:@"777777"];
        nameLabel2.frame = CGRectMake(10, 30, 80, 60);
        [cell addSubview:nameLabel2];
        
        HJHMyImageView *image = [[HJHMyImageView alloc]init];
        image.frame = CGRectMake(10, 10, 20, 20);
        image.image = [UIImage imageNamed:@"yuandian_01"];
        [cell addSubview:image];
    }
    if (indexPath.row == 1) {
        nameLabel.text = @"上午点心";
        HJHMyLabel *nameLabel2 = [[HJHMyLabel alloc]init];
        nameLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"m2"];
        nameLabel2.font = [UIFont systemFontOfSize:18];
        nameLabel2.textColor = [UIColor colorWithHexString:@"777777"];
        nameLabel2.frame = CGRectMake(10, 30, 80, 60);
        [cell addSubview:nameLabel2];
        
        HJHMyImageView *image = [[HJHMyImageView alloc]init];
        image.frame = CGRectMake(10, 10, 20, 20);
        image.image = [UIImage imageNamed:@"yuandian_02"];
        [cell addSubview:image];
    }
    if (indexPath.row == 2) {
        nameLabel.text = @"午餐";
        HJHMyLabel *nameLabel2 = [[HJHMyLabel alloc]init];
        nameLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"m3"];
        nameLabel2.font = [UIFont systemFontOfSize:18];
        nameLabel2.textColor = [UIColor colorWithHexString:@"777777"];
        nameLabel2.frame = CGRectMake(10, 30, 80, 60);
        [cell addSubview:nameLabel2];
        
        HJHMyImageView *image = [[HJHMyImageView alloc]init];
        image.frame = CGRectMake(10, 10, 20, 20);
        image.image = [UIImage imageNamed:@"yuandian_03"];
        [cell addSubview:image];
    }
    if (indexPath.row == 3) {
        nameLabel.text = @"下午点心";
        HJHMyLabel *nameLabel2 = [[HJHMyLabel alloc]init];
        nameLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"m4"];
        nameLabel2.font = [UIFont systemFontOfSize:18];
        nameLabel2.textColor = [UIColor colorWithHexString:@"777777"];
        nameLabel2.frame = CGRectMake(10, 30, 80, 60);
        [cell addSubview:nameLabel2];
        
        HJHMyImageView *image = [[HJHMyImageView alloc]init];
        image.frame = CGRectMake(10, 10, 20, 20);
        image.image = [UIImage imageNamed:@"yuandian_04"];
        [cell addSubview:image];
    }
    if (indexPath.row == 4) {
        nameLabel.text = @"晚餐";
        HJHMyLabel *nameLabel2 = [[HJHMyLabel alloc]init];
        nameLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"m5"];
        nameLabel2.font = [UIFont systemFontOfSize:18];
        nameLabel2.textColor = [UIColor colorWithHexString:@"777777"];
        nameLabel2.frame = CGRectMake(10, 30, 80, 60);
        [cell addSubview:nameLabel2];
        
        HJHMyImageView *image = [[HJHMyImageView alloc]init];
        image.frame = CGRectMake(10, 10, 20, 20);
        image.image = [UIImage imageNamed:@"yuandian_05"];
        [cell addSubview:image];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - SY_DateViewControllerDelegate
-(void)swipReturnDate1:(NSString *)date1 date2:(NSString *)date2{
    self.currentDay = 0;
    NSDictionary *dic = [TimeChange getWeekday:date1];
    self.dateDic = dic;
    [self getData];
}

-(void)selectDatedWithTag:(int)tag{
    if (tag < 6 && tag > 0) {
        self.currentDay = tag - 1;
    }
    [self._tableView reloadData];
}
@end
