//
//  addTiJianJiLuViewViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-9.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addTiJianJiLuViewViewController.h"
#import "jianKangNetWork.h"

@interface addTiJianJiLuViewViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,HJHPickerViewDelegate,KGSelectViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;

@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;
@property(nonatomic,strong)HJHMyTextField *textField4;
@property(nonatomic,strong)HJHMyTextField *textField5;
@property(nonatomic,strong)HJHMyTextField *textField6;
@property(nonatomic,strong)HJHMyTextField *textField7;
@property(nonatomic,strong)HJHMyTextField *textField8;
@property(nonatomic,strong)HJHMyTextField *textField9;
@property(nonatomic,strong)HJHMyTextField *textField10;
@property(nonatomic,strong)HJHMyTextField *textField11;
@property(nonatomic,strong)HJHMyTextField *textField12;
@property(nonatomic,strong)HJHMyTextField *textField13;
@property(nonatomic,strong)HJHMyTextField *textField14;
@property(nonatomic,strong)HJHMyTextField *textField15;
@property(nonatomic,strong)HJHMyTextField *textField16;
@property(nonatomic,strong)HJHMyTextField *textField17;
@property(nonatomic,strong)HJHMyTextField *textField18;
@property(nonatomic,strong)HJHMyTextField *textField19;
@property(nonatomic,strong)HJHMyTextField *textField20;
@property(nonatomic,strong)HJHMyTextField *textField21;
@property(nonatomic,strong)HJHMyTextField *textField22;
@property(nonatomic,strong)HJHMyTextField *textField23;
@property(nonatomic,strong)HJHMyTextField *textField24;
@property(nonatomic,strong)HJHMyTextField *textField25;
@property(nonatomic,strong)HJHMyTextField *textField26;
@property(nonatomic,strong)HJHMyTextField *textField27;
@property(nonatomic,strong)HJHMyTextField *textField28;
@property(nonatomic,strong)HJHMyTextField *textField29;

@property(nonatomic,strong)HJHMyButton *hSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_hSelectBtn;
@property(nonatomic,strong)HJHMyButton *eSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_eSelectBtn;
@property(nonatomic,strong)HJHMyButton *erSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_erSelectBtn;
@property(nonatomic,strong)HJHMyButton *mSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_mSelectBtn;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;

@property(nonatomic,strong)HJHPickerView *sV;

@property(nonatomic,strong)KGSelectView *relationSV;

@property(nonatomic,assign)int selectTag;
@end

@implementation addTiJianJiLuViewViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyhide) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHealthPlatformSuccess:) name:@"saveHealthPlatformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHealthPlatformFail:) name:@"saveHealthPlatformFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)saveHealthPlatformSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
}

-(void)saveHealthPlatformFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"新增体检记录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.rigthBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTableView];
    
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

