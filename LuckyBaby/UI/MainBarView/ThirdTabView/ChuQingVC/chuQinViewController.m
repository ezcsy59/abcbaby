//
//  chuQinViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "chuQinViewController.h"
#import "chuQinFirstViewController.h"
#import "qinJiaViewController.h"
#import "zhongDianGuanChaViewController.h"
#import "weiTuoChiYaoViewController.h"

#import "addQinJiaViewController.h"
#import "addZhongDianGuanChaViewController.h"
#import "addWeiTuoChiYaoViewController.h"

@interface chuQinViewController ()<KGSelectViewDelegate>
@property(nonatomic,strong)KGSelectView *SView;
//bar栏的img
@property(nonatomic,strong)HJHMyImageView *tabBarImageView;
//当前主页
@property(nonatomic,strong)HJHMyImageView *mainImageView;

//当前的tab
@property(nonatomic,assign)NSInteger currentTab;

@property(nonatomic,strong)UIViewController *currentViewController;

@property(nonatomic,strong)chuQinFirstViewController *firstTabVC;
@property(nonatomic,strong)qinJiaViewController *secondTabVC;
@property(nonatomic,strong)zhongDianGuanChaViewController *thirdTabVC;
@property(nonatomic,strong)weiTuoChiYaoViewController *fouthTabVC;
@end

@implementation chuQinViewController

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *useD = [NSUserDefaults standardUserDefaults];
    [useD setValue:@"1" forKey:@"firstIn"];
    [useD synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"出勤";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
    self.rigthBtn.tag = 1001;
    [self.rigthBtn addTarget:self action:@selector(addData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainView];
    [self setTabBar];
    [self choseView:0];

}

-(void)setMainView{
    //只创建一次
    self.firstTabVC = [[chuQinFirstViewController alloc]init];
    [self addChildViewController:self.firstTabVC];
    self.firstTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    //    self.secondTabVC = [[SecondTabViewController alloc]init];
    //    [self addChildViewController:self.secondTabVC];
    //    self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    //    self.thirdTabVC = [[ThirdTabViewController alloc]init];
    //    [self addChildViewController:self.thirdTabVC];
    //    self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    //    self.fouthTabVC = [[FouthTabViewController alloc]init];
    //    [self addChildViewController:self.fouthTabVC];
    //    self.fouthTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    
    //选取第一vc
    self.mainImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenHeigth, ScreenHeigth - [self getNavHight] - 50)];
    self.mainImageView.backgroundColor = [UIColor clearColor];
    [self.mainImageView addSubview:self.firstTabVC.view];
    [self.view addSubview:self.mainImageView];
    [self.view sendSubviewToBack:self.mainImageView];
}

-(void)setTabBar{
    self.tabBarImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, ScreenHeigth - 60, ScreenWidth, 60)];
    self.tabBarImageView.clipsToBounds = NO;
    self.tabBarImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabBarImageView];
    
    for (int i = 0; i < 4; i++) {
        HJHMyButton * tabButton = [[HJHMyButton alloc]init];
        tabButton.frame = CGRectMake(80 * i, 0, 80, 60);
        
        tabButton.clipsToBounds = NO;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
        tabButton.tag = i;
        [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                [tabButton setTitle:@"出勤" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_001_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_001_s.png"] forState:UIControlStateSelected];
                break;
            case 1:
                [tabButton setTitle:@"请假" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_002_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_002_s.png"] forState:UIControlStateSelected];
                break;
            case 2:
                [tabButton setTitle:@"重点观察" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_003_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_003_s.png"] forState:UIControlStateSelected];
                break;
            case 3:
                [tabButton setTitle:@"委托服药" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_004_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"chuqin_004_s.png"] forState:UIControlStateSelected];
                break;
            default:
                break;
        }
        [tabButton setImageEdgeInsets:UIEdgeInsetsMake(6, 23, 21, 23)];
        [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -80, 0, 0)];
        [self.tabBarImageView addSubview:tabButton];
    }
}

-(void)choseViewWithButton:(HJHMyButton*)btn{
    [self choseView:btn.tag];
}

//选取页面
-(void)choseView:(NSInteger)page{
    self.currentTab = page;
    self.rigthBtn.tag = page;
    NSLog(@"%@",self.tabBarImageView.subviews);
    for (id img in self.tabBarImageView.subviews) {
        if ([img isKindOfClass:[UIButton class]]) {
            if (((UIButton*)img).tag == page) {
                ((UIButton*)img).selected = YES;
            }else{
                ((UIButton*)img).selected = NO;
            }
        }
    }
    
    
    switch (page) {
        case 0:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
//            if (!self.firstTabVC) {
                self.firstTabVC = [[chuQinFirstViewController alloc]init];
//            }
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];
            
            [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
            self.rigthBtn.tag = 1001;
        }
            break;
        case 1:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.secondTabVC) {
                self.secondTabVC = [[qinJiaViewController alloc]init];
            }
            [self addChildViewController:self.secondTabVC];
            self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.secondTabVC;
            [self.mainImageView addSubview:self.secondTabVC.view];
            
            [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
            self.rigthBtn.tag = 1002;
            
        }
            break;
        case 2:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.thirdTabVC) {
                self.thirdTabVC = [[zhongDianGuanChaViewController alloc]init];
            }
            [self addChildViewController:self.thirdTabVC];
            self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.thirdTabVC;
            [self.mainImageView addSubview:self.thirdTabVC.view];
            
            [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
            self.rigthBtn.tag = 1003;
        }
            break;
        case 3:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.fouthTabVC) {
                self.fouthTabVC = [[weiTuoChiYaoViewController alloc]init];
            }
            [self addChildViewController:self.fouthTabVC];
            self.fouthTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.fouthTabVC;
            [self.mainImageView addSubview:self.fouthTabVC.view];
            
            [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
            self.rigthBtn.tag = 1004;
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - btnClick
-(void)addData:(HJHMyButton *)btn{
    if (btn.tag == 1001) {
        self.SView = [[KGSelectView alloc]initWithDictionary:@[@"接送信息",@"请假",@"重点观察",@"委托服药"] title:@"更多" cancelBtn:@"取消"];
        self.SView.delegate2 = self;
        [self.view addSubview:self.SView];
    }
    if (btn.tag == 1002) {
        addQinJiaViewController *aVC = [[addQinJiaViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    if (btn.tag == 1003) {
        addZhongDianGuanChaViewController *aVC = [[addZhongDianGuanChaViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    if (btn.tag == 1004) {
        addWeiTuoChiYaoViewController *aVC = [[addWeiTuoChiYaoViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
}

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
        
    }
    else if (tag == 1){
        addQinJiaViewController *aVC = [[addQinJiaViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    else if (tag == 2){
        addZhongDianGuanChaViewController *aVC = [[addZhongDianGuanChaViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    else if (tag == 3){
        addWeiTuoChiYaoViewController *aVC = [[addWeiTuoChiYaoViewController alloc]init];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)cancalSelectClicked{
    [self.SView removeFromSuperview];
    self.SView = nil;
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
