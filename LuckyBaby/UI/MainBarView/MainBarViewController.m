//
//  MainBarViewController.m
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "MainBarViewController.h"
#import "babyListViewController.h"
#import "addShiJianTableViewController.h"

@interface MainBarViewController ()
//当前主页
@property(nonatomic,strong)HJHMyImageView *mainImageView;
//bar栏的img
@property(nonatomic,strong)HJHMyImageView *tabBarImageView;
//当前的tab
@property(nonatomic,assign)NSInteger currentTab;

@property(nonatomic,strong)HJHMyImageView *redPoint;
@property(nonatomic,strong)HJHMyImageView *redPoint2;

//横线
@property(nonatomic,strong)HJHMyImageView *grayline;


@property(nonatomic,strong)UIViewController *currentViewController;
@end

@implementation MainBarViewController

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
    [self addLeftReturnBtn];
    [self setTabBar];
    [self choseView:0];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeClassName:) name:@"changeClassName" object:nil];
    
    
    // Do any additional setup after loading the view.
}

-(void)changeClassName:(NSNotification*)noti{
    self.headNavView.titleLabel.text = [noti object];
}

//重设做返回键，隐藏改键，覆盖父类方法即可
-(void)addLeftReturnBtn
{
    CGRect backBtnFrame;
    if (iOS7)
    {
        backBtnFrame = CGRectMake(7, 19, 80, 50);
    }
    else
    {
        backBtnFrame = CGRectMake(7, 0, 80, 50);
    }
    
    self.leftBtn = [[UIButton alloc]init];
    self.leftBtn.frame = backBtnFrame;
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.leftBtn setTitle:@"宝宝列表" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.leftBtn setExclusiveTouch:YES];
    self.leftBtn.tag = 1;
    [self.leftBtn addTarget:self action:@selector(gotoNextPage:) forControlEvents:UIControlEventTouchUpInside];
    if (self.headNavView)
    {
        [self.headNavView addSubview:self.leftBtn];
    }
}

