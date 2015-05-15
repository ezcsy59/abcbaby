//
//  addQinJiaViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-17.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addQinJiaViewController.h"

#import "youErYuanNetWork.h"

@interface addQinJiaViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,HJHPickerViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyLabel *timeLabel1;
@property(nonatomic,strong)HJHMyLabel *timeLabel2;
@property(nonatomic,strong)HJHPickerView *timePicker;
@property(nonatomic,assign)int timeFlag;
@property(nonatomic,strong)HJHMyButton *sSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_sSelectBtn;
@property(nonatomic,strong)UITextView *liyouTextView;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;
@end

@implementation addQinJiaViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newDutyOffApplySuccess:) name:@"newDutyOffApplySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newDutyOffApplyFail:) name:@"newDutyOffApplyFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)newDutyOffApplySuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    
    
}

-(void)newDutyOffApplyFail:(NSNotification*)noti{
    
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
    return 3;
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
        zuijinLabel.text = @"起始日期:";
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
        btn.tag = 1001;
        [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
    }
    if (indexPath.row == 1) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"结束日期:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        self.timeLabel2 = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 60)];
        self.timeLabel2.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.timeLabel2.text = @"2015-04-18";
        self.timeLabel2.backgroundColor = [UIColor clearColor];
        self.timeLabel2.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.timeLabel2];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.timeLabel2.frame;
        btn.tag = 1002;
        [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"结束日期:";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:zuijinLabel];
        
        self.sSelectBtn = [[HJHMyButton alloc]init];
        self.sSelectBtn.frame = CGRectMake(15 + 65 + 50, 20, 20, 20);
        [self.sSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.sSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.sSelectBtn.selected = YES;
        self.sSelectBtn.tag = 1002;
        [self.sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.sSelectBtn];
        
        self.s_sSelectBtn = [[HJHMyButton alloc]init];
        self.s_sSelectBtn.frame = CGRectMake(15 + 165 + 35, 20, 20, 20);
        [self.s_sSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.s_sSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.s_sSelectBtn.tag = 1001;
        [self.s_sSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.s_sSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100 + 42, 20, 60, 20);
        label13.text = @"事假";
        label13.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label13.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200 + 27, 20, 100, 20);
        label14.text = @"病假";
        label14.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label14.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label14];
    }
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 59.5, 320, 0.5);
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
    NSString *time2 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:self.timeLabel2.text]];
    [youE newDutyOffApplyWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] dateStart:time1 dateEnd:time2 offReason:self.liyouTextView.text offType:@"1" relativesId:[DictionaryStringTool stringFromDictionary:dict forKey:@"relativesId"] childNamePlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformName"]];
}

-(void)selectSexBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        self.s_sSelectBtn.selected = YES;
        self.sSelectBtn.selected = NO;
    }
    else if (btn.tag == 1002){
        self.s_sSelectBtn.selected = NO;
        self.sSelectBtn.selected = YES;
    }
}

-(void)selectViewBtnClick:(HJHMyButton *)btn{
    self.timeFlag = btn.tag;
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
    if (self.timeFlag == 1001) {
        NSArray *array = [area componentsSeparatedByString:@" "];
        self.timeLabel1.text = [array objectAtIndex:0];
    }
    else if (self.timeFlag == 1002){
        NSArray *array = [area componentsSeparatedByString:@" "];
        self.timeLabel2.text = [array objectAtIndex:0];
    }
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}

-(void)hjhCancalbClicked{
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}
@end
