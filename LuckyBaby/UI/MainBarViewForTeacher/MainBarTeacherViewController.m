//
//  MainBarTeacherViewController.m
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "MainBarTeacherViewController.h"
#import "babyListViewController.h"
#import "addShiJianTableViewController.h"

@interface MainBarTeacherViewController ()
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

@implementation MainBarTeacherViewController

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
    [self choseView:0];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
	// Do any additional setup after loading the view.
}

-(void)setTabBar{
    self.tabBarImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, ScreenHeigth - 60, ScreenWidth, 60)];
    self.tabBarImageView.clipsToBounds = NO;
    self.tabBarImageView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self.view addSubview:self.tabBarImageView];

    for (int i = 0; i < 4; i++) {
        HJHMyButton * tabButton = [[HJHMyButton alloc]init];
        tabButton.frame = CGRectMake(80 *i, 0, 80, 60);
        tabButton.clipsToBounds = NO;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
        tabButton.tag = i;
        tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                [tabButton setTitle:@"消息" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_a1"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_b1"] forState:UIControlStateSelected];
                [tabButton setImageEdgeInsets:UIEdgeInsetsMake(8, 25, 21, 25)];
                [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -70, 0, 0)];
                break;
            case 1:
                [tabButton setTitle:@"班级" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_a2"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_b2"] forState:UIControlStateSelected];
                [tabButton setImageEdgeInsets:UIEdgeInsetsMake(8, 25, 21, 25)];
                [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -70, 0, 0)];
                break;
            case 2:
                [tabButton setTitle:@"通讯录" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_a3"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_b3"] forState:UIControlStateSelected];
                [tabButton setImageEdgeInsets:UIEdgeInsetsMake(8, 25, 21, 25)];
                [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -70, 0, 0)];
                break;
            case 3:
                [tabButton setTitle:@"更多" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_a4"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"teacher_footb_b4"] forState:UIControlStateSelected];
                [tabButton setImageEdgeInsets:UIEdgeInsetsMake(8, 25, 21, 25)];
                [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -70, 0, 0)];
                break;
            default:
                break;
        }
        [self.tabBarImageView addSubview:tabButton];
    }
}

-(void)setMainView{
    //只创建一次
    UIViewController *vc = [[UIViewController alloc]init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    
    //选取第一vc
    self.mainImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenHeigth, ScreenHeigth - [self getNavHight] - 60)];
    self.mainImageView.clipsToBounds = YES;
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
            self.firstTabVC = [[t_FirstTabViewController alloc]init];
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, 0, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];
            
            self.headNavView.titleLabel.text = @"消息";
            UIImage *image = [UIImage imageNamed:@"icon_info_white.png"];
            UIImage *image2 = [UIImage imageNamed:@"back_press.png"];
            [self.rigthBtn setImage:image forState:UIControlStateNormal];
            [self.rigthBtn setImage:image2 forState:UIControlStateHighlighted];
            [self.rigthBtn setTitle:@"" forState:UIControlStateNormal];
            self.leftBtn.hidden = NO;
        }
            break;
        case 1:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.secondTabVC) {
                self.secondTabVC = [[t_SecondTabViewController alloc]init];
            }
            [self addChildViewController:self.secondTabVC];
            self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.secondTabVC;
            [self.mainImageView addSubview:self.secondTabVC.view];
            self.headNavView.titleLabel.text = @"班级";
            CGRect backBtnFrame;
            if (iOS7)
            {
                backBtnFrame = CGRectMake(14, 20, 60, 40);
            }
            else
            {
                backBtnFrame = CGRectMake(14, 0, 60, 40);
            }
            self.leftBtn.hidden = YES;
        }
            break;
        case 2:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.thirdTabVC) {
                self.thirdTabVC = [[t_ThirdTabViewController alloc]init];
            }
            [self addChildViewController:self.thirdTabVC];
            self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.thirdTabVC;
            [self.mainImageView addSubview:self.thirdTabVC.view];

            self.headNavView.titleLabel.text = @"通讯录";
            UIImage *image = [UIImage imageNamed:@""];
            UIImage *image2 = [UIImage imageNamed:@""];
            [self.rigthBtn setImage:image forState:UIControlStateNormal];
            [self.rigthBtn setImage:image2 forState:UIControlStateHighlighted];
            [self.rigthBtn setTitle:@"" forState:UIControlStateNormal];
            self.leftBtn.hidden = YES;
        }
            break;
        case 3:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.fouthTabVC) {
                self.fouthTabVC = [[t_FouthTabViewController alloc]init];
            }
            [self addChildViewController:self.fouthTabVC];
            self.fouthTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.fouthTabVC;
            [self.mainImageView addSubview:self.fouthTabVC.view];
            self.headNavView.titleLabel.text = @"更多";
            UIImage *image = [UIImage imageNamed:@""];
            UIImage *image2 = [UIImage imageNamed:@""];
            [self.rigthBtn setImage:image forState:UIControlStateNormal];
            [self.rigthBtn setImage:image2 forState:UIControlStateHighlighted];
            [self.rigthBtn setTitle:@"" forState:UIControlStateNormal];
            self.leftBtn.hidden = YES;
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
            babyListViewController *bVC = [[babyListViewController alloc]init];
            [self.navigationController pushViewController:bVC animated:YES];
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


