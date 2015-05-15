//
//  addTiXingViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "addTiXingViewController.h"
#import "ThirdTableViewCell.h"
#import "youErYuanNetWork.h"

#import "HJHTimePickerView.h"

@interface addTiXingViewController ()<UITableViewDataSource,UITableViewDelegate,HJHPickerViewDelegate,HJHTimePickerViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyImageView *mainImageView;
@property(nonatomic,strong)NSArray *tongGaoArray;
@property(nonatomic,strong)HJHMyImageView *mengCengBgImageView;
@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;
@property(nonatomic,strong)HJHMyTextField *textField4;
@property(nonatomic,strong)HJHPickerView *sV;

@property(nonatomic,strong)HJHMyButton *selectBtn1;
@property(nonatomic,strong)HJHMyButton *selectBtn2;

@property(nonatomic,strong)HJHTimePickerView *tPV;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation addTiXingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentPage = 0;
    
    self.tongGaoArray = [NSArray array];
    
    [self getData];
    self.headNavView.titleLabel.text = @"添加提醒";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [self setMainImageView];
    [self setMainTableView];
    [self setMengCengBgImageView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(withoutBindSuccess:) name:@"withoutBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(withoutBindFail:) name:@"withoutBindFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsSuccess:) name:@"getPlatformInformsSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPlatformInformsFail:) name:@"getPlatformInformsFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    NSString *userName = [DictionaryStringTool stringFromDictionary:dic forKey:@"userName"];
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    [youErYuanNetWork1 withoutBindWithUserName:userName];
}

-(void)withoutBindSuccess:(NSNotification*)noti{
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youErYuanNetWork1 getPlatformInformsWithchildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
    self.mengCengBgImageView.userInteractionEnabled = NO;
}

-(void)withoutBindFail:(NSNotification*)noti{
    
}

-(void)getPlatformInformsSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [DictionaryStringTool stringFromDictionary:dic forKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.tongGaoArray = array;
    }
    [self._tableView reloadData];
}

-(void)getPlatformInformsFail:(NSNotification*)noti{
    
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.tableHeaderView = self.tPV;
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.tPV = [[HJHTimePickerView alloc]init];
    self.tPV.frame = CGRectMake(0, 0, ScreenWidth, 150);
    self.tPV.clipsToBounds = YES;
    self.tPV.delegate2 = self;
}

-(void)setMengCengBgImageView{
    self.mengCengBgImageView = [[HJHMyImageView alloc]init];
    self.mengCengBgImageView.frame = self.view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMengCengTip)];
    [self.mengCengBgImageView addGestureRecognizer:tap];
    [self.view addSubview:self.mengCengBgImageView];
}

#pragma mark - btnClick
-(void)showMengCengTip{
    KGTipView *tipV = [[KGTipView alloc]initWithTitle:nil context:@"请和幼儿园联系" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [tipV show];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    
    if (indexPath.row == 0) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"提醒日期";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.textField1) {
            self.textField1 = [[HJHMyTextField alloc]init];
        }
        self.textField1.fromRight = 10;
        self.textField1.frame = CGRectMake(10, 40, 300, 20);
        self.textField1.backgroundColor = [UIColor whiteColor];
        self.textField1.layer.cornerRadius = 5.0;
        self.textField1.textColor = [UIColor blackColor];
        self.textField1.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField1];
        
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = self.textField1.frame;
        [btn addTarget:self action:@selector(riqiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    if (indexPath.row == 1) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"提醒名称";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.textField2) {
            self.textField2 = [[HJHMyTextField alloc]init];
        }
        self.textField2.fromRight = 10;
        self.textField2.frame = CGRectMake(10, 40, 300, 20);
        self.textField2.backgroundColor = [UIColor whiteColor];
        self.textField2.layer.cornerRadius = 5.0;
        self.textField2.textColor = [UIColor blackColor];
        self.textField2.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField2];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"提醒描述";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.textField3) {
            self.textField3 = [[HJHMyTextField alloc]init];
        }
        self.textField3.fromRight = 10;
        self.textField3.frame = CGRectMake(10, 40, 300, 20);
        self.textField3.backgroundColor = [UIColor whiteColor];
        self.textField3.layer.cornerRadius = 5.0;
        self.textField3.textColor = [UIColor blackColor];
        self.textField3.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField3];
    }
    if (indexPath.row == 2) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"提醒描述";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.textField3) {
            self.textField3 = [[HJHMyTextField alloc]init];
        }
        self.textField3.fromRight = 10;
        self.textField3.frame = CGRectMake(10, 40, 300, 20);
        self.textField3.backgroundColor = [UIColor whiteColor];
        self.textField3.layer.cornerRadius = 5.0;
        self.textField3.textColor = [UIColor blackColor];
        self.textField3.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField3];
    }
    if (indexPath.row == 3) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"是否重复:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.selectBtn1) {
            self.selectBtn1 = [[HJHMyButton alloc]init];
        }
        self.selectBtn1.tag = 1001;
        [self.selectBtn1 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectBtn1 setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
        [self.selectBtn1 setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
        self.selectBtn1.frame = CGRectMake(105, 10, 20, 20);
        [cell addSubview:self.selectBtn1];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"是";
        label2.font = [UIFont systemFontOfSize:18];
        label2.frame = CGRectMake(130, 10, 100, 20);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        
    }
    if (indexPath.row == 4) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"重复周期的周几";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 140, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.textField4) {
            self.textField4 = [[HJHMyTextField alloc]init];
        }
        self.textField4.fromRight = 10;
        self.textField4.frame = CGRectMake(150, 10, 150, 20);
        self.textField4.backgroundColor = [UIColor whiteColor];
        self.textField4.layer.cornerRadius = 5.0;
        self.textField4.textColor = [UIColor blackColor];
        self.textField4.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.textField4];
    }
    if (indexPath.row == 5) {
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.text = @"是否打开:";
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(10, 10, 100, 20);
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        
        if (!self.selectBtn2) {
            self.selectBtn2 = [[HJHMyButton alloc]init];
        }
        self.selectBtn2.tag = 1002;
        [self.selectBtn2 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectBtn2 setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
        [self.selectBtn2 setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
        self.selectBtn2.frame = CGRectMake(105, 10, 20, 20);
        [cell addSubview:self.selectBtn2];
        
        HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
        label2.text = @"是";
        label2.font = [UIFont systemFontOfSize:18];
        label2.frame = CGRectMake(130, 10, 100, 20);
        label2.textColor = [UIColor blackColor];
        [cell addSubview:label2];
        
        
    }
//    if (indexPath.row < 3) {
//        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
//        footImage.frame = CGRectMake(0, 79, 320, 0.5);
//        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
//        [cell addSubview:footImage];
//    }
//    else{
//        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
//        footImage.frame = CGRectMake(0, 39, 320, 0.5);
//        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
//        [cell addSubview:footImage];
//    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
        return 80;
    }
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark - btnClick
-(void)riqiBtnClick{
    self.sV = [[HJHPickerView alloc]init];
    self.sV.delegate2 = self;
    [self.view addSubview:self.sV];
}

-(void)selectBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }
        else{
            btn.selected = YES;
        }
    }
    if (btn.tag == 1002) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }
        else{
            btn.selected = YES;
        }
    }
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

#pragma mark - HJHTimePickerViewDelegate
-(void)hjhTimeCancalbClicked{
    
}

-(void)hjhTimeGetDifang:(NSString *)area{
    
}
@end
