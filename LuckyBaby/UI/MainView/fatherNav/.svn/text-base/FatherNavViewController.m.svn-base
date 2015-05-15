//
//  FatherNavViewController.m
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

//自定义的一个navigation
#import "FatherNavViewController.h"

@interface FatherNavViewController ()
@end

@implementation FatherNavViewController

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
    [self initHead];
    //[self addLeftReturnBtn];
    //[self addRigthBtn];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initHead
{
    if (self.headNavView == nil)
    {
        self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigth);
        self.headNavView = [[PlayNavView alloc] init];
        self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#4DD0C8"];
        [self.view addSubview:self.headNavView];
    }
}

-(CGFloat)getNavHight
{
    if (self.headNavView)
    {
        if (iOS7)
        {
            return 65;
        }
        else
        {
            return 50;
        }
    }
    return 0.0;
}

-(void)addLeftReturnBtn
{
    CGRect backBtnFrame;
    if (iOS7)
    {
        backBtnFrame = CGRectMake(5, 19, 50, 50);
    }
    else
    {
        backBtnFrame = CGRectMake(5, 0, 50, 50);
    }
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = backBtnFrame;
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    UIImage *image = [UIImage imageNamed:@""];
    //UIImage *image2 = [UIImage imageNamed:@"back_press.png"];
    [self.leftBtn setImage:image forState:UIControlStateNormal];
    //[self.leftBtn setImage:image2 forState:UIControlStateHighlighted];
    [self.leftBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setExclusiveTouch:YES];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 70)];
    
    if (self.headNavView)
    {
        [self.headNavView addSubview:self.leftBtn];
    }
}

-(void)removeLeftBtn{
    [self.leftBtn removeFromSuperview];
    self.leftBtn = nil;
}

-(void)addRigthBtn
{
    CGRect backBtnFrame;
    if (iOS7)
    {
        backBtnFrame = CGRectMake(269, 19, 50, 50);
    }
    else
    {
        backBtnFrame = CGRectMake(269, 0, 50, 50);
    }
    
    self.rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rigthBtn.frame = backBtnFrame;
    self.rigthBtn.titleLabel.font = [UIFont systemFontOfSize:20];
//    UIImage *image = [UIImage imageNamed:@""];
//    UIImage *image2 = [UIImage imageNamed:@""];
//    //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
//    [self.rigthBtn setImage:image forState:UIControlStateNormal];
//    [self.rigthBtn setImage:image2 forState:UIControlStateHighlighted];
//    [self.rigthBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.rigthBtn setExclusiveTouch:YES];
    //[self.rigthBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 80)];
    
    if (self.headNavView)
    {
        [self.headNavView addSubview:self.rigthBtn];
    }
}

-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
