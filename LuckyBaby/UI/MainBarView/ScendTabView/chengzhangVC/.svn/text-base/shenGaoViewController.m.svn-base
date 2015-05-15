//
//  shenGaoViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "shenGaoViewController.h"
#import "jianKangNetWork.h"
#import "SHView.h"

@interface shenGaoViewController ()
@property (nonatomic,strong)NSArray *heightArray;
@end

@implementation shenGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHeightRefSuccess:) name:@"listHeightRefSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listHeightRefFail:) name:@"listHeightRefFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    jianKangNetWork *jianKangNetWork1 = [[jianKangNetWork alloc]init];
    [jianKangNetWork1 listHeightRefWithGender:[DictionaryStringTool stringFromDictionary:dic forKey:@"childGender"]];
}

-(void)listHeightRefSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableArray *array3 = [NSMutableArray array];
    NSMutableArray *array4 = [NSMutableArray array];
    int i = 0;
    for (NSDictionary *dict in array) {
        NSString *hight1 = [dict objectForKey:@"mean"];
        NSString *hight2 = [dict objectForKey:@"n2"];
        NSString *hight3 = [dict objectForKey:@"p2"];
        NSString *age = [NSString stringWithFormat:@"%@月",[dict objectForKey:@"monthAge"]];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic1 setObject:hight1 forKey:[NSString stringWithFormat:@"%d",i]];
        [dic2 setObject:hight2 forKey:[NSString stringWithFormat:@"%d",i]];
        [dic3 setObject:hight3 forKey:[NSString stringWithFormat:@"%d",i]];
        [dic4 setObject:age forKey:[NSString stringWithFormat:@"%d",i]];
        [array1 addObject:dic1];
        [array2 addObject:dic2];
        [array3 addObject:dic3];
        [array4 addObject:dic4];
        i++;
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.clipsToBounds = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 0, 568/2, 400);
    scrollView.contentSize = CGSizeMake(array4.count * 40, 400);
    [self.view addSubview:scrollView];
    SHView *sV = [[SHView alloc]initWithFrame:CGRectZero andxAxisValues:array1 plottingValues:array2 plottingPointsLabels:array3 ageArray:array4 topHeight:140];
    [scrollView addSubview:sV];
    self.view.userInteractionEnabled = YES;
}

-(void)listHeightRefFail:(NSNotification*)noti{
    
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
