//
//  addYiMiaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addYiMiaoViewController.h"
#import "jianKangNetWork.h"

@interface addYiMiaoViewController ()<HJHPickerViewDelegate>
@property(nonatomic,strong)NSString *vacDocId;
@property(nonatomic,strong)NSString *vacName;
@property(nonatomic,strong)NSString *vacDate;
@property(nonatomic,strong)NSString *isDone;
@property(nonatomic,strong)HJHMyButton *timeBtn;
@property(nonatomic,strong)HJHMyButton *isDoneBtn;
@property(nonatomic,strong)HJHPickerView *pickerV;
@end

@implementation addYiMiaoViewController


-(instancetype)initWithVacDocId:(NSString*)vacDocId vacName:(NSString *)vacName vacDate:(NSString *)vacDate isDone:(NSString *)isDone{
    if (self = [super init]) {
        self.vacDocId = vacDocId;
        self.vacName = vacName;
        self.vacDate = vacDate;
        self.isDone = isDone;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = self.vacName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self getData];
    
    [self setMainView];
}

-(void)setMainView{
    self.timeBtn = [[HJHMyButton alloc]init];
    self.timeBtn.frame = CGRectMake(10, (iPhone5?568:480) - 65, 210, 50);
    self.timeBtn.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
    self.timeBtn.layer.borderWidth = 2;
    self.timeBtn.layer.cornerRadius = 8.0;
    [self.timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([self.vacDate integerValue] == 0) {
        [self.timeBtn setTitle:@"接种时间:未设置" forState:UIControlStateNormal];
    }
    else{
        [self.timeBtn setTitle:[NSString stringWithFormat:@"接种时间：%@",self.vacDate] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.timeBtn];
    
    self.isDoneBtn = [[HJHMyButton alloc]init];
    self.isDoneBtn.frame = CGRectMake(230, (iPhone5?568:480) - 65, 80, 50);
    self.isDoneBtn.layer.borderColor = [UIColor colorWithHexString:@"F08221"].CGColor;
    self.isDoneBtn.layer.borderWidth = 2;
    self.isDoneBtn.layer.cornerRadius = 8.0;
    [self.isDoneBtn addTarget:self action:@selector(isDoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.isDoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([self.isDone integerValue] == 0) {
        [self.isDoneBtn setTitle:@"未接种" forState:UIControlStateNormal];
    }
    else{
        [self.isDoneBtn setTitle:@"已接种" forState:UIControlStateNormal];
    }
    [self.view addSubview:self.isDoneBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getVaccinumDescSuccess:) name:@"getVaccinumDescSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getVaccinumDescFail:) name:@"getVaccinumDescFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getVaccinumDescSuccess:) name:@"saveVaccinumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getVaccinumDescFail:) name:@"saveVaccinumFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    jianKangNetWork *jianKangNetWork1 = [[jianKangNetWork alloc]init];
    [jianKangNetWork1 getVaccinumDescWithVacDocId:self.vacDocId];
}

-(void)getVaccinumDescSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSString *webString = [dic objectForKey:@"data"];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight] - 80)];
    NSURL *url =[NSURL URLWithString:webString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webV loadRequest:request];
    [self.view addSubview:webV];
}

-(void)getVaccinumDescFail:(NSNotification*)noti{
    
}

-(void)saveVaccinumSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)saveVaccinumFail:(NSNotification*)noti{
    
}

#pragma mark - btnClick
-(void)timeBtnClick:(HJHMyButton*)timeBtn{
    self.pickerV = [[HJHPickerView alloc]init];
    self.pickerV.delegate2 = self;
    [self.view addSubview:self.pickerV];
}

-(void)isDoneBtnClick:(HJHMyButton*)timeBtn{
    if ([timeBtn.titleLabel.text isEqualToString:@"未接种"]) {
        [timeBtn setTitle:@"已接种" forState:UIControlStateNormal];
    }
    else{
        [timeBtn setTitle:@"未接种" forState:UIControlStateNormal];
    }
}

-(void)saveBtnClick{
    NSString *vacDate = @"0";
    if (![self.timeBtn.titleLabel.text isEqualToString:@"接种时间:未设置"]) {
        NSArray *arr = [self.timeBtn.titleLabel.text componentsSeparatedByString:@":"];
        vacDate = [arr objectAtIndex:1];
    }
    NSString *isDone;
    if ([self.isDoneBtn.titleLabel.text isEqualToString:@"未接种"]) {
        isDone = @"0";
    }
    else{
        isDone = @"1";
    }
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    NSString *string = [DictionaryStringTool stringFromDictionary:dic forKey:@"relativesId"];
    jianKangNetWork *jianKangNetWork1 = [[jianKangNetWork alloc]init];
    [jianKangNetWork1 saveVaccinumWithVacDocId:self.vacDocId vacDate:vacDate isDone:vacDate relativesId:string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    [self.timeBtn setTitle:[NSString stringWithFormat:@"接种时间:%@",area] forState:UIControlStateNormal];
    [self.pickerV removeFromSuperview];
    self.pickerV = nil;
}

-(void)hjhCancalbClicked{
    [self.pickerV removeFromSuperview];
    self.pickerV = nil;
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
