//
//  yaoqingQingViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "yaoqingQingViewController.h"
#import "dongtaiNetWork.h"

@interface yaoqingQingViewController ()
@property(nonatomic,strong)HJHMyLabel *yaoqingMaLabel;
@end

@implementation yaoqingQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"邀请亲";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setMainView];
    
    [self getData];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInvitationSuccess:) name:@"getInvitationSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInvitationFail:) name:@"getInvitationFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 getInvitationCodeWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
}

-(void)getInvitationSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    self.yaoqingMaLabel.text = [dic objectForKey:@"data"];
}

-(void)getInvitationFail:(NSNotification*)noti{
    
}

-(void)setMainView{
    [self setMainLabelView];
    [self setSmallLabel];
    [self setSendMessageBtn];
}

-(void)setMainLabelView{
    HJHMyImageView *labelBg = [[HJHMyImageView alloc]init];
    labelBg.frame = CGRectMake(15, 35 + [self getNavHight], 290, 50);
    labelBg.image = [UIImage imageNamed:@"ic_btn_add_course_green_pressed.9.png"];
    [self.view addSubview:labelBg];
    
    HJHMyLabel *yaoqingLabel = [[HJHMyLabel alloc]init];
    yaoqingLabel.frame = CGRectMake(10, 10, 70, 30);
    yaoqingLabel.text = @"邀请码:";
    yaoqingLabel.font = [UIFont systemFontOfSize:18];
    yaoqingLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    [labelBg addSubview:yaoqingLabel];
    
    self.yaoqingMaLabel = [[HJHMyLabel alloc]init];
    self.yaoqingMaLabel.frame = CGRectMake(yaoqingLabel.frame.origin.x + yaoqingLabel.frame.size.width + 8, 10, 180, 30);
    self.yaoqingMaLabel.text = @"";
    self.yaoqingMaLabel.font = [UIFont systemFontOfSize:18];
    self.yaoqingMaLabel.textColor = [UIColor blackColor];
    [labelBg addSubview:self.yaoqingMaLabel];
}

-(void)setSmallLabel{
    HJHMyLabel *yaoqingLabel = [[HJHMyLabel alloc]init];
    yaoqingLabel.frame = CGRectMake(15, 120 + [self getNavHight], 290, 80);
    yaoqingLabel.text = @"对方需要先安装本软件，然后在宝宝列表中使用邀请码添加宝宝就可以看到宝宝的相关数据了。";
    yaoqingLabel.numberOfLines = 3;
    yaoqingLabel.font = [UIFont systemFontOfSize:14];
    yaoqingLabel.textColor = [UIColor blackColor];
    [self.view addSubview:yaoqingLabel];
    
    UIImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    footImage.frame = CGRectMake(15, 200 + [self getNavHight], 290, 0.5);
    [self.view addSubview:footImage];
}

-(void)setSendMessageBtn{
    HJHMyButton *yaoqingQBtn = [[HJHMyButton alloc]init];
    yaoqingQBtn.frame = CGRectMake(15, 215 + [self getNavHight], 290, 51);
    [yaoqingQBtn setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [yaoqingQBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [yaoqingQBtn setTitle:@"发送邀请码" forState:UIControlStateNormal];
    [yaoqingQBtn addTarget:self action:@selector(yaoqingQBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yaoqingQBtn];
}

#pragma mark - btnClick
-(void)completeBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)yaoqingQBtnClick{
    
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
