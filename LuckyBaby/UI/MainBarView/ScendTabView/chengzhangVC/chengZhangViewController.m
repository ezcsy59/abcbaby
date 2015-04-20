//
//  chengZhangViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "chengZhangViewController.h"
#import "addChengZhangDataViewController.h"

@interface chengZhangViewController ()
//bar栏的img
@property(nonatomic,strong)HJHMyImageView *tabBarImageView;
//当前主页
@property(nonatomic,strong)HJHMyImageView *mainImageView;

//当前的tab
@property(nonatomic,assign)NSInteger currentTab;

@property(nonatomic,strong)UIViewController *currentViewController;
@end

@implementation chengZhangViewController

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *useD = [NSUserDefaults standardUserDefaults];
    [useD setValue:@"1" forKey:@"firstIn"];
    [useD synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"宝宝列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainView];
    [self setTabBar];
    [self choseView:0];
    
    
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    //只创建一次
    self.firstTabVC = [[chengZhangDataViewController alloc]init];
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
    self.tabBarImageView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:self.tabBarImageView];
    
    for (int i = 0; i < 3; i++) {
        HJHMyButton * tabButton = [[HJHMyButton alloc]init];
        tabButton.frame = CGRectMake(106 * i, 0, 106, 60);
        
        tabButton.clipsToBounds = NO;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
        tabButton.tag = i;
        [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                [tabButton setTitle:@"数据列表" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"data_list_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"data_list_s.png"] forState:UIControlStateSelected];
                break;
            case 1:
                [tabButton setTitle:@"身高曲线" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"body_line_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"body_line_s.png"] forState:UIControlStateSelected];
                break;
            case 2:
                [tabButton setTitle:@"体重曲线" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"tizhong_line_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"tizhong_line_s.png"] forState:UIControlStateSelected];
                break;
            default:
                break;
        }
        [tabButton setImageEdgeInsets:UIEdgeInsetsMake(6, 33, 21, 33)];
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
            
//            if(!self.firstTabVC){
                self.firstTabVC = [[chengZhangDataViewController alloc]init];
//            }
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, 0, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];
        }
            break;
        case 1:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            
            if(!self.secondTabVC){
                self.secondTabVC = [[shenGaoViewController alloc]init];
            }
            [self addChildViewController:self.secondTabVC];
            self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.secondTabVC;
            [self.mainImageView addSubview:self.secondTabVC.view];
            
        }
            break;
        case 2:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            
            if(!self.thirdTabVC){
                self.thirdTabVC = [[tiZhongViewController alloc]init];
            }
            [self addChildViewController:self.thirdTabVC];
            self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.thirdTabVC;
            [self.mainImageView addSubview:self.thirdTabVC.view];
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

-(void)addData{
    addChengZhangDataViewController *zVC = [[addChengZhangDataViewController alloc]init];
    [self.navigationController pushViewController:zVC animated:YES];
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