-(void)hideKeyBoard{
    if([self.textField1 isKindOfClass:[HJHMyTextField class]]){
        [self.textField1 resignFirstResponder];
    }
    if([self.textField2 isKindOfClass:[HJHMyTextField class]]){
        [self.textField2 resignFirstResponder];
    }
    if([self.textField3 isKindOfClass:[HJHMyTextField class]]){
        [self.textField3 resignFirstResponder];
    }
    if([self.textField4 isKindOfClass:[HJHMyTextField class]]){
        [self.textField4 resignFirstResponder];
    }
    if([self.textField5 isKindOfClass:[HJHMyTextField class]]){
        [self.textField5 resignFirstResponder];
    }
    if([self.textField6 isKindOfClass:[HJHMyTextField class]]){
        [self.textField6 resignFirstResponder];
    }
    if([self.textField7 isKindOfClass:[HJHMyTextField class]]){
        [self.textField7 resignFirstResponder];
    }
    if([self.textField8 isKindOfClass:[HJHMyTextField class]]){
        [self.textField8 resignFirstResponder];
    }
    if([self.textField9 isKindOfClass:[HJHMyTextField class]]){
        [self.textField9 resignFirstResponder];
    }
    if([self.textField10 isKindOfClass:[HJHMyTextField class]]){
        [self.textField10 resignFirstResponder];
    }
    if([self.textField11 isKindOfClass:[HJHMyTextField class]]){
        [self.textField11 resignFirstResponder];
    }
    if([self.textField12 isKindOfClass:[HJHMyTextField class]]){
        [self.textField12 resignFirstResponder];
    }
    if([self.textField13 isKindOfClass:[HJHMyTextField class]]){
        [self.textField13 resignFirstResponder];
    }
    if([self.textField14 isKindOfClass:[HJHMyTextField class]]){
        [self.textField14 resignFirstResponder];
    }
    if([self.textField15 isKindOfClass:[HJHMyTextField class]]){
        [self.textField15 resignFirstResponder];
    }
    if([self.textField16 isKindOfClass:[HJHMyTextField class]]){
        [self.textField16 resignFirstResponder];
    }
    if([self.textField17 isKindOfClass:[HJHMyTextField class]]){
        [self.textField17 resignFirstResponder];
    }
    if([self.textField18 isKindOfClass:[HJHMyTextField class]]){
        [self.textField18 resignFirstResponder];
    }
    if([self.textField19 isKindOfClass:[HJHMyTextField class]]){
        [self.textField19 resignFirstResponder];
    }
    if([self.textField20 isKindOfClass:[HJHMyTextField class]]){
        [self.textField20 resignFirstResponder];
    }
    if([self.textField21 isKindOfClass:[HJHMyTextField class]]){
        [self.textField21 resignFirstResponder];
    }
    if([self.textField22 isKindOfClass:[HJHMyTextField class]]){
        [self.textField22 resignFirstResponder];
    }
    if([self.textField23 isKindOfClass:[HJHMyTextField class]]){
        [self.textField23 resignFirstResponder];
    }
    if([self.textField24 isKindOfClass:[HJHMyTextField class]]){
        [self.textField24 resignFirstResponder];
    }
    if([self.textField25 isKindOfClass:[HJHMyTextField class]]){
        [self.textField25 resignFirstResponder];
    }
    if([self.textField26 isKindOfClass:[HJHMyTextField class]]){
        [self.textField26 resignFirstResponder];
    }
    if([self.textField27 isKindOfClass:[HJHMyTextField class]]){
        [self.textField27 resignFirstResponder];
    }
    if([self.textField28 isKindOfClass:[HJHMyTextField class]]){
        [self.textField28 resignFirstResponder];
    }
    if([self.textField29 isKindOfClass:[HJHMyTextField class]]){
        [self.textField29 resignFirstResponder];
    }
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
    return 29;
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
    if (indexPath.row == 0) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"检查日期";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField1) {
            self.textField1 = [[HJHMyTextField alloc]init];
        }
        self.textField1.frame = CGRectMake(200, 20, 100, 20);
        self.textField1.fromRight = 8;
        self.textField1.layer.cornerRadius = 5.0;
        self.textField1.backgroundColor = [UIColor whiteColor];
        self.textField1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField1];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.textField1.frame;
        [btn addTarget:self action:@selector(riqiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    if (indexPath.row == 1) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"身高(cm)";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField2) {
            self.textField2 = [[HJHMyTextField alloc]init];
        }
        self.textField2.frame = CGRectMake(200, 20, 100, 20);
        self.textField2.fromRight = 8;
        self.textField2.layer.cornerRadius = 5.0;
        self.textField2.backgroundColor = [UIColor whiteColor];
        self.textField2.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField2];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"身高评价";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        self.hSelectBtn = [[HJHMyButton alloc]init];
        self.hSelectBtn.frame = CGRectMake(15 + 65 + 50, 20, 20, 20);
        [self.hSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.hSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.hSelectBtn.selected = YES;
        self.hSelectBtn.tag = 1002;
        [self.hSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.hSelectBtn];
        
        self.s_hSelectBtn = [[HJHMyButton alloc]init];
        self.s_hSelectBtn.frame = CGRectMake(15 + 165 + 35, 20, 20, 20);
        [self.s_hSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.s_hSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.s_hSelectBtn.tag = 1001;
        [self.s_hSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.s_hSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100 + 42, 20, 60, 20);
        label13.text = @"正常";
        label13.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label13.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200 + 27, 20, 100, 20);
        label14.text = @"发育缓慢";
        label14.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label14.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label14];
    }
    if (indexPath.row == 3) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"体重(Kg)";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField3) {
            self.textField3 = [[HJHMyTextField alloc]init];
        }
        self.textField3.frame = CGRectMake(200, 20, 100, 20);
        self.textField3.fromRight = 8;
        self.textField3.layer.cornerRadius = 5.0;
        self.textField3.backgroundColor = [UIColor whiteColor];
        self.textField3.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField3];
    }
    if (indexPath.row == 4) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"体重评价";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField4) {
            self.textField4 = [[HJHMyTextField alloc]init];
        }
        self.textField4.frame = CGRectMake(200, 20, 100, 20);
        self.textField4.fromRight = 8;
        self.textField4.layer.cornerRadius = 5.0;
        self.textField4.text = @"正常";
        self.textField4.backgroundColor = [UIColor whiteColor];
        self.textField4.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField4];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.textField4.frame;
        btn.tag = 1001;
        [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    if (indexPath.row == 5) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"牙齿";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"总数:";
        label2.font = [UIFont systemFontOfSize:13];
        label2.frame = CGRectMake(80, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"龋齿:";
        label3.font = [UIFont systemFontOfSize:13];
        label3.frame = CGRectMake(190, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        if (!self.textField5) {
            self.textField5 = [[HJHMyTextField alloc]init];
        }
        self.textField5.font = [UIFont systemFontOfSize:13];
        self.textField5.frame = CGRectMake(120, 20, 65, 20);
        self.textField5.textColor = [UIColor blackColor];
        self.textField5.backgroundColor = [UIColor whiteColor];
        self.textField5.keyboardType = UIKeyboardTypeNumberPad;
        self.textField5.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField5];
        
        if (!self.textField6) {
            self.textField6 = [[HJHMyTextField alloc]init];
        }
        self.textField6.font = [UIFont systemFontOfSize:13];
        self.textField6.frame = CGRectMake(235, 20, 65, 20);
        self.textField6.textColor = [UIColor blackColor];
        self.textField6.backgroundColor = [UIColor whiteColor];
        self.textField6.keyboardType = UIKeyboardTypeNumberPad;
        self.textField6.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField6];
    }
    if (indexPath.row == 6) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"眼睛";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"左眼:";
        label2.font = [UIFont systemFontOfSize:13];
        label2.frame = CGRectMake(80, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"右眼:";
        label3.font = [UIFont systemFontOfSize:13];
        label3.frame = CGRectMake(190, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        if (!self.textField7) {
            self.textField7 = [[HJHMyTextField alloc]init];
        }
        self.textField7.font = [UIFont systemFontOfSize:13];
        self.textField7.frame = CGRectMake(120, 20, 65, 20);
        self.textField7.textColor = [UIColor blackColor];
        self.textField7.backgroundColor = [UIColor whiteColor];
        self.textField7.keyboardType = UIKeyboardTypeNumberPad;
        self.textField7.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField7];
        
        if (!self.textField8) {
            self.textField8 = [[HJHMyTextField alloc]init];
        }
        self.textField8.font = [UIFont systemFontOfSize:13];
        self.textField8.frame = CGRectMake(235, 20, 65, 20);
        self.textField8.textColor = [UIColor blackColor];
        self.textField8.backgroundColor = [UIColor whiteColor];
        self.textField8.keyboardType = UIKeyboardTypeNumberPad;
        self.textField8.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField8];
    }
    if (indexPath.row == 7) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"视力";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"左眼:";
        label2.font = [UIFont systemFontOfSize:13];
        label2.frame = CGRectMake(80, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"右眼:";
        label3.font = [UIFont systemFontOfSize:13];
        label3.frame = CGRectMake(190, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        if (!self.textField9) {
            self.textField9 = [[HJHMyTextField alloc]init];
        }
        self.textField9.font = [UIFont systemFontOfSize:13];
        self.textField9.frame = CGRectMake(120, 20, 65, 20);
        self.textField9.textColor = [UIColor blackColor];
        self.textField9.backgroundColor = [UIColor whiteColor];
        self.textField9.keyboardType = UIKeyboardTypeNumberPad;
        self.textField9.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField9];
        
        if (!self.textField10) {
            self.textField10 = [[HJHMyTextField alloc]init];
        }
        self.textField10.font = [UIFont systemFontOfSize:13];
        self.textField10.frame = CGRectMake(235, 20, 65, 20);
        self.textField10.textColor = [UIColor blackColor];
        self.textField10.backgroundColor = [UIColor whiteColor];
        self.textField10.keyboardType = UIKeyboardTypeNumberPad;
        self.textField10.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField10];
    }
    if (indexPath.row == 8) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.text = @"视力评价";
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];

        self.eSelectBtn = [[HJHMyButton alloc]init];
        self.eSelectBtn.frame = CGRectMake(15 + 65 + 50, 20, 20, 20);
        [self.eSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.eSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.eSelectBtn.selected = YES;
        self.eSelectBtn.tag = 1004;
        [self.eSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.eSelectBtn];
        
        self.s_eSelectBtn = [[HJHMyButton alloc]init];
        self.s_eSelectBtn.frame = CGRectMake(15 + 165 + 35, 20, 20, 20);
        [self.s_eSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.s_eSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.s_eSelectBtn.tag = 1003;
        [self.s_eSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.s_eSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100 + 42, 20, 60, 20);
        label13.text = @"正常";
        label13.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label13.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200 + 27, 20, 100, 20);
        label14.text = @"低视力";
        label14.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label14.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label14];

    }
    if (indexPath.row == 9) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"过敏源";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField11) {
            self.textField11 = [[HJHMyTextField alloc]init];
        }
        self.textField11.frame = CGRectMake(170, 20, 130, 20);
        self.textField11.fromRight = 8;
        self.textField11.layer.cornerRadius = 5.0;
        self.textField11.backgroundColor = [UIColor whiteColor];
        self.textField11.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField11];
    }
    if (indexPath.row == 10) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"既往病史";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField12) {
            self.textField12 = [[HJHMyTextField alloc]init];
        }
        self.textField12.frame = CGRectMake(200, 20, 100, 20);
        self.textField12.fromRight = 8;
        self.textField12.layer.cornerRadius = 5.0;
        self.textField12.text = @"无";
        self.textField12.backgroundColor = [UIColor whiteColor];
        self.textField12.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField12];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.textField12.frame;
        btn.tag = 1002;
        [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    if (indexPath.row == 11) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"皮肤";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField13) {
            self.textField13 = [[HJHMyTextField alloc]init];
        }
        self.textField13.frame = CGRectMake(170, 20, 130, 20);
        self.textField13.fromRight = 8;
        self.textField13.layer.cornerRadius = 5.0;
        self.textField13.backgroundColor = [UIColor whiteColor];
        self.textField13.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField13];
    }
    if (indexPath.row == 12) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"耳朵";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"左耳:";
        label2.font = [UIFont systemFontOfSize:13];
        label2.frame = CGRectMake(80, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"右耳:";
        label3.font = [UIFont systemFontOfSize:13];
        label3.frame = CGRectMake(190, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        if (!self.textField14) {
            self.textField14 = [[HJHMyTextField alloc]init];
        }
        self.textField14.font = [UIFont systemFontOfSize:13];
        self.textField14.frame = CGRectMake(120, 20, 65, 20);
        self.textField14.textColor = [UIColor blackColor];
        self.textField14.backgroundColor = [UIColor whiteColor];
        self.textField14.keyboardType = UIKeyboardTypeNumberPad;
        self.textField14.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField14];
        
        if (!self.textField15) {
            self.textField15 = [[HJHMyTextField alloc]init];
        }
        self.textField15.font = [UIFont systemFontOfSize:13];
        self.textField15.frame = CGRectMake(235, 20, 65, 20);
        self.textField15.textColor = [UIColor blackColor];
        self.textField15.backgroundColor = [UIColor whiteColor];
        self.textField15.keyboardType = UIKeyboardTypeNumberPad;
        self.textField15.layer.cornerRadius = 5.0;
        [cell addSubview:self.textField15];
    }
    if (indexPath.row == 13) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.text = @"听力评价";
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        self.erSelectBtn = [[HJHMyButton alloc]init];
        self.erSelectBtn.frame = CGRectMake(15 + 65 + 50, 20, 20, 20);
        [self.erSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.erSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.erSelectBtn.selected = YES;
        self.erSelectBtn.tag = 1006;
        [self.erSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.erSelectBtn];
        
        self.s_erSelectBtn = [[HJHMyButton alloc]init];
        self.s_erSelectBtn.frame = CGRectMake(15 + 165 + 35, 20, 20, 20);
        [self.s_erSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.s_erSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.s_erSelectBtn.tag = 1005;
        [self.s_erSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.s_erSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100 + 42, 20, 60, 20);
        label13.text = @"正常";
        label13.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label13.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200 + 27, 20, 100, 20);
        label14.text = @"低听力";
        label14.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label14.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label14];
    }
    if (indexPath.row == 14) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"头颅";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField16) {
            self.textField16 = [[HJHMyTextField alloc]init];
        }
        self.textField16.frame = CGRectMake(200, 20, 100, 20);
        self.textField16.fromRight = 8;
        self.textField16.layer.cornerRadius = 5.0;
        self.textField16.backgroundColor = [UIColor whiteColor];
        self.textField16.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField16];
    }
    if (indexPath.row == 15) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"胸廊";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField17) {
            self.textField17 = [[HJHMyTextField alloc]init];
        }
        self.textField17.frame = CGRectMake(200, 20, 100, 20);
        self.textField17.fromRight = 8;
        self.textField17.layer.cornerRadius = 5.0;
        self.textField17.backgroundColor = [UIColor whiteColor];
        self.textField17.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField17];
    }
    if (indexPath.row == 16) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"脊柱四肢";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField18) {
            self.textField18 = [[HJHMyTextField alloc]init];
        }
        self.textField18.frame = CGRectMake(200, 20, 100, 20);
        self.textField18.fromRight = 8;
        self.textField18.layer.cornerRadius = 5.0;
        self.textField18.backgroundColor = [UIColor whiteColor];
        self.textField18.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField18];
    }
    if (indexPath.row == 17) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"心肺";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField19) {
            self.textField19 = [[HJHMyTextField alloc]init];
        }
        self.textField19.frame = CGRectMake(200, 20, 100, 20);
        self.textField19.fromRight = 8;
        self.textField19.layer.cornerRadius = 5.0;
        self.textField19.backgroundColor = [UIColor whiteColor];
        self.textField19.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField19];
    }
    if (indexPath.row == 18) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"喉部";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField20) {
            self.textField20 = [[HJHMyTextField alloc]init];
        }
        self.textField20.frame = CGRectMake(200, 20, 100, 20);
        self.textField20.fromRight = 8;
        self.textField20.layer.cornerRadius = 5.0;
        self.textField20.backgroundColor = [UIColor whiteColor];
        self.textField20.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField20];
    }
    if (indexPath.row == 19) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"肝脾";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField21) {
            self.textField21 = [[HJHMyTextField alloc]init];
        }
        self.textField21.frame = CGRectMake(200, 20, 100, 20);
        self.textField21.fromRight = 8;
        self.textField21.layer.cornerRadius = 5.0;
        self.textField21.backgroundColor = [UIColor whiteColor];
        self.textField21.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField21];
    }
    if (indexPath.row == 20) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"外生殖器";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField22) {
            self.textField22 = [[HJHMyTextField alloc]init];
        }
        self.textField22.frame = CGRectMake(200, 20, 100, 20);
        self.textField22.fromRight = 8;
        self.textField22.layer.cornerRadius = 5.0;
        self.textField22.backgroundColor = [UIColor whiteColor];
        self.textField22.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField22];
    }
    if (indexPath.row == 21) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"体格检查其他";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField23) {
            self.textField23 = [[HJHMyTextField alloc]init];
        }
        self.textField23.frame = CGRectMake(200, 20, 100, 20);
        self.textField23.fromRight = 8;
        self.textField23.layer.cornerRadius = 5.0;
        self.textField23.backgroundColor = [UIColor whiteColor];
        self.textField23.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField23];
    }
    if (indexPath.row == 22) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"血红蛋白(Hb)";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField24) {
            self.textField24 = [[HJHMyTextField alloc]init];
        }
        self.textField24.frame = CGRectMake(200, 20, 100, 20);
        self.textField24.fromRight = 8;
        self.textField24.layer.cornerRadius = 5.0;
        self.textField24.text = @"未检测";
        self.textField24.backgroundColor = [UIColor whiteColor];
        self.textField24.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField24];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.textField24.frame;
        btn.tag = 1003;
        [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    if (indexPath.row == 23) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 170, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"丙氨酸氨基转移酶(ALT)";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        self.mSelectBtn = [[HJHMyButton alloc]init];
        self.mSelectBtn.frame = CGRectMake(15 + 65 + 95, 20, 20, 20);
        [self.mSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.mSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.mSelectBtn.selected = YES;
        self.mSelectBtn.tag = 1008;
        [self.mSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.mSelectBtn];
        
        self.s_mSelectBtn = [[HJHMyButton alloc]init];
        self.s_mSelectBtn.frame = CGRectMake(15 + 165 + 65, 20, 20, 20);
        [self.s_mSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.s_mSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.s_mSelectBtn.tag = 1007;
        [self.s_mSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.s_mSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100 + 87, 20, 60, 20);
        label13.text = @"正常";
        label13.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label13.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200 + 57, 20, 100, 20);
        label14.text = @"异常";
        label14.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        label14.font = [UIFont systemFontOfSize:18];
        [cell addSubview:label14];
    }
    if (indexPath.row == 24) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"辅助检查其他";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField25) {
            self.textField25 = [[HJHMyTextField alloc]init];
        }
        self.textField25.frame = CGRectMake(200, 20, 100, 20);
        self.textField25.fromRight = 8;
        self.textField25.layer.cornerRadius = 5.0;
        self.textField25.backgroundColor = [UIColor whiteColor];
        self.textField25.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField25];
    }
    if (indexPath.row == 25) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"检查结果";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField26) {
            self.textField26 = [[HJHMyTextField alloc]init];
        }
        self.textField26.frame = CGRectMake(200, 20, 100, 20);
        self.textField26.fromRight = 8;
        self.textField26.layer.cornerRadius = 5.0;
        self.textField26.backgroundColor = [UIColor whiteColor];
        self.textField26.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField26];
    }
    if (indexPath.row == 26) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"医生意见";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField27) {
            self.textField27 = [[HJHMyTextField alloc]init];
        }
        self.textField27.frame = CGRectMake(170, 20, 130, 20);
        self.textField27.fromRight = 8;
        self.textField27.layer.cornerRadius = 5.0;
        self.textField27.backgroundColor = [UIColor whiteColor];
        self.textField27.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField27];
    }
    if (indexPath.row == 27) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"医生名字";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField28) {
            self.textField28 = [[HJHMyTextField alloc]init];
        }
        self.textField28.frame = CGRectMake(200, 20, 100, 20);
        self.textField28.fromRight = 8;
        self.textField28.layer.cornerRadius = 5.0;
        self.textField28.backgroundColor = [UIColor whiteColor];
        self.textField28.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField28];
    }
    if (indexPath.row == 28) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"检查单位";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField29) {
            self.textField29 = [[HJHMyTextField alloc]init];
        }
        self.textField29.frame = CGRectMake(200, 20, 100, 20);
        self.textField29.fromRight = 8;
        self.textField29.layer.cornerRadius = 5.0;
        self.textField29.backgroundColor = [UIColor whiteColor];
        self.textField29.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField29];
    }
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 59.5, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    }
    else{
        cell.backgroundColor =[UIColor colorWithHexString:@"f9f9f9"];
    }
    
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    self.textField5.delegate = self;
    self.textField6.delegate = self;
    self.textField7.delegate = self;
    self.textField8.delegate = self;
    self.textField9.delegate = self;
    self.textField10.delegate = self;
    self.textField11.delegate = self;
    self.textField12.delegate = self;
    self.textField13.delegate = self;
    self.textField14.delegate = self;
    self.textField15.delegate = self;
    self.textField16.delegate = self;
    self.textField17.delegate = self;
    self.textField18.delegate = self;
    self.textField19.delegate = self;
    self.textField20.delegate = self;
    self.textField21.delegate = self;
    self.textField22.delegate = self;
    self.textField23.delegate = self;
    self.textField24.delegate = self;
    self.textField25.delegate = self;
    self.textField26.delegate = self;
    self.textField27.delegate = self;
    self.textField28.delegate = self;
    self.textField29.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    BinLiXiangQingTableViewCell *qCell=  [[BinLiXiangQingTableViewCell alloc]init];
    //    float f = [qCell getCellHeight:[self.benliBenArray objectAtIndex:indexPath.row]];
    return 60 ;
}

