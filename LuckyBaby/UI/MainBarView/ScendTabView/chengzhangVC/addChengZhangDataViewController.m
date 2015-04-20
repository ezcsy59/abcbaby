//
//  addChengZhangDataViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addChengZhangDataViewController.h"
#import "jianKangNetWork.h"
#import "zidingyiViewController.h"

@interface addChengZhangDataViewController ()<UITableViewDataSource,UITableViewDelegate,HJHPickerViewDelegate,KGSelectViewDelegate,KGTipViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyTextField *timeField;
@property(nonatomic,strong)HJHMyTextField *heightField;
@property(nonatomic,strong)HJHMyTextField *wedthField;
@property(nonatomic,strong)HJHMyTextField *totoalTField;
@property(nonatomic,strong)HJHMyTextField *deaTField;
@property(nonatomic,strong)HJHMyTextField *leftEField;
@property(nonatomic,strong)HJHMyTextField *rightEField;
@property(nonatomic,strong)HJHMyTextField *ziDingYi1Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi2Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi3Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi4Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi5Field;
@property(nonatomic,strong)HJHMyTextField *ziDingYi6Field;
@property(nonatomic,strong)HJHPickerView *sV;

@property(nonatomic,strong)KGSelectView *SView;
@property(nonatomic,strong)KGTipView *tipView;

@property(nonatomic,assign)int style;
@property(nonatomic,strong)NSDictionary *addChengZhangDataDic;
@end

@implementation addChengZhangDataViewController

-(instancetype)initWithStyle:(int)style chengZhangDic:(NSDictionary *)chengZhangDic{
    if (self = [super init]) {
        self.style = style;
        self.addChengZhangDataDic = chengZhangDic;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHealthPlatformSuccess:) name:@"getHealthPlatformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHealthPlatformFail:) name:@"getHealthPlatformFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delHealthInfoSuccess:) name:@"delHealthInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delHealthInfoFail:) name:@"delHealthInfoFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getHealthPlatformSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
}

-(void)getHealthPlatformFail:(NSNotification*)noti{
    
}

