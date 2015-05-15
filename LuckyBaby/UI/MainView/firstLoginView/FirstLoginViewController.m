//
//  FirstLoginViewController.m
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "AppDelegate.h"

@interface FirstLoginViewController ()
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation FirstLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //需要在plist加View controller-based status bar appearance 为NO时才有效
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    NSString *bundleVersion = [userDf objectForKey:@"BundleVersion"];
    NSLog(@"%@",[[NSBundle mainBundle]infoDictionary]);
    NSString *plistBundleV = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    if (!bundleVersion) {
        [userDf setObject:plistBundleV forKey:@"BundleVersion"];
        [userDf synchronize];
        NSLog(@"%@",[userDf objectForKey:@"BundleVersion"]);
        self.bundleVersion = @"0";
    }else{
        self.bundleVersion = bundleVersion;
    }
    if (([self.bundleVersion intValue] < [plistBundleV intValue]) || [self.bundleVersion intValue] == 0) {
        [self setMainView];
        [self setPageControl];
    }else{
        [self login];
    }
	// Do any additional setup after loading the view.
}

-(void)setMainView{
    UIScrollView *newView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenOriginY, ScreenWidth, ScreenHeigth)];
    [newView setContentSize:CGSizeMake(ScreenWidth*3, ScreenHeigth)];
    newView.delegate = self;
    newView.showsHorizontalScrollIndicator = NO;
    newView.showsVerticalScrollIndicator = NO;
    newView.backgroundColor = [UIColor yellowColor];
    newView.pagingEnabled = YES;
    [self.view addSubview:newView];
    for (int i = 0; i < 3; i++) {
        //添加每一页的imageView
        HJHMyImageView *imageView = [[HJHMyImageView alloc]initWithFrame:CGRectMake(i*ScreenWidth, ScreenOriginY, ScreenWidth, ScreenHeigth)];
       if(i==0)
       {
         imageView.image = [UIImage imageNamed:@"111.png"];
       }       else if(i == 1)
        {
           imageView.image = [UIImage imageNamed:@"222.png"];
        }else{
            imageView.image = [UIImage imageNamed:@"333.png"];
        }
        [newView addSubview:imageView];
        if(i == 2){
            HJHMyButton *loginBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 50 , ScreenHeigth - 100, 100, 40)];
            loginBtn.backgroundColor = [UIColor redColor];
            [loginBtn setTitle:@"点击进入" forState:UIControlStateNormal];
            loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:loginBtn];
        }
    }
    
    self.view.backgroundColor = [UIColor blueColor];
}

-(void)setPageControl{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 30 , ScreenHeigth - 50, 60, 20)];
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
}

-(void)login{
    //获取UIApplication sharedApplication 的delegate
    RootViewController *rootVC = (RootViewController*)getCurrentRootController;
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = rootVC;
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/ScreenWidth;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
}
@end