#pragma mark - btnClick
-(void)riqiBtnClick{
    self.sV = [[HJHPickerView alloc]init];
    self.sV.delegate2 = self;
    [self.view addSubview:self.sV];
}

-(void)selectViewBtnClick:(HJHMyButton *)btn{
    if (btn.tag == 1001) {
        self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:@[@"正常",@"低体重",@"消瘦",@"肥胖"]]];
        self.relationSV.delegate2 = self;
        [self.view addSubview:self.relationSV];
        self.selectTag = 10001;
    }
    if (btn.tag == 1002) {
        self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:@[@"无",@"先天性心脏病",@"癫痫",@"高热惊厥",@"哮喘",@"其他"]]];
        self.relationSV.delegate2 = self;
        [self.view addSubview:self.relationSV];
        self.selectTag = 10002;
    }
    if (btn.tag == 1003) {
        self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:@[@"未检测",@"正常",@"低度贫血",@"中度贫血",@"重度贫血"]]];
        self.relationSV.delegate2 = self;
        [self.view addSubview:self.relationSV];
        self.selectTag = 10003;
    }
}

-(void)selectSexBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        self.s_hSelectBtn.selected = YES;
        self.hSelectBtn.selected = NO;
    }
    else if (btn.tag == 1002){
        self.s_hSelectBtn.selected = NO;
        self.hSelectBtn.selected = YES;
    }
    
    if (btn.tag == 1003) {
        self.s_eSelectBtn.selected = YES;
        self.eSelectBtn.selected = NO;
    }
    else if (btn.tag == 1004){
        self.s_eSelectBtn.selected = NO;
        self.eSelectBtn.selected = YES;
    }
    
    if (btn.tag == 1005) {
        self.s_erSelectBtn.selected = YES;
        self.erSelectBtn.selected = NO;
    }
    else if (btn.tag == 1006){
        self.s_erSelectBtn.selected = NO;
        self.erSelectBtn.selected = YES;
    }
    if (btn.tag == 1007) {
        self.s_mSelectBtn.selected = YES;
        self.mSelectBtn.selected = NO;
    }
    else if (btn.tag == 1008){
        self.s_mSelectBtn.selected = NO;
        self.mSelectBtn.selected = YES;
    }
}

