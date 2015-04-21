//
//  t_SecondTabViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//
#define kDefaultToolbarHeight 42
#define kIOS7 0

#import "t_SecondTabViewController.h"
#import "SeTableViewCell.h"
#import "jianKangNetWork.h"
#import "chengZhangViewController.h"
#import "baoBaoBinLiViewController.h"
#import "knowWebViewController.h"
#import "yiMiaoViewController.h"
#import "tijianjiluViewController.h"

@interface t_SecondTabViewController ()
@property(nonatomic,strong)NSArray *jianKangListArray;
@end

@implementation t_SecondTabViewController

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
    [self getData];
    [self setMainImageView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewWillDisappear:(BOOL)animated{
}

#pragma mark -logic data
-(void)getData{
}

-(void)setMainImageView{
    UIScrollView *mainSV = [[UIScrollView alloc]init];
    mainSV.frame = CGRectMake(0, 0, 320, 300);
    mainSV.showsHorizontalScrollIndicator = NO;
    mainSV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainSV];
    
    for (int i = 0; i < 9; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(25 + 106 * (i%3), 40 + 80* (i/3), 60, 60);
        btn.backgroundColor = [UIColor yellowColor];
        btn.tag = i;
        btn.layer.cornerRadius = 30;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mainSV addSubview:btn];
    }
}

-(void)btnClick:(HJHMyButton *)btn{
    switch (btn.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
