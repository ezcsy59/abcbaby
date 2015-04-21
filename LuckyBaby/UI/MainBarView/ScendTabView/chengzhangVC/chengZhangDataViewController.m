//
//  chengZhangDataViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "chengZhangDataViewController.h"
#import "jianKangNetWork.h"
#import "chengZhangDataTableViewCell.h"
#import "addChengZhangDataViewController.h"

@interface chengZhangDataViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *chengZhangDataArray;

@end

@implementation chengZhangDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (iPhone5?568:480)) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.backgroundColor = [UIColor whiteColor];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHealthInfoSuccess:) name:@"listHealthInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHealthInfoFail:) name:@"listHealthInfoFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    self.chengZhangDataArray = [NSArray array];
    jianKangNetWork *jianKangNetWork1 = [[jianKangNetWork alloc]init];
    [jianKangNetWork1 listHealthInfoWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:@"0" pageSize:@"10"];
}

-(void)listHealthInfoSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.chengZhangDataArray = array;
    }
    [self._tableView reloadData];
}

-(void)listHealthInfoFail:(NSNotification*)noti{
    
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
    if (self.chengZhangDataArray.count > 0) {
        return self.chengZhangDataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[chengZhangDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    chengZhangDataTableViewCell *dCell = (chengZhangDataTableViewCell*)cell;
    dCell.leftLabel3.text = [DictionaryStringTool stringFromDictionary:[self.chengZhangDataArray objectAtIndex:indexPath.row] forKey:@"height"];
    dCell.leftLabel4.text = [DictionaryStringTool stringFromDictionary:[self.chengZhangDataArray objectAtIndex:indexPath.row] forKey:@"weight"];
    NSString *time = [DictionaryStringTool stringFromDictionary:[self.chengZhangDataArray objectAtIndex:indexPath.row] forKey:@"createdDate"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:(time.length - 3)]];
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    dCell.leftLabel6.text = [array objectAtIndex:0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    addChengZhangDataViewController *zVC = [[addChengZhangDataViewController alloc]initWithStyle:1 chengZhangDic:[self.chengZhangDataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:zVC animated:YES];
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
