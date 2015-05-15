//
//  t_FirstTabViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "t_FirstTabViewController.h"
#import "addShiJianTableViewController.h"

@interface t_FirstTabViewController ()
//当前主页
@property(nonatomic,strong)HJHMyImageView *mainImageView;
//bar栏的img
@property(nonatomic,strong)HJHMyImageView *tabBarImageView;
//当前的tab
@property(nonatomic,assign)NSInteger currentTab;

@property(nonatomic,strong)HJHMyImageView *redPoint;
@property(nonatomic,strong)HJHMyImageView *redPoint2;

@property(nonatomic,strong)UIViewController *currentViewController;
@end

@implementation t_FirstTabViewController

-(void)viewWillAppear:(BOOL)animated{
}

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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    [self setMainView];
    [self setTabBar];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 0){
        [self choseView:3];
    }
    else{
        [self choseView:0];
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)setTabBar{
    self.tabBarImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    self.tabBarImageView.clipsToBounds = NO;
    self.tabBarImageView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:self.tabBarImageView];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 1) {
        for (int i = 0; i < 4; i++) {
            HJHMyButton * tabButton = [[HJHMyButton alloc]init];
            tabButton.frame = CGRectMake(80 *i, 0, 80, 40);
            tabButton.clipsToBounds = NO;
            tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
            tabButton.tag = i;
            tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                    [tabButton setTitle:@"通知报告" forState:UIControlStateNormal];
                    break;
                case 1:
                    [tabButton setTitle:@"出勤报告" forState:UIControlStateNormal];;;
                    break;
                case 2:
                    [tabButton setTitle:@"晨检报告" forState:UIControlStateNormal];
                    break;
                case 3:
                    [tabButton setTitle:@"委托服药" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            [self.tabBarImageView addSubview:tabButton];
            if (i != 3) {
                HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
                footImage.frame = CGRectMake(80 + 80*(i), 0, 0.5, 40);
                footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
                [self.tabBarImageView addSubview:footImage];
            }
            
            
            HJHMyImageView *footImage2 = [[HJHMyImageView alloc]init];
            footImage2.frame = CGRectMake(0, 39.5, 320, 0.5);
            footImage2.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
            [self.tabBarImageView addSubview:footImage2];
        }

    }
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 0) {
        for (int i = 0; i < 5; i++) {
            HJHMyButton * tabButton = [[HJHMyButton alloc]init];
            tabButton.frame = CGRectMake(64 *i, 0, 64, 40);
            tabButton.clipsToBounds = NO;
            tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
            tabButton.tag = 4 + i;
            tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                    [tabButton setTitle:@"通知公告" forState:UIControlStateNormal];
                    break;
                case 1:
                    [tabButton setTitle:@"晨检报告" forState:UIControlStateNormal];;;
                    break;
                case 2:
                    [tabButton setTitle:@"请假消息" forState:UIControlStateNormal];
                    break;
                case 3:
                    [tabButton setTitle:@"重点观察" forState:UIControlStateNormal];
                    break;
                case 4:
                    [tabButton setTitle:@"委托服药" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            [self.tabBarImageView addSubview:tabButton];
            
            HJHMyImageView *footImage2 = [[HJHMyImageView alloc]init];
            footImage2.frame = CGRectMake(0, 39.5, 320, 0.5);
            footImage2.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
            [self.tabBarImageView addSubview:footImage2];
        }
        
    }
}

-(void)setMainView{
    //只创建一次
    UIViewController *vc = [[UIViewController alloc]init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
    
    //选取第一vc
    self.mainImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, 40, ScreenHeigth, ScreenHeigth - 50 - 40)];
    self.mainImageView.backgroundColor = [UIColor clearColor];
    [self.mainImageView addSubview:vc.view];
    [self.view addSubview:self.mainImageView];
    [self.view sendSubviewToBack:self.mainImageView];
}

-(void)choseViewWithButton:(HJHMyButton*)btn{
    [self choseView:btn.tag];
}

