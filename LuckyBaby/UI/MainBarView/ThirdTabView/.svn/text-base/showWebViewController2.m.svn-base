//
//  showWebViewController2.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "showWebViewController2.h"
#import "youErYuanNetWork.h"

@interface showWebViewController2 ()
@property(nonatomic,strong)NSString *knowId;
@property(nonatomic,strong)NSString *title;
@end

@implementation showWebViewController2

-(instancetype)initWithKnowId:(NSString*)knowId title:(NSString *)title{
    if (self = [super init]) {
        self.knowId = knowId;
        self.title = title;
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
    youErYuanNetWork *jianKangNetWork1 = [[youErYuanNetWork alloc]init];
    [jianKangNetWork1 getplatforminformDetailWithInfoId:self.knowId];
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
    [self getData];
    self.headNavView.titleLabel.text = @"消息详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
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
