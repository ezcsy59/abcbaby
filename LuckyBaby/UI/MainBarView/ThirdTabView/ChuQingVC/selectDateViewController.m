//
//  selectDateViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-17.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "selectDateViewController.h"
#import "youErYuanNetWork.h"

@interface selectDateViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *qingjiaListArray;
@end

@implementation selectDateViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDutyInspectionSuccess:) name:@"getDutyInspectionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDutyInspectionFail:) name:@"getDutyInspectionFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youE getDutyInspectionWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] dateStart:@"0" dateEnd:@"0"];;
}

-(void)getDutyInspectionSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    
}

-(void)getDutyInspectionFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qingjiaListArray = [NSArray array];
    self.headNavView.titleLabel.text = @"出勤详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    return 4;
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
    if (indexPath.row == 0) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
        zuijinLabel.text = @"入园时间:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label1.text = @"2015-04-18";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label1];
    }
    if (indexPath.row == 1) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
        zuijinLabel.text = @"离园时间:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label1.text = @"";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label1];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 170, 60)];
        zuijinLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
        zuijinLabel.text = @"是否由家长带回:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label1.text = @"";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label1];
    }
    if (indexPath.row == 3) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
        zuijinLabel.text = @"晨检关怀:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        label1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label1.text = @"";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label1];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
