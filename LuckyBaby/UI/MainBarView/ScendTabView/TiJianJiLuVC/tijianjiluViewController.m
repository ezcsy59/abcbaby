//
//  tijianjiluViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-5.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "tijianjiluViewController.h"
#import "jianKangNetWork.h"
#import "addTiJianJiLuViewViewController.h"

@interface tijianjiluViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *tijianArray;
@end

@implementation tijianjiluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"体检记录列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
    
    [self.rigthBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHealthPlatformIndexSuccess:) name:@"listHealthPlatformIndexSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHealthPlatformIndexListFail:) name:@"listHealthPlatformIndexListFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.tijianArray = [NSArray array];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [jianK listHealthPlatformIndexWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] pageSize:@"10" page:@"0"];
}

#pragma mark -logic data
-(void)listHealthPlatformIndexSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if([array isKindOfClass:[NSArray class]]){
        self.tijianArray = array;
    }
    [self._tableView reloadData];
}

-(void)listHealthPlatformIndexListFail:(NSNotification*)noti{
    
}

-(void)setTableView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tijianArray.count;
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
    
    NSDictionary *dic = [self.tijianArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
    zuijinLabel.textColor = [UIColor colorWithHexString:@"666666"];
    NSString *time1 = [DictionaryStringTool stringFromDictionary:dic forKey:@"diagnoseDate"];
    if(time1.length >= 3){
        time1 = [TimeChange timeChage:[time1 substringToIndex:time1.length - 3]];
    }
    NSArray *array = [time1 componentsSeparatedByString:@" "];
    time1 = [array objectAtIndex:0];
    zuijinLabel.text = time1;
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:16];
    zuijinLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:zuijinLabel];
    
    HJHMyLabel *coutLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(220, 0, 100, 60)];
    coutLabel.textColor = [UIColor colorWithHexString:@"666666"];
    coutLabel.backgroundColor = [UIColor clearColor];
    coutLabel.font = [UIFont systemFontOfSize:16];
    coutLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:coutLabel];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 59, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    BinLiXiangQingTableViewCell *qCell=  [[BinLiXiangQingTableViewCell alloc]init];
    //    float f = [qCell getCellHeight:[self.benliBenArray objectAtIndex:indexPath.row]];
    return 60;
}

#pragma mark - btnClick
-(void)addBtnClick{
    addTiJianJiLuViewViewController *aVC = [[addTiJianJiLuViewViewController alloc]init];
    [self.navigationController pushViewController:aVC animated:YES];
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
