//
//  addZhongDianGuanChaViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-17.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addZhongDianGuanChaViewController.h"

#import "youErYuanNetWork.h"

@interface addZhongDianGuanChaViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,HJHPickerViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyLabel *timeLabel1;
@property(nonatomic,strong)HJHPickerView *timePicker;
@property(nonatomic,strong)UITextView *liyouTextView;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;
@end

@implementation addZhongDianGuanChaViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newCareSuccess:) name:@"newCareSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newCareFail:) name:@"newCareFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)newCareSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    
    
}

-(void)newCareFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"请假";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainTableView];
    
    [self setBgMengCeng];
    // Do any additional setup after loading the view.
}

-(void)setBgMengCeng{
    self.bgMengCeng = [[HJHMyImageView alloc]init];
    self.bgMengCeng.frame = self.view.frame;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.bgMengCeng addGestureRecognizer:tap];
    [self.view addSubview:self.bgMengCeng];
    self.bgMengCeng.userInteractionEnabled = NO;
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 0, 320, 220);
    footImage.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    self._tableView.tableFooterView = footImage;
    
    self.liyouTextView = [[UITextView alloc]init];
    self.liyouTextView.delegate = self;
    self.liyouTextView.frame = CGRectMake(10, 10, 300, 200);
    self.liyouTextView.backgroundColor = [UIColor whiteColor];
    self.liyouTextView.clipsToBounds = YES;
    self.liyouTextView.layer.cornerRadius = 5.0;
    self.liyouTextView.layer.borderColor = [UIColor colorWithHexString:@"C8C7CC"].CGColor;
    self.liyouTextView.layer.borderWidth = 1;
    self.liyouTextView.font = [UIFont systemFontOfSize:18];
    [footImage addSubview:self.liyouTextView];
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
    return 1;
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
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"日期:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        self.timeLabel1 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        self.timeLabel1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.timeLabel1.text = @"2015-04-18";
        self.timeLabel1.backgroundColor = [UIColor clearColor];
        self.timeLabel1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.timeLabel1];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.timeLabel1.frame;
        [btn addTarget:self action:@selector(selectViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 58, 320, 2);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - btnClick
-(void)addData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dict = [plistDataManager getDataWithKey:user_loginList];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    NSString *time1 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:self.timeLabel1.text]];
    [youE newCareWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] careDate:time1 careDesc:self.liyouTextView.text relativesId:[DictionaryStringTool stringFromDictionary:dict forKey:@"relativesId"] childNamePlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformName"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]];
}

-(void)selectViewBtnClick{
    self.timePicker = [[HJHPickerView alloc]init];
    self.timePicker.delegate2 = self;
    [self.view addSubview:self.timePicker];
}

-(void)hideKeyBoard{
    [self.liyouTextView resignFirstResponder];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = NO;
}

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    NSArray *array = [area componentsSeparatedByString:@" "];
    self.timeLabel1.text = [array objectAtIndex:0];
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}

-(void)hjhCancalbClicked{
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}

@end
