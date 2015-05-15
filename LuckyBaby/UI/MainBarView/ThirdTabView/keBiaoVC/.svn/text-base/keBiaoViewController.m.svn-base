//
//  keBiaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "keBiaoViewController.h"
#import "youErYuanNetWork.h"
#import "KGKeChengView.h"

@interface keBiaoViewController ()
@property(nonatomic,strong)NSMutableArray *keChengBiaoArray;

@end

@implementation keBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"课程表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCourseSchedulePlatformWeekSuccess:) name:@"getCourseSchedulePlatformWeekSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCourseSchedulePlatformWeekFail:) name:@"getCourseSchedulePlatformWeekFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    self.keChengBiaoArray = [NSMutableArray array];
    youErYuanNetWork *youErYuanNetWork1 = [[youErYuanNetWork alloc]init];
    [youErYuanNetWork1 getCourseSchedulePlatformWeekWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"]  semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"]  platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
}

-(void)getCourseSchedulePlatformWeekSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    NSArray *arr = [dict objectForKey:@"courseDailyList"];
    
    [self.keChengBiaoArray removeAllObjects];
    for (int i = 0; i < 30; i++) {
        if (i < 6) {
            NSDictionary *dayDic = [arr objectAtIndex:0];
            NSArray *dayArr = [dayDic objectForKey:@"courseUnitList"];
            NSDictionary *coursDic = [dayArr objectAtIndex:i];
            NSString *kecheng = [coursDic objectForKey:@"courseName"];
            if (![kecheng isKindOfClass:[NSString class]]) {
                kecheng = @"";
            }
            [self.keChengBiaoArray addObject:kecheng];
        }
        if (i > 5 && i < 12) {
            NSDictionary *dayDic = [arr objectAtIndex:1];
            NSArray *dayArr = [dayDic objectForKey:@"courseUnitList"];
            NSDictionary *coursDic = [dayArr objectAtIndex:i - 6];
            NSString *kecheng = [coursDic objectForKey:@"courseName"];
            if (![kecheng isKindOfClass:[NSString class]]) {
                kecheng = @"";
            }
            [self.keChengBiaoArray addObject:kecheng];
        }
        if (i > 11 && i < 18) {
            NSDictionary *dayDic = [arr objectAtIndex:2];
            NSArray *dayArr = [dayDic objectForKey:@"courseUnitList"];
            NSDictionary *coursDic = [dayArr objectAtIndex:i - 12];
            NSString *kecheng = [coursDic objectForKey:@"courseName"];
            if (![kecheng isKindOfClass:[NSString class]]) {
                kecheng = @"";
            }
            [self.keChengBiaoArray addObject:kecheng];
        }
        if (i > 17 && i < 24) {
            NSDictionary *dayDic = [arr objectAtIndex:3];
            NSArray *dayArr = [dayDic objectForKey:@"courseUnitList"];
            NSDictionary *coursDic = [dayArr objectAtIndex:i - 18];
            NSString *kecheng = [coursDic objectForKey:@"courseName"];
            if (![kecheng isKindOfClass:[NSString class]]) {
                kecheng = @"";
            }
            [self.keChengBiaoArray addObject:kecheng];
        }
        if (i > 23 && i < 30) {
            NSDictionary *dayDic = [arr objectAtIndex:4];
            NSArray *dayArr = [dayDic objectForKey:@"courseUnitList"];
            NSDictionary *coursDic = [dayArr objectAtIndex:i - 24];
            NSString *kecheng = [coursDic objectForKey:@"courseName"];
            if (![kecheng isKindOfClass:[NSString class]]) {
                kecheng = @"";
            }
            [self.keChengBiaoArray addObject:kecheng];
        }
    }
    KGKeChengView *kView = [[KGKeChengView alloc]initWithFrame:CGRectMake(0, [self getNavHight], 320, 460) labelArray:self.keChengBiaoArray];
    [self.view addSubview:kView];
}

-(void)getCourseSchedulePlatformWeekFail:(NSNotification*)noti{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