-(void)keyshow:(NSNotification*)noti{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)keyhide{
    self.bgMengCeng.userInteractionEnabled = NO;
}

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    self.textField1.text = area;
    [self.sV removeFromSuperview];
    self.sV = nil;
}

-(void)hjhCancalbClicked{
    [self.sV removeFromSuperview];
    self.sV = nil;
}

#pragma mark -selectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (self.selectTag == 10001) {
        self.textField4.text = [@[@"正常",@"低体重",@"消瘦",@"肥胖"] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 10002){
        self.textField12.text = [@[@"无",@"先天性心脏病",@"癫痫",@"高热惊厥",@"哮喘",@"其他"] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 1003){
        self.textField24.text = [@[@"未检测",@"正常",@"低度贫血",@"中度贫血",@"重度贫血"] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
}

-(void)cancalSelectClicked{
    if (self.selectTag == 10001) {
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 10002){
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
}

-(void)addBtnClick{
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    
    NSString *time1 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:self.textField1.text]];
    
    [jianK saveHealthPlatformWithHealthId:@"0" childIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] historyDisease:self.textField12.text weight:self.textField3.text weightComment:@"0" height:self.textField2.text heightComment:@"0" skin:self.textField13.text eyesLeft:self.textField7.text eyesRight:self.textField8.text sightLeft:self.textField9.text sightRight:self.textField10.text sightComment:@"0" earLeft:self.textField14.text earRight:self.textField15.text earComment:@"0" teethTotal:self.textField5.text teethDisease:self.textField6.text head:self.textField16.text breast:self.textField17.text backboneLimbs:self.textField18.text throat:self.textField20.text heartLung:self.textField19.text liverSpleen:self.textField21.text externalGenitals:self.textField22.text bodyOthers:self.textField23.text hb:@"1" auxOthers:@"0" alt:self.textField25.text resultDesc:self.textField26.text doctorComment:self.textField27.text doctorName:self.textField28.text diagnoseBy:self.textField29.text diagnoseDate:time1];
}
@end
