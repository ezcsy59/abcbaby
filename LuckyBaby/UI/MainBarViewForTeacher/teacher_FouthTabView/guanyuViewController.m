//
//  guanyuViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "guanyuViewController.h"
#import "LoginNetWork.h"

@interface guanyuViewController ()
@property(nonatomic,strong)NSString *serviceTerms;
@property(nonatomic,strong)NSString *appDesc;
@property(nonatomic,strong)NSString *websiteUrl;
@property(nonatomic,assign)int style;
@end

@implementation guanyuViewController

-(instancetype)initWithStyle:(int)style{
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAboutAppSuccess:) name:@"getAboutAppSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAboutAppFail:) name:@"getAboutAppFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    LoginNetWork *loginN = [[LoginNetWork alloc]init];
    [loginN getAboutApp];
}

-(void)getAboutAppSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSString *string = [dic objectForKey:@"data"];
    NSArray *array = [string componentsSeparatedByString:@","];
    self.serviceTerms = [array objectAtIndex:0];
    NSArray *array2 = [self.serviceTerms componentsSeparatedByString:@"\":"];
    self.serviceTerms = [array2 objectAtIndex:1];
    self.serviceTerms = [self.serviceTerms stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    self.appDesc = [array objectAtIndex:1];
    array2 = [self.appDesc componentsSeparatedByString:@"\":"];
    self.appDesc = [array2 objectAtIndex:1];
    self.appDesc = [self.appDesc stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    self.websiteUrl = [array objectAtIndex:2];
    array2 = [self.websiteUrl componentsSeparatedByString:@"\":"];
    self.websiteUrl = [array2 objectAtIndex:1];
    self.websiteUrl = [self.websiteUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSLog(@"%@,%@,%@",self.serviceTerms,self.appDesc,self.websiteUrl);
    [self setMainView];
}

-(void)getAboutAppFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.headNavView.titleLabel.text = @"关于app";
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.style == 1) {
        self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    }
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    HJHMyImageView *logoImage = [[HJHMyImageView alloc]init];
    logoImage.image = [UIImage imageNamed:@"imgheader"];
    logoImage.frame = CGRectMake(120, [self getNavHight] + 20, 80, 80);
    logoImage.layer.cornerRadius = 40;
    logoImage.clipsToBounds = YES;
    [self.view addSubview:logoImage];
    
    UITextView *textView = [[UITextView alloc]init];
    if (iPhone5) {
        textView.frame = CGRectMake(10, [self getNavHight] + 90 + 40, 300, 260);
    }
    else{
        textView.frame = CGRectMake(10, [self getNavHight] + 90 + 20, 300, 200);
    }
    textView.userInteractionEnabled = NO;
    textView.text = self.appDesc;
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    
    HJHMyButton *quxiaoBtn;
    if (iPhone5) {
        quxiaoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 445, 320, 40)];
    }
    else{
        quxiaoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 355, 320, 40)];
    }
    [quxiaoBtn setTitle:@"服务协议和声明" forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [quxiaoBtn addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quxiaoBtn];
    
    HJHMyButton *quxiaoBtn2;
    if (iPhone5) {
        quxiaoBtn2 = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 485, 320, 40)];
    }
    else{
        quxiaoBtn2 = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 395, 320, 40)];
    }
    [quxiaoBtn2 setTitle:@"访问官网，了解更多" forState:UIControlStateNormal];
    [quxiaoBtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    quxiaoBtn2.titleLabel.font = [UIFont systemFontOfSize:20];
    [quxiaoBtn2 addTarget:self action:@selector(quxiaoClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quxiaoBtn2];
    
    HJHMyButton *quxiaoBtn3;
    if (iPhone5) {
        quxiaoBtn3 = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 525, 320, 40)];
    }
    else{
        quxiaoBtn3 = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 435, 320, 40)];
    }
    [quxiaoBtn3 setTitle:@"Copyright@2014-2020 健康宝贝" forState:UIControlStateNormal];
    [quxiaoBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quxiaoBtn3.userInteractionEnabled = NO;
    quxiaoBtn3.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:quxiaoBtn3];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, (iPhone5?445:355), 320, 3);
    footImage.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:footImage];
    
    HJHMyImageView *footImage2 = [[HJHMyImageView alloc]init];
    footImage2.frame = CGRectMake(0, (iPhone5?485:395), 320, 3);
    footImage2.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:footImage2];
    
    HJHMyImageView *footImage3 = [[HJHMyImageView alloc]init];
    footImage3.frame = CGRectMake(0, (iPhone5?525:435), 320, 3);
    footImage3.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:footImage3];
}

-(void)quxiaoClick{
    if ([self.serviceTerms containsString:@"http"]) {
        UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight])];
        NSURL *url =[NSURL URLWithString:self.serviceTerms];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [webV loadRequest:request];
        [self.view addSubview:webV];
    }
    
}

-(void)quxiaoClick2{
    if ([self.websiteUrl containsString:@"http"]) {
        UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight])];
        NSURL *url =[NSURL URLWithString:self.websiteUrl];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [webV loadRequest:request];
        [self.view addSubview:webV];
    }
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
