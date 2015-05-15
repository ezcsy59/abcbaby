//
//  zidingyiViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-9.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "zidingyiViewController.h"
#import "jianKangNetWork.h"

@interface zidingyiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyTextField *ziDingYi1Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi2Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi3Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi4Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi5Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi6Field;
@end

@implementation zidingyiViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updHealthInfoSelfNameSuccess:) name:@"updHealthInfoSelfNameSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updHealthInfoSelfNameFail:) name:@"updHealthInfoSelfNameFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)updHealthInfoSelfNameSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
}

-(void)updHealthInfoSelfNameFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.headNavView.titleLabel.text = @"自定义项目设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    [self setTableView];
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // Return the number of rows in the section.
    return 6;
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
    
    if (indexPath.row == 0) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目1:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi1Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi1Field.fromRight = 10;
        self.ziDingYi1Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi1Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi1Field.textColor = [UIColor blackColor];
        self.ziDingYi1Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi1Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi1Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 1) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目2:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi2Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi2Field.fromRight = 10;
        self.ziDingYi2Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi2Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi2Field.textColor = [UIColor blackColor];
        self.ziDingYi2Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi2Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi2Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目3:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi3Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi3Field.fromRight = 10;
        self.ziDingYi3Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi3Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi3Field.textColor = [UIColor blackColor];
        self.ziDingYi3Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi3Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi3Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 3) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目4:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi4Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi4Field.fromRight = 10;
        self.ziDingYi4Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi4Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi4Field.textColor = [UIColor blackColor];
        self.ziDingYi4Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi4Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi4Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 4) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目5:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi5Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi5Field.fromRight = 10;
        self.ziDingYi5Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi5Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi5Field.textColor = [UIColor blackColor];
        self.ziDingYi5Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi5Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi5Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 5) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"项目6:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor colorWithHexString:@"0A9B0A"];
        [cell addSubview:label];
        
        self.ziDingYi6Field  = [[HJHMyTextField alloc]init];
        self.ziDingYi6Field.fromRight = 10;
        self.ziDingYi6Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi6Field.frame = CGRectMake(80, 20, 160, 20);
        self.ziDingYi6Field.textColor = [UIColor blackColor];
        self.ziDingYi6Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi6Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi6Field];
        
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

#pragma mark - btnClick
-(void)saveBtnClick{
    NSMutableArray *selfItemName = [NSMutableArray array];
    [selfItemName addObject:self.ziDingYi1Field.text];
    [selfItemName addObject:self.ziDingYi2Field.text];
    [selfItemName addObject:self.ziDingYi3Field.text];
    [selfItemName addObject:self.ziDingYi4Field.text];
    [selfItemName addObject:self.ziDingYi5Field.text];
    [selfItemName addObject:self.ziDingYi6Field.text];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [jianK updHealthInfoSelfNameWithSelfItemName:selfItemName childIdFamily:[dic objectForKey:@"childIdFamilyCurrent"]];
}
@end
