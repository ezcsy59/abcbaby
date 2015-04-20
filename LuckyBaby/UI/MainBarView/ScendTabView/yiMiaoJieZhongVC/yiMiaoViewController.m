//
//  yiMiaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "yiMiaoViewController.h"
#import "jianKangNetWork.h"
#import "yiMiaoTableViewCell.h"
#import "addYiMiaoViewController.h"

@interface yiMiaoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,KGSelectViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *yiMiaoListArray;

@end

@implementation yiMiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"疫苗接种";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self setMainTableView];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addYiMiaoListShwo) forControlEvents:UIControlEventTouchUpInside];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listVaccinumSuccess:) name:@"listVaccinumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listVaccinumFail:) name:@"listVaccinumFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    self.yiMiaoListArray = [NSArray array];
    jianKangNetWork *jianKangNetWork1 = [[jianKangNetWork alloc]init];
    [jianKangNetWork1 listVaccinumWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
}

-(void)listVaccinumSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];

    if ([array isKindOfClass:[NSArray class]]) {
        self.yiMiaoListArray = array;
    }
    [self._tableView reloadData];
}

-(void)listVaccinumFail:(NSNotification*)noti{
    
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
    return self.yiMiaoListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[yiMiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    yiMiaoTableViewCell *qCell = (yiMiaoTableViewCell*)cell;
    NSDictionary *dic = [self.yiMiaoListArray objectAtIndex:indexPath.row];
    qCell.leftLabel1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacName"];
    qCell.leftLabel2.text = [NSString stringWithFormat:@"%@月龄",[DictionaryStringTool stringFromDictionary:dic forKey:@"vacAge"]];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"vacName"]integerValue] == 0) {
        qCell.rightLabel.text = @"未接种";
    }
    else{
        qCell.rightLabel.text = @"已接种";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.yiMiaoListArray objectAtIndex:indexPath.row];
    NSString *stirng = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacDocId"];
    NSString *vacName = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacName"];
    NSString *isDone = [DictionaryStringTool stringFromDictionary:dic forKey:@"isDone"];
    NSString *vacDate = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacDate"];
    addYiMiaoViewController *yVC = [[addYiMiaoViewController alloc]initWithVacDocId:stirng vacName:vacName vacDate:vacDate isDone:isDone];
    [self.navigationController pushViewController:yVC animated:YES];
}

#pragma mark - btnClick
-(void)addYiMiaoListShwo{
    NSMutableArray *yiMiaoArray = [NSMutableArray array];
    for (NSDictionary *dic in self.yiMiaoListArray) {
        NSString *stirng = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacName"];
        [yiMiaoArray addObject:stirng];
    }
    KGSelectView *sV = [[KGSelectView alloc]initWithDictionary:yiMiaoArray withTitile:@"疫苗档案"];
    sV.delegate2 = self;
    [self.view addSubview:sV];
}

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    NSDictionary *dic = [self.yiMiaoListArray objectAtIndex:tag];
    NSString *stirng = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacDocId"];
    NSString *vacName = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacName"];
    NSString *isDone = [DictionaryStringTool stringFromDictionary:dic forKey:@"isDone"];
    NSString *vacDate = [DictionaryStringTool stringFromDictionary:dic forKey:@"vacDate"];
    addYiMiaoViewController *yVC = [[addYiMiaoViewController alloc]initWithVacDocId:stirng vacName:vacName vacDate:vacDate isDone:isDone];
    [self.navigationController pushViewController:yVC animated:YES];
}

-(void)cancalSelectClicked{
    
}
@end
