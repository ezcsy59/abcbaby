//
//  knowWebViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "knowWebViewController.h"

@interface knowWebViewController ()
@property(nonatomic,strong)NSString *knowId;
@property(nonatomic,strong)NSString *title;
@end

@implementation knowWebViewController

-(instancetype)initWithKnowId:(NSString*)knowId title:(NSString *)title{
    if (self = [super init]) {
        self.knowId = knowId;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = self.title;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight])];
    NSURL *url =[NSURL URLWithString:self.knowId];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webV loadRequest:request];
    [self.view addSubview:webV];
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