//加右btn
-(void)addRigthBtn
{
    CGRect backBtnFrame;
    if (iOS7)
    {
        backBtnFrame = CGRectMake(274, 20, 40, 40);
    }
    else
    {
        backBtnFrame = CGRectMake(274, 0, 40, 40);
    }
    
    self.rigthBtn = [[UIButton alloc]init];
    self.rigthBtn.frame = backBtnFrame;
    [self.rigthBtn addTarget:self action:@selector(gotoNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.rigthBtn setExclusiveTouch:YES];
    //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 80)];
    
    if (self.headNavView)
    {
        [self.headNavView addSubview:self.rigthBtn];
    }
}

-(void)setTabBar{
    self.tabBarImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, ScreenHeigth - 60, ScreenWidth, 60)];
    self.tabBarImageView.clipsToBounds = NO;
    self.tabBarImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabBarImageView];
    
    for (int i = 0; i < 4; i++) {
        HJHMyButton * tabButton = [[HJHMyButton alloc]init];
        if (i == 0) {
            tabButton.frame = CGRectMake(0, -5, 64, 60);
        }
        
        if(i == 1){
            tabButton.frame = CGRectMake(i*64, -5, 64, 60);
        }
        else if(i >= 2){
            tabButton.frame = CGRectMake((i+1)*64+10, -5, 64, 60);
        }
        
        tabButton.clipsToBounds = NO;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:12];
        tabButton.tag = i;
        [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabButton addTarget:self action:@selector(choseViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                [tabButton setTitle:@"动态" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_mybaby_icon_down_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_mybaby_icon_down_s.png"] forState:UIControlStateSelected];
                break;
            case 1:
                [tabButton setTitle:@"健康" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_health_icon_down_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_health_icon_down_s.png"] forState:UIControlStateSelected];
                break;
            case 2:
                [tabButton setTitle:@"幼儿园" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_kindergarten_icon_down_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_kindergarten_icon_down_s.png"] forState:UIControlStateSelected];
                break;
            case 3:
                [tabButton setTitle:@"更多" forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_more_icon_down_n.png"] forState:UIControlStateNormal];
                [tabButton setImage:[UIImage imageNamed:@"fooder_more_icon_down_s.png"] forState:UIControlStateSelected];
                break;
            default:
                break;
        }
        [tabButton setImageEdgeInsets:UIEdgeInsetsMake(6, 13, 21, 13)];
        [tabButton setTitleEdgeInsets:UIEdgeInsetsMake(40, -37, 0, 0)];
        [self.tabBarImageView addSubview:tabButton];
    }
    
    HJHMyButton *BarAddBtn = [[HJHMyButton alloc]init];
    BarAddBtn.frame = CGRectMake(64*2 + 8, 5, 50, 50);
    [BarAddBtn setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [BarAddBtn addTarget:self action:@selector(addShiJianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarImageView addSubview:BarAddBtn];
    
    self.grayline = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    self.grayline.backgroundColor=[UIColor lightGrayColor];
    [self.tabBarImageView addSubview:self.grayline];
    
    
}

-(void)setMainView{
    //只创建一次
    UIViewController *vc = [[UIViewController alloc]init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
    
    //选取第一vc
    self.mainImageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenHeigth, ScreenHeigth - [self getNavHight] - 50)];
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
    
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
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
                       if (!self.firstTabVC) {
            self.firstTabVC = [[FirstTabViewController alloc]init];
                        }
            [self addChildViewController:self.firstTabVC];
            self.firstTabVC.view.frame = CGRectMake(0, 0, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.firstTabVC;
            [self.mainImageView addSubview:self.firstTabVC.view];

//            self.headNavView.titleLabel.text = @"动态";
            self.headNavView.titleLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"childNicknameFamilyCurrent"];
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
                self.secondTabVC = [[SecondTabViewController alloc]init];
            }
            [self addChildViewController:self.secondTabVC];
            self.secondTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.secondTabVC;
            [self.mainImageView addSubview:self.secondTabVC.view];
            
            //[self.mainImageView bringSubviewToFront:self.secondTabVC.view];
//            self.headNavView.titleLabel.text = @"健康";
            self.headNavView.titleLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"childNicknameFamilyCurrent"];
            //            UIImage *image = [UIImage imageNamed:@""];
            //            UIImage *image2 = [UIImage imageNamed:@""];
            //            //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
            //            [self.rigthBtn setImage:image forState:UIControlStateNormal];
            //            [self.rigthBtn setImage:image2 forState:UIControlStateHighlighted];
            //            [self.rigthBtn setTitle:@"" forState:UIControlStateNormal];
            //            [super addLeftReturnBtn];
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
            //            [self.leftBtn setImage:[UIImage imageNamed:@"arrow_down_white.png"] forState:UIControlStateNormal];
            //            [self.leftBtn setTitle:@"" forState:UIControlStateNormal];
            //            [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 5)];
            //            [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
            //
            //            self.leftBtn.frame = backBtnFrame;
            //            [self.leftBtn addTarget:self.secondTabVC action:@selector(pushViewControllerWithLelf) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 2:
        {
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = nil;
            if (!self.thirdTabVC) {
                self.thirdTabVC = [[ThirdTabViewController alloc]init];
            }
            [self addChildViewController:self.thirdTabVC];
            self.thirdTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.thirdTabVC;
            [self.mainImageView addSubview:self.thirdTabVC.view];
            
            //[self.mainImageView bringSubviewToFront:self.thirdTabVC.view];
            self.headNavView.titleLabel.text = @"幼儿园";
            UIImage *image = [UIImage imageNamed:@""];
            UIImage *image2 = [UIImage imageNamed:@""];
            //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
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
                self.fouthTabVC = [[FouthTabViewController alloc]init];
            }
            [self addChildViewController:self.fouthTabVC];
            self.fouthTabVC.view.frame = CGRectMake(0, -5, ScreenHeigth, ScreenHeigth - [self getNavHight] - 45);
            self.currentViewController = self.fouthTabVC;
            [self.mainImageView addSubview:self.fouthTabVC.view];
            
            //[self.mainImageView bringSubviewToFront:self.fouthTabVC.view];
            self.headNavView.titleLabel.text = @"更多";
            UIImage *image = [UIImage imageNamed:@""];
            UIImage *image2 = [UIImage imageNamed:@""];
            //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end


