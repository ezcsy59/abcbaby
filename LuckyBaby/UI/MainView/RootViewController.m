//
//  RootViewController.m
//  huang
//
//  Created by AA on 13-12-16.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    [self addLoginView];
    // Do any additional setup after loading the view.
    
}

-(void)delayPopback{
    //  [[MusicPlayEngine CreateSingleton] pause];
    NSLog(@"====== 退出当前帐号 ======");
}

-(void)addLoginView
{
    ////进入登陆页面
    self.loginViewController = [[HJHLoginViewController alloc] init];
    self.loginViewController.view.frame = self.view.bounds;
    self.loginNav = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    
    self.loginNav.navigationBar.hidden = YES;
    if (iOS7) {
        self.loginNav.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    else{
        self.loginNav.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height + 20);
    }
    
    if (iOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    [self.view addSubview:self.loginNav.view];
}

-(void)deleteLoginView
{
    [self.loginNav.view removeFromSuperview];
    self.loginViewController = nil;
    self.loginNav = nil;
    
}

-(void)addMainView
{
    self.view.backgroundColor = [UIColor clearColor];
    //进入主页
    self.mainTabViewController = [[MainBarViewController alloc] init];
    self.rootNav = [[UIBasicNavigationViewController alloc] initWithRootViewController:self.mainTabViewController];
    
    if (iOS7) {
        self.rootNav.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.mainTabViewController.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.mainTabViewController.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    }else{
        //self.rootNav.navigationBar.barStyle = UIBarStyleBlack;
        self.rootNav.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height + 20);
        [self.rootNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    if (iOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    [self.view addSubview:self.rootNav.view];
    self.rootNav.navigationBar.hidden = YES;
    
}

//新增一个main的tab主页
-(void)addT_MainView
{
    self.view.backgroundColor = [UIColor clearColor];
    //进入主页
    self.MainBarTeacherTabViewController = [[MainBarTeacherViewController alloc] init];
    self.rootNav = [[UIBasicNavigationViewController alloc] initWithRootViewController:self.MainBarTeacherTabViewController];
    
    if (iOS7) {
        self.rootNav.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.MainBarTeacherTabViewController.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.MainBarTeacherTabViewController.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    }else{
        //self.rootNav.navigationBar.barStyle = UIBarStyleBlack;
        self.rootNav.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height + 20);
        [self.rootNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    if (iOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    [self.view addSubview:self.rootNav.view];
    self.rootNav.navigationBar.hidden = YES;
    
}

-(void)deleteT_MainView
{
    [self.rootNav.view removeFromSuperview];
    self.MainBarTeacherTabViewController = nil;
    self.rootNav = nil;
}


-(void)returnLastPage{
}


-(void)deleteMainView
{
    [self.rootNav.view removeFromSuperview];
    self.mainTabViewController = nil;
    self.rootNav = nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
