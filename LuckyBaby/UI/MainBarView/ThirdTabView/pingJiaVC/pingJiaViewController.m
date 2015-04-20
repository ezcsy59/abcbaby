//
//  pingJiaViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "pingJiaViewController.h"
#import "SY_DateViewController.h"
#import "youErYuanNetWork.h"
#import "TQRichTextView.h"

@interface pingJiaViewController ()<UITableViewDataSource,UITableViewDelegate,SY_DateViewControllerDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSDictionary *pingjiaDict;
@property(nonatomic,strong)NSString *date1;
@property(nonatomic,strong)NSString *date2;
@property(nonatomic,assign)int currentWeak;
@property(nonatomic,strong)TQRichTextView *neirongLabel;
@property(nonatomic,strong)UIScrollView *pingjiaSV;
@end

@implementation pingJiaViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getScoreInfoSuccess:) name:@"getScoreInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getScoreInfoFail:) name:@"getScoreInfoFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    
    
    [youErYuanNetWork1 getScoreInfoWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] childIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] weekIndex:[NSString stringWithFormat:@"%d",self.currentWeak]];
}

-(void)getScoreInfoSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self.pingjiaDict = dict;
        self.neirongLabel.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"scoreDesc"];
        self.neirongLabel.frame = CGRectMake(0, 0, 230, self.neirongLabel.drawheigth);
        [self.pingjiaSV setContentSize:CGSizeMake(230, self.neirongLabel.drawheigth)];
    }
    [self._tableView reloadData];
}

-(void)getScoreInfoFail:(NSNotification*)noti{
    
}


- (void)viewDidLoad {
    NSDictionary *dict = [plistDataManager getDataWithKey:user_playformList];
    NSString *time3 = [DictionaryStringTool stringFromDictionary:dict forKey:@"semesterDateStart"];
    if(time3.length >= 3){
        time3 = [TimeChange timeChage:[time3 substringToIndex:time3.length - 3]];
    }
    NSArray *array = [time3 componentsSeparatedByString:@" "];
    time3 = [array objectAtIndex:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [formatter dateFromString:time3];
    
    self.currentWeak = [[TimeChange compareCurrentTime:datenow] integerValue];
    self.currentWeak = self.currentWeak/7 + 1;
    
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.pingjiaDict = [NSDictionary dictionary];
    [self setMainView];
    [self setPingJiaText];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    SY_DateViewController *sDateVC = [[SY_DateViewController alloc]init];
    sDateVC.view.frame = CGRectMake(0, [self getNavHight] - 64, 320, (iPhone5?568:480) - [self getNavHight] + 64);
    sDateVC.delegate2 = self;
    [self.view addSubview:sDateVC.view];
    [self addChildViewController:sDateVC];
    
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, ScreenWidth, (iPhone5?568:480) - [self getNavHight] - 185) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
    
    [sDateVC.scrollView addSubview:self._tableView];
    
    [self.view sendSubviewToBack:sDateVC.view];
}

-(void)setPingJiaText{
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    nameLabel.text = @"评价 :";
    nameLabel.frame = CGRectMake(10, (iPhone5?568:480) - 150, 80, 60);
    [self.view addSubview:nameLabel];
    
    self.pingjiaSV = [[UIScrollView alloc]init];
    self.pingjiaSV.frame = CGRectMake(70, (iPhone5?568:480) - 130, 230, 120);
    self.pingjiaSV.showsHorizontalScrollIndicator = NO;
    self.pingjiaSV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.pingjiaSV];
    
    self.neirongLabel = [[TQRichTextView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    self.neirongLabel.font = [UIFont systemFontOfSize:18];
    self.neirongLabel.textColor = [UIColor blackColor];
    self.neirongLabel.text = @"";
    self.neirongLabel.frame = CGRectMake(0, 0, 230, self.neirongLabel.drawheigth);
    self.neirongLabel.backgroundColor = [UIColor clearColor];
    [self.pingjiaSV addSubview:self.neirongLabel];

}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
    nameLabel.frame = CGRectMake(10, 0, 80, 60);
    [cell addSubview:nameLabel];
    if (indexPath.row == 0) {
        nameLabel.text = @"进餐";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value0"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 1) {
        nameLabel.text = @"活动";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value1"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 2) {
        nameLabel.text = @"情绪";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value2"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 3) {
        nameLabel.text = @"锻炼";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value3"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 4) {
        nameLabel.text = @"睡眠";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value4"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 5) {
        nameLabel.text = @"礼貌";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value5"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 6) {
        nameLabel.text = @"听说";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value6"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    if (indexPath.row == 7) {
        nameLabel.text = @"卫生";
        for (int i = 0; i < [[self.pingjiaDict objectForKey:@"value7"] integerValue]; i++) {
            HJHMyImageView *image = [[HJHMyImageView alloc]init];
            image.frame = CGRectMake(60 + i * 45, 10, 40, 40);
            image.image = [UIImage imageNamed:@"star"];
            [cell addSubview:image];
        }
    }
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 59, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SY_DateViewControllerDelegate
-(void)swipReturnDate1:(NSString *)date1 date2:(NSString *)date2{
    self.date1 = date1;
    self.date2 = date2;
    if ([self.date2 integerValue] > [self.date2 integerValue]) {
        self.currentWeak ++;
    }
    else{
        self.currentWeak --;
    }
    [self getData];
}
@end
