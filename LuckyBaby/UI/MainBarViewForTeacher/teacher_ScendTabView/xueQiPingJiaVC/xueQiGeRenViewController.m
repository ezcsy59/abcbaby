//
//  xueQiGeRenViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-5-9.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "xueQiGeRenViewController.h"
#import "modChoseViewController.h"
#import "TeacherNetWork.h"
@interface xueQiGeRenViewController ()
@property(nonatomic,strong)UITextView *mainTextView;
@property(nonatomic,strong)NSArray *msgArray;
@end

@implementation xueQiGeRenViewController

-(id)initWithMessageArray:(NSArray *)array{
    if (self = [super init]) {
        self.msgArray = array;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveScoreSemesterSuccess:) name:@"saveScoreSemesterSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveScoreSemesterFail:) name:@"saveScoreSemesterFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)saveScoreSemesterSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveScoreSemesterFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"本月评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    self.mainTextView = [[UITextView alloc]init];
    self.mainTextView.frame = CGRectMake(10, [self getNavHight] + 10, 300, 250);
    self.mainTextView.layer.cornerRadius = 5.0;
    self.mainTextView.layer.borderColor = [UIColor colorWithHexString:@"93C6E9"].CGColor;
    self.mainTextView.layer.borderWidth = 0.5;
    self.mainTextView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.mainTextView];
    
    HJHMyButton *selectModBtn = [[HJHMyButton alloc]init];
    selectModBtn.frame = CGRectMake(10, 270 + [self getNavHight], 300, 60);
    [selectModBtn setBackgroundColor:[UIColor colorWithHexString:@"F08221"]];
    [selectModBtn setTitle:@"选择模版" forState:UIControlStateNormal];
    selectModBtn.layer.cornerRadius = 5.0;
    [selectModBtn addTarget:self action:@selector(ModBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectModBtn];
}

-(void)ModBtnClick{
    modChoseViewController *mVC = [[modChoseViewController alloc]init];
    [self.navigationController pushViewController:mVC animated:YES];
}

-(void)saveBtnClick{
    int i = 0;
    NSString *stringId = @"";
    NSString *stringName = @"";
    for (NSDictionary *dic in self.msgArray) {
        if (i == 0) {
            stringId = [DictionaryStringTool stringFromDictionary:dic forKey:@"childId"];
            stringName = [DictionaryStringTool stringFromDictionary:dic forKey:@"childName"];
        }
        else{
            stringId = [NSString stringWithFormat:@"%@,%@",stringId,[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"]];
            stringName = [NSString stringWithFormat:@"%@,%@",stringName,[DictionaryStringTool stringFromDictionary:dic forKey:@"childName"]];
        }
        i++;
    }
    
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet saveScoreSemesterWithPlatformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] classId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] teacherId:[DictionaryStringTool stringFromDictionary:dic forKey:@"teacherId"] scoreDesc:@"" childIdList:stringId childNameList:stringName];
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