//选取页面
-(void)choseView:(NSInteger)page{
    self.currentTab = page;
    NSLog(@"%@",self.tabBarImageView.subviews);
    for (id img in self.tabBarImageView.subviews) {
        if ([img isKindOfClass:[UIButton class]]) {
            if (((UIButton*)img).tag == page) {
                ((UIButton*)img).selected = YES;
                [((UIButton*)img) setTitleColor:[UIColor colorWithHexString:@"#7FC369"] forState:UIControlStateNormal];
            }else{
                ((UIButton*)img).selected = NO;
                [((UIButton*)img) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    
    switch (page) {
        case 0:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            //            if (!self.firstTabVC) {
            self.firstTabVC = [[Tab1_insertFirstTabVC alloc]init];
            //            }
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, 0, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];
        }
            break;
        case 1:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.secondTabVC) {
                self.secondTabVC = [[Tab2_insertFirstTabVC alloc]init];
            }
            [self addChildViewController:self.secondTabVC];
            self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.secondTabVC;
            [self.mainImageView addSubview:self.secondTabVC.view];
        }
            break;
        case 2:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.thirdTabVC) {
                self.thirdTabVC = [[Tab3_insertFirstTabVC alloc]init];
            }
            [self addChildViewController:self.thirdTabVC];
            self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.thirdTabVC;
            [self.mainImageView addSubview:self.thirdTabVC.view];
        }
            break;
        case 3:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.seventTabVC) {
                self.seventTabVC = [[Tab7_insertFirstTabVC alloc]initWithStyle:1];
            }
            [self addChildViewController:self.seventTabVC];
            self.seventTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.seventTabVC;
            [self.mainImageView addSubview:self.seventTabVC.view];
        }
            break;
        case 4:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            //            if (!self.firstTabVC) {
            self.firstTabVC = [[Tab1_insertFirstTabVC alloc]init];
            //            }
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, 0, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];
        }
            break;
        case 5:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.fouthTabVC) {
                self.fouthTabVC = [[Tab4_insertFirstTabVC alloc]init];
            }
            [self addChildViewController:self.fouthTabVC];
            self.fouthTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.fouthTabVC;
            [self.mainImageView addSubview:self.fouthTabVC.view];
        }
            break;
        case 6:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.fiveTabVC) {
                self.fiveTabVC = [[Tab5_insertFirstTabVC alloc]init];
            }
            [self addChildViewController:self.fiveTabVC];
            self.fiveTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.fiveTabVC;
            [self.mainImageView addSubview:self.fiveTabVC.view];
        }
            break;
        case 7:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.sixTabVC) {
                self.sixTabVC = [[Tab6_insertFirstTabVC alloc]init];
            }
            [self addChildViewController:self.sixTabVC];
            self.sixTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.sixTabVC;
            [self.mainImageView addSubview:self.sixTabVC.view];
        }
            break;
        case 8:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.seventTabVC) {
                self.seventTabVC = [[Tab7_insertFirstTabVC alloc]initWithStyle:0];
            }
            [self addChildViewController:self.seventTabVC];
            self.seventTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - 44 - 45);
            self.currentViewController = self.seventTabVC;
            [self.mainImageView addSubview:self.seventTabVC.view];
        }
            break;
        default:
            break;
    }
}

-(void)gotoNextPage:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
        {
            NSLog(@"%d",btn.tag);
        }
            break;
        case 1:
        {
            NSLog(@"%d",btn.tag);
//            babyListViewController *bVC = [[babyListViewController alloc]init];
//            [self.navigationController pushViewController:bVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"%d",btn.tag);
        }
            break;
        case 3:
        {
            NSLog(@"%d",btn.tag);
        }
            break;
            
        default:
            break;
    }
}

-(void)addShiJianBtnClick{
    addShiJianTableViewController *aVC = [[addShiJianTableViewController alloc]init];
    [self.navigationController pushViewController:aVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
