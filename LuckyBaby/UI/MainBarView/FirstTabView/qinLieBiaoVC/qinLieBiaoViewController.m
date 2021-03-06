//
//  qinLieBiaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "qinLieBiaoViewController.h"
#import "qinListTableViewCell.h"
#import "qinListTableViewCell2.h"
#import "qinListTableViewCell3.h"
#import "dongtaiNetWork.h"
#import "yaoqingQingViewController.h"
#import "keAddQinViewController.h"
#import "qinMessageViewController.h"

@interface qinLieBiaoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,qinListTableViewCellDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *followQinListArray;
@property(nonatomic,strong)NSArray *unfollowQinListArray;

@property(nonatomic,strong)NSMutableArray *followQinWithOutBabaArray;
@end

@implementation qinLieBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"亲列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(yaoqingQ) forControlEvents:UIControlEventTouchUpInside];
    [self setMainTableView];
//    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [self.followQinWithOutBabaArray removeAllObjects];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyListSuccess:) name:@"getQinListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyListFail:) name:@"getQinListFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    self.followQinListArray = [NSArray array];
    self.unfollowQinListArray = [NSArray array];
    self.followQinWithOutBabaArray = [NSMutableArray array];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 getQinListWithRelativesId:[DictionaryStringTool stringFromDictionary:dic forKey:@"relativesId"] childIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
}

-(void)getBabyListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    NSArray *array = [dict objectForKey:@"followList"];
    NSArray *uArray = [dict objectForKey:@"unFollowList"];
    if (array.count > 0) {
        self.followQinListArray = array;
        for (int i = 0; i < self.followQinListArray.count; i++) {
            NSDictionary *dic = [self.followQinListArray objectAtIndex:i];
            if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"] isEqualToString:@"妈妈"] || [[DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"] isEqualToString:@"爸爸"]) {
            }
            else{
                [self.followQinWithOutBabaArray addObject:dic];
            }
        }
    }
    if (uArray.count > 0) {
        self.unfollowQinListArray = uArray;
    }
    [self._tableView reloadData];
}

-(void)getBabyListFail:(NSNotification*)noti{
    
}

#pragma mark - btnClick
-(void)yaoqingQ{
    yaoqingQingViewController *yaoQV = [[yaoqingQingViewController alloc]init];
    [self.navigationController pushViewController:yaoQV animated:YES];
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
    return 2 + self.followQinWithOutBabaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 0) {
        cell = [[qinListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 1) {
        cell = [[qinListTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row >= 2) {
        cell = [[qinListTableViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        qinListTableViewCell * qCell = (qinListTableViewCell*)cell;
        [qCell setDefualt];
        qCell.delegate2 = self;
        for (int i = 0; i < self.followQinListArray.count; i++) {
            NSDictionary *dic = [self.followQinListArray objectAtIndex:i];
            if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"] isEqualToString:@"妈妈"]) {
                qCell.leftLabel3.hidden = NO;
                qCell.leftLabel1.hidden = NO;
                qCell.leftLabel1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"];
                qCell.leftLabel2.hidden = YES;
                qCell.leftRec = [DictionaryStringTool stringFromDictionary:dic forKey:@"recId"];
                NSString *time =[TimeChange timeChage:[DictionaryStringTool stringFromDictionary:dic forKey:@"lastTime"]];
                NSArray *timeA = [time componentsSeparatedByString:@" "];
                NSString *timeS = @"";
                if (timeA.count > 0) {
                    timeS = [timeA objectAtIndex:0];
                }
                qCell.leftLabel3.text = [NSString stringWithFormat:@"最近访问日期:%@",timeS];
                
                [qCell.leftImageView setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"]] placeholderImage:nil];
            }
            else if([[DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"] isEqualToString:@"爸爸"]){
                qCell.rightLabel3.hidden = NO;
                qCell.rightLabel1.hidden = NO;
                qCell.rightLabel1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"];
                qCell.rightLabel2.hidden = YES;
                qCell.RightRec = [DictionaryStringTool stringFromDictionary:dic forKey:@"recId"];
                NSString *time =[TimeChange timeChage:[DictionaryStringTool stringFromDictionary:dic forKey:@"lastTime"]];
                NSArray *timeA = [time componentsSeparatedByString:@" "];
                NSString *timeS = @"";
                if (timeA.count > 0) {
                    timeS = [timeA objectAtIndex:0];
                }
                qCell.rightLabel3.text = [NSString stringWithFormat:@"最近访问日期:%@",timeS];
                [qCell.rightImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"]] placeholderImage:nil];
            }
        }
    }
    if (indexPath.row == 1) {
        qinListTableViewCell2 * qCell = (qinListTableViewCell2*)cell;
    }
    if (indexPath.row >= 2) {
        qinListTableViewCell3 * qCell = (qinListTableViewCell3*)cell;
        NSDictionary *dic = [self.followQinWithOutBabaArray objectAtIndex:indexPath.row - 2];
        [qCell.leftImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"]] placeholderImage:nil];
        qCell.leftLabel1 = [DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"];
        NSString *time =[TimeChange timeChage:[DictionaryStringTool stringFromDictionary:dic forKey:@"lastTime"]];
        NSArray *timeA = [time componentsSeparatedByString:@" "];
        NSString *timeS = @"";
        if (timeA.count > 0) {
            timeS = [timeA objectAtIndex:0];
        }
        qCell.leftLabel2.text = [NSString stringWithFormat:@"最近访问日期:%@",timeS];

    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }
    if (indexPath.row == 1) {
        return 40;
    }
    if(indexPath.row >= 2){
        return 80;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        keAddQinViewController *kVC = [[keAddQinViewController alloc]init];
        [self.navigationController pushViewController:kVC animated:YES];
    }
    if (indexPath.row >= 2) {
        NSDictionary *dic = [self.followQinWithOutBabaArray objectAtIndex:indexPath.row - 2];
        NSString *recId = [DictionaryStringTool stringFromDictionary:dic forKey:@"recId"];
        NSString *nickName = [DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"];
        qinMessageViewController *yVC = [[qinMessageViewController alloc]initWithRecId:recId nickName:nickName];
        [self.navigationController pushViewController:yVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - qinListTableViewCellDelegate
-(void)leftBtnClick:(BOOL)haveMan recId:(NSString *)recId nickName:(NSString *)nickName{
    if (haveMan) {
        qinMessageViewController *yVC = [[qinMessageViewController alloc]initWithRecId:recId nickName:nickName];
        [self.navigationController pushViewController:yVC animated:YES];
    }
    else{
        yaoqingQingViewController *yVC = [[yaoqingQingViewController alloc]init];
        [self.navigationController pushViewController:yVC animated:YES];
    }
}

-(void)rightBtnClick:(BOOL)haveMan recId:(NSString *)recId nickName:(NSString *)nickName{
    if (haveMan) {
        qinMessageViewController *yVC = [[qinMessageViewController alloc]initWithRecId:recId nickName:nickName];
        [self.navigationController pushViewController:yVC animated:YES];
    }
    else{
        yaoqingQingViewController *yVC = [[yaoqingQingViewController alloc]init];
        [self.navigationController pushViewController:yVC animated:YES];
    }
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