-(void)delHealthInfoSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSString *flag = [DictionaryStringTool stringFromDictionary:dic forKey:@"flag"];
    if ([flag isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)delHealthInfoFail:(NSNotification*)noti{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.style == 1) {
        self.headNavView.titleLabel.text = @"生长记录";
    }
    else{
        self.headNavView.titleLabel.text = @"添加成长记录";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTextFeild];
    if (self.style == 1) {
        [self setData];
    }
    [self setTableView];
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    if (self.style == 1) {
        [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
    }
    else{
        [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
    
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)setTextFeild{
    self.timeField = [[HJHMyTextField alloc]init];
    self.heightField = [[HJHMyTextField alloc]init];
    self.wedthField = [[HJHMyTextField alloc]init];
    self.totoalTField = [[HJHMyTextField alloc]init];
    self.deaTField = [[HJHMyTextField alloc]init];
    self.leftEField = [[HJHMyTextField alloc]init];
    self.rightEField = [[HJHMyTextField alloc]init];
    self.ziDingYi1Field = [[HJHMyTextField alloc]init];
    self.ziDingYi2Field = [[HJHMyTextField alloc]init];
    self.ziDingYi3Field = [[HJHMyTextField alloc]init];
    self.ziDingYi4Field = [[HJHMyTextField alloc]init];
    self.ziDingYi5Field = [[HJHMyTextField alloc]init];
    self.ziDingYi6Field = [[HJHMyTextField alloc]init];
    
    self.timeField.fromRight = 10;
    self.heightField.fromRight = 10;
    self.wedthField.fromRight = 10;
    self.totoalTField.fromRight = 3;
    self.deaTField.fromRight = 3;
    self.leftEField.fromRight = 3;
    self.rightEField.fromRight = 3;
    self.ziDingYi1Field.fromRight = 10;
    self.ziDingYi2Field.fromRight = 10;
    self.ziDingYi3Field.fromRight = 10;
    self.ziDingYi4Field.fromRight = 10;
    self.ziDingYi5Field.fromRight = 10;
    self.ziDingYi6Field.fromRight = 10;
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
    
    
    HJHMyImageView *footBtnView = [[HJHMyImageView alloc]init];
    footBtnView.frame = CGRectMake(0, 0, 320, 60);
    
    HJHMyButton *footBtn = [[HJHMyButton alloc]init];
    footBtn.frame = CGRectMake(20, 4, 280, 51);
    [footBtn setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [footBtn setTitle:@"自定义项目" forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(footBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footBtnView addSubview:footBtn];
    
    self._tableView.tableFooterView = footBtnView;
}

-(void)setData{
    self._tableView.userInteractionEnabled = NO;
    NSString *time = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"createdDate"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:(time.length - 3)]];
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    self.timeField.text = [array objectAtIndex:0];
    
    self.heightField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"height"];
    self.wedthField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"weight"];
    self.leftEField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"sightLeft"];
    self.rightEField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"sightRight"];
    self.totoalTField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"teethTotal"];
    self.deaTField.text = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"teethDisease"];
    NSString *selfItem1 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue1"];
    NSString *selfItem2 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue2"];
    NSString *selfItem3 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue3"];
    NSString *selfItem4 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue4"];
    NSString *selfItem5 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue5"];
    NSString *selfItem6 = [DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"selfItemValue6"];

    if (selfItem1.length > 0) {
        self.ziDingYi1Field.text = selfItem1;
    }
    if (selfItem2.length > 0) {
        self.ziDingYi2Field.text = selfItem2;
    }
    if (selfItem3.length > 0) {
        self.ziDingYi3Field.text = selfItem3;
    }
    if (selfItem4.length > 0) {
        self.ziDingYi4Field.text = selfItem4;
    }
    if (selfItem5.length > 0) {
        self.ziDingYi5Field.text = selfItem5;
    }
    if (selfItem6.length > 0) {
        self.ziDingYi6Field.text = selfItem6;
    }
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
    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    if (indexPath.row == 0) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"记录日期";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
    
        self.timeField.font = [UIFont systemFontOfSize:18];
        self.timeField.frame = CGRectMake(140, 20, 160, 20);
        self.timeField.textColor = [UIColor blackColor];
        if (self.style == 1) {
            self.timeField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.timeField.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.timeField.backgroundColor = [UIColor whiteColor];
            self.timeField.keyboardType = UIKeyboardTypeNumberPad;
            self.timeField.layer.cornerRadius = 5.0;
            self.timeField.textAlignment = NSTextAlignmentLeft;
        }
        [cell addSubview:self.timeField];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.timeField.frame;
        [btn addTarget:self action:@selector(riqiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    else if (indexPath.row == 1){
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"身高(cm)";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
    
        self.heightField.font = [UIFont systemFontOfSize:18];
        self.heightField.frame = CGRectMake(180, 20, 120, 20);
        self.heightField.textColor = [UIColor blackColor];
        if (self.style == 1) {
            self.heightField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.heightField.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.heightField.backgroundColor = [UIColor whiteColor];
            self.heightField.keyboardType = UIKeyboardTypeNumberPad;
            self.heightField.layer.cornerRadius = 5.0;
            self.heightField.textAlignment = NSTextAlignmentLeft;
        }
        
        [cell addSubview:self.heightField];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    else if (indexPath.row == 2){
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"体重(Kg)";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        self.wedthField.font = [UIFont systemFontOfSize:18];
        self.wedthField.frame = CGRectMake(180, 20, 120, 20);
        self.wedthField.textColor = [UIColor blackColor];
        
        if (self.style == 1) {
            self.wedthField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.wedthField.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.wedthField.backgroundColor = [UIColor whiteColor];
            self.wedthField.keyboardType = UIKeyboardTypeNumberPad;
            self.wedthField.layer.cornerRadius = 5.0;
            self.wedthField.textAlignment = NSTextAlignmentLeft;
        }
        [cell addSubview:self.wedthField];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    else if (indexPath.row == 3){
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"牙齿(颗)";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"总数:";
        label2.font = [UIFont systemFontOfSize:18];
        label2.frame = CGRectMake(120, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        if (self.style == 1) {
            label2.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"龋齿:";
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(225, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        if (self.style == 1) {
            label3.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        [cell addSubview:label3];
        
        self.totoalTField.font = [UIFont systemFontOfSize:18];
        self.totoalTField.frame = CGRectMake(160, 20, 45, 20);
        self.totoalTField.textColor = [UIColor blackColor];
        
        if (self.style == 1) {
            self.totoalTField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        else{
            self.totoalTField.backgroundColor = [UIColor whiteColor];
            self.totoalTField.keyboardType = UIKeyboardTypeNumberPad;
            self.totoalTField.layer.cornerRadius = 5.0;
        }
        [cell addSubview:self.totoalTField];
        
        self.deaTField.font = [UIFont systemFontOfSize:18];
        self.deaTField.frame = CGRectMake(270, 20, 45, 20);
        self.deaTField.textColor = [UIColor blackColor];
        
        if (self.style == 1) {
            self.deaTField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        else{
            self.deaTField.backgroundColor = [UIColor whiteColor];
            self.deaTField.keyboardType = UIKeyboardTypeNumberPad;
            self.deaTField.layer.cornerRadius = 5.0;
        }
        [cell addSubview:self.deaTField];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    else if (indexPath.row == 4){
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"视力";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 0, 100, 60);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"左眼:";
        label2.font = [UIFont systemFontOfSize:18];
        label2.frame = CGRectMake(120, 0, 60, 60);
        label2.textColor = [UIColor blackColor];
        if (self.style == 1) {
            label2.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        [cell addSubview:label2];
        
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = @"右眼:";
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(225, 0, 60, 60);
        label3.textColor = [UIColor blackColor];
        if (self.style == 1) {
            label3.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        [cell addSubview:label3];
        
        self.leftEField.font = [UIFont systemFontOfSize:18];
        self.leftEField.frame = CGRectMake(160, 20, 45, 20);
        self.leftEField.textColor = [UIColor blackColor];
        
        if (self.style == 1) {
            self.leftEField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        else{
            self.leftEField.backgroundColor = [UIColor whiteColor];
            self.leftEField.keyboardType = UIKeyboardTypeNumberPad;
            self.leftEField.layer.cornerRadius = 5.0;
        }
        [cell addSubview:self.leftEField];
        
        self.rightEField.font = [UIFont systemFontOfSize:18];
        self.rightEField.frame = CGRectMake(270, 20, 45, 20);
        self.rightEField.textColor = [UIColor blackColor];
        if (self.style == 1) {
            self.rightEField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        }
        else{
            self.rightEField.backgroundColor = [UIColor whiteColor];
            self.rightEField.keyboardType = UIKeyboardTypeNumberPad;
            self.rightEField.layer.cornerRadius = 5.0;
        }
        [cell addSubview:self.rightEField];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 5) {
        self.ziDingYi1Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi1Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi1Field.textColor = [UIColor blackColor];
        self.ziDingYi1Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi1Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi1Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi1Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 6) {
        self.ziDingYi2Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi2Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi2Field.textColor = [UIColor blackColor];
        self.ziDingYi2Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi2Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi2Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi2Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 7) {
        self.ziDingYi3Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi3Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi3Field.textColor = [UIColor blackColor];
        self.ziDingYi3Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi3Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi3Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi3Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 8) {
        self.ziDingYi4Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi4Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi4Field.textColor = [UIColor blackColor];
        self.ziDingYi4Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi4Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi4Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi4Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 9) {
        self.ziDingYi5Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi5Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi5Field.textColor = [UIColor blackColor];
        self.ziDingYi5Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi5Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi5Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi5Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 10) {
        self.ziDingYi6Field.font = [UIFont systemFontOfSize:18];
        self.ziDingYi6Field.frame = CGRectMake(10, 20, 120, 20);
        self.ziDingYi6Field.textColor = [UIColor blackColor];
        self.ziDingYi6Field.backgroundColor = [UIColor whiteColor];
        self.ziDingYi6Field.keyboardType = UIKeyboardTypeNumberPad;
        self.ziDingYi6Field.layer.cornerRadius = 5.0;
        [cell addSubview:self.ziDingYi6Field];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    cell.clipsToBounds = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        return 60;
    }
    else if (indexPath.row == 5){
        if (self.ziDingYi1Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    else if (indexPath.row == 6){
        if (self.ziDingYi2Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    else if (indexPath.row == 7){
        if (self.ziDingYi3Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    else if (indexPath.row == 8){
        if (self.ziDingYi4Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    else if (indexPath.row == 9){
        if (self.ziDingYi5Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    else if (indexPath.row == 10){
        if (self.ziDingYi6Field.text.length > 0) {
            return 60;
        }
        else{
            return 0;
        }
    }
    return 0;
}


#pragma mark - btnClick
-(void)riqiBtnClick{
    self.sV = [[HJHPickerView alloc]init];
    self.sV.delegate2 = self;
    [self.view addSubview:self.sV];
}

-(void)saveBtnClick{
    if (self.style == 1) {
        self.SView = [[KGSelectView alloc]initWithDictionary:@[@"修改记录",@"删除记录"] title:@"更多操作" cancelBtn:@"取消"];
        self.SView.delegate2 = self;
        [self.view addSubview:self.SView];
    }
    else{
        NSDictionary *dic1 = [plistDataManager getDataWithKey:user_loginList];
        jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
        [jianK saveHealthInfoWithChildId:@"0" weight:self.wedthField.text height:self.heightField.text sightLeft:self.leftEField.text sightRight:self.rightEField.text teethTotal:self.totoalTField.text teethDisease:self.deaTField.text createdBy:[DictionaryStringTool stringFromDictionary:dic1 forKey:@"userId"] createdDate:[TimeChange timeChage2:self.timeField.text] updatedBy:[DictionaryStringTool stringFromDictionary:dic1 forKey:@"userId"] updatedDate:[TimeChange timeChage2:self.timeField.text] seflItemValue1:@"" seflItemValue2:@"" seflItemValue3:@"" seflItemValue4:@"" seflItemValue5:@"" seflItemValue6:@""];
    }
}

-(void)footBtnClick{
    zidingyiViewController *zVC = [[zidingyiViewController alloc]init];
    [self.navigationController pushViewController:zVC animated:YES];
}

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    self.timeField.text = area;
    [self.sV removeFromSuperview];
    self.sV = nil;
}

-(void)hjhCancalbClicked{
    [self.sV removeFromSuperview];
    self.sV = nil;
}

-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
        self._tableView.userInteractionEnabled = YES;
        [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
        self.style = 0;
        [self._tableView reloadData];
    }
    else if (tag == 1){
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"是否确定删除" cancelButtonTitle:@"取消" otherCancelButton:@[@"确定"] lockType:LockTypeGlobal delegate:nil userInfo:nil];
        self.tipView.delegate = self;
        [self.tipView show];

    }
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)cancalSelectClicked{
    [self.SView removeFromSuperview];
    self.SView = nil;
}

#pragma mark - KGTipViewDelegate
-(void)KGTipVIew:(KGTipView *)tipView buttonOfIndex:(NSInteger)index userInfo:(id)userInfo{
    if (index == 1) {
        jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
        [jianK delHealthInfoWithHealthId:[DictionaryStringTool stringFromDictionary:self.addChengZhangDataDic forKey:@"healthId"]];
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
