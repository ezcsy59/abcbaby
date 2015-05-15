//
//  tongzhiXiangQingViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "tongzhiXiangQingViewController.h"
#import "TeacherNetWork.h"
@interface tongzhiXiangQingViewController ()
@property(nonatomic,strong)NSString *infoId;
@property(nonatomic,strong)NSString *title;
@end

@implementation tongzhiXiangQingViewController

-(instancetype)initWithInfoId:(NSString*)infoId{
    if (self = [super init]) {
        self.infoId = infoId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getplatforminformDetailSuccess:) name:@"getplatforminformDetailSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getplatforminformDetailFail:) name:@"getplatforminformDetailFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    [tNet getplatforminformDetailWithInfoId:self.infoId];
}

-(void)getplatforminformDetailSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    NSString *string = [dict objectForKey:@"infoContent"];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight])];
    [webV loadHTMLString:string baseURL:nil];
    [self.view addSubview:webV];
}

-(void)getplatforminformDetailFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"消息详情";
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
