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

#import "btn1Click_ViewController.h"
#import "btn2Click_ViewController.h"
#import "T_shiPuViewController.h"
#import "selectClassViewController.h"
#import "youerChuQInViewController.h"
#import "jiBingQuShiViewController.h"
#import "banJi_xiangCeViewController.h"
#import "BanjiQuanViewController.h"
#import "T_keBiaoViewController.h"
#import "yueDuPingJiaViewController.h"
#import "zhouPingJiaViewController.h"
#import "xueQiPingJiaViewController.h"

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
    self.view.backgroundColor = [UIColor whiteColor];
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
    mainSV.frame = CGRectMake(0, 0, 320, 360);
    mainSV.backgroundColor = [UIColor whiteColor];
    mainSV.showsHorizontalScrollIndicator = NO;
    mainSV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainSV];
    
    HJHMyImageView *bgColorImageView = [[HJHMyImageView alloc]init];
    bgColorImageView.frame = CGRectMake(0, 40, 320, 80);
    bgColorImageView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [mainSV addSubview:bgColorImageView];
    
    HJHMyImageView *bgColorImageView2 = [[HJHMyImageView alloc]init];
    bgColorImageView2.frame = CGRectMake(0, 160, 320, 80);
    bgColorImageView2.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [mainSV addSubview:bgColorImageView2];
    
    HJHMyImageView *bgColorImageView3 = [[HJHMyImageView alloc]init];
    bgColorImageView3.frame = CGRectMake(0, 280, 320, 80);
    bgColorImageView3.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [mainSV addSubview:bgColorImageView3];
    
    for (int i = 0; i < 9; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(25 + 106 * (i%3), 50 + 120* (i/3), 40, 40);
//        btn.backgroundColor = [UIColor yellowColor];
        btn.tag = i;
        btn.layer.cornerRadius = 20;
        
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(10 + 106 * (i%3), 95 + 120* (i/3), 70, 20);
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [mainSV addSubview:label];
        NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
        if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 1) {
            switch (i) {
                case 0:
                {
                    [btn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
                    label.text = @"发部门通知";
                }
                    break;
                case 1:
                {
                    [btn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
                    label.text = @"发班级通知";
                }
                    break;
                case 2:
                {
                    [btn setImage:[UIImage imageNamed:@"ico_home_teach"] forState:UIControlStateNormal];
                    label.text = @"幼儿出勤";
                }
                    break;
                case 3:
                {
                    [btn setImage:[UIImage imageNamed:@"trends"] forState:UIControlStateNormal];
                    label.text = @"疾病趋势";
                }
                    break;
                case 4:
                {
                    [btn setImage:[UIImage imageNamed:@"cookbook_img"] forState:UIControlStateNormal];
                    label.text = @"食谱";
                }
                    break;
                case 5:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_photo_icon"] forState:UIControlStateNormal];
                    label.text = @"班级相册";
                }
                    break;
                case 6:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_class_circle_icon"] forState:UIControlStateNormal];
                    label.text = @"班级圈";
                }
                    break;
                case 7:
                {
                    [btn setImage:[UIImage imageNamed:@"class_schedule"] forState:UIControlStateNormal];
                    label.text = @"课表";
                }
                    break;
                case 8:
                {
                    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
                    break;
                    
                default:
                    break;
            }
        }
        else{
            switch (i) {
                case 0:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_photo_icon"] forState:UIControlStateNormal];
                    label.text = @"班级相册";
                }
                    break;
                case 1:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_class_circle_icon"] forState:UIControlStateNormal];
                    label.text = @"班级圈";
                }
                    break;
                case 2:
                {
                    [btn setImage:[UIImage imageNamed:@"ico_home_teach"] forState:UIControlStateNormal];
                    label.text = @"幼儿出勤";
                }
                    break;
                case 3:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_childshow_icon"] forState:UIControlStateNormal];
                    label.text = @"本周表现";
                }
                    break;
                case 4:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_month_icon"] forState:UIControlStateNormal];
                    label.text = @"本月评价";
                }
                    break;
                case 5:
                {
                    [btn setImage:[UIImage imageNamed:@"teach_endterm_icon"] forState:UIControlStateNormal];
                    label.text = @"学期评价";
                }
                    break;
                case 6:
                {
                    [btn setImage:[UIImage imageNamed:@"cookbook_img"] forState:UIControlStateNormal];
                    label.text = @"食谱";
                }
                    break;
                case 7:
                {
                    [btn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
                    label.text = @"发班级通知";
                }
                    break;
                case 8:
                {
                    [btn setImage:[UIImage imageNamed:@"class_schedule"] forState:UIControlStateNormal];
                    label.text = @"课表";
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mainSV addSubview:btn];
    }
}

-(void)btnClick:(HJHMyButton *)btn{
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]integerValue] == 1) {
        switch (btn.tag) {
            case 0:
            {
                btn1Click_ViewController *bVC = [[btn1Click_ViewController alloc]init];
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 1:
            {
                btn2Click_ViewController *bVC = [[btn2Click_ViewController alloc]init];
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 2:
            {
                youerChuQInViewController *yVC = [[youerChuQInViewController alloc]init];
                [self.navigationController pushViewController:yVC animated:YES];
            }
                break;
            case 3:
            {
                jiBingQuShiViewController *jVC = [[jiBingQuShiViewController alloc]init];
                [self.navigationController pushViewController:jVC animated:YES];
            }
                break;
            case 4:
            {
                T_shiPuViewController *daVC = [[T_shiPuViewController alloc]init];
                [self.navigationController pushViewController:daVC animated:YES];
            }
                break;
            case 5:
            {
                selectClassViewController *bVC = [[selectClassViewController alloc]init];
                bVC.style = 1;
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 6:
            {
                selectClassViewController *bVC = [[selectClassViewController alloc]init];
                bVC.style = 2;
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 7:
            {
                selectClassViewController *bVC = [[selectClassViewController alloc]init];
                bVC.style = 3;
                [self.navigationController pushViewController:bVC animated:YES];
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
    else{
        switch (btn.tag) {
            case 0:
            {
                banJi_xiangCeViewController *bVC = [[banJi_xiangCeViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] className:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"] style:1];
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 1:
            {
                BanjiQuanViewController *bVC = [[BanjiQuanViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] className:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"]];
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 2:
            {
                youerChuQInViewController *yVC = [[youerChuQInViewController alloc]init];
                [self.navigationController pushViewController:yVC animated:YES];
            }
                break;
            case 3:
            {
                zhouPingJiaViewController *yVC = [[zhouPingJiaViewController alloc]init];
                [self.navigationController pushViewController:yVC animated:YES];
            }
                break;
            case 4:
            {
                yueDuPingJiaViewController *yVC = [[yueDuPingJiaViewController alloc]init];
                [self.navigationController pushViewController:yVC animated:YES];
            }
                break;
            case 5:
            {
                xueQiPingJiaViewController *yVC = [[xueQiPingJiaViewController alloc]init];
                [self.navigationController pushViewController:yVC animated:YES];
            }
                break;
            case 6:
            {
                T_shiPuViewController *daVC = [[T_shiPuViewController alloc]init];
                [self.navigationController pushViewController:daVC animated:YES];
            }
                break;
            case 7:
            {
                btn2Click_ViewController *bVC = [[btn2Click_ViewController alloc]init];
                [self.navigationController pushViewController:bVC animated:YES];
            }
                break;
            case 8:
            {
                T_keBiaoViewController *kVC = [[T_keBiaoViewController alloc]initWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]];
                [self.navigationController pushViewController:kVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
