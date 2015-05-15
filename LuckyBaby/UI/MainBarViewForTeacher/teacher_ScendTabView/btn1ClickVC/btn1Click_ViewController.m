//
//  btn1Click_ViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "btn1Click_ViewController.h"
#import "addBuMenViewController.h"
#import "TeacherNetWork.h"

@interface btn1Click_ViewController ()<UITextFieldDelegate,UITextViewDelegate,addBuMenViewDelegate,HJHPickerViewDelegate>
@property(nonatomic,assign)int selectTag;
@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;
@property(nonatomic,strong)HJHMyTextField *textField4;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)HJHMyImageView *bgMengCeng;
@property(nonatomic,strong)HJHPickerView *sV;
@property(nonatomic,strong)NSMutableArray *buMenArray;
@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;
@end

@implementation btn1Click_ViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDeptWithGradeSuccess:) name:@"listDeptWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDeptWithGradeFail:) name:@"listDeptWithGradeFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePlatformInformSuccess:) name:@"savePlatformInformSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePlatformInformWithGradeFail:) name:@"savePlatformInformWithGradeFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.fisrtXiangQingArray = [NSMutableArray array];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet listDeptWithGradeWithTeacherId:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] appType:[DictionaryStringTool stringFromDictionary:dic forKey:@"appType"]];
}

#pragma mark -logic data
-(void)savePlatformInformSuccess:(NSNotification*)noti{
    //************************
}

-(void)savePlatformInformWithGradeFail:(NSNotification*)noti{
    
}

-(void)listDeptWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
    }
    //************************
}

-(void)listDeptWithGradeFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    self.buMenArray = [NSMutableArray array];
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"发班级通知";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];

    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setMainScrollView];
    
    [self setBgMengCeng];
    // Do any additional setup after loading the view.
}

-(void)setBgMengCeng{
    self.bgMengCeng = [[HJHMyImageView alloc]init];
    self.bgMengCeng.frame = self.view.frame;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.bgMengCeng addGestureRecognizer:tap];
    [self.view addSubview:self.bgMengCeng];
    self.bgMengCeng.userInteractionEnabled = NO;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.bgMengCeng.userInteractionEnabled = NO;
}

-(void)hideKeyBoard{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textView resignFirstResponder];
}

-(void)setMainScrollView{
    UIScrollView *sVC = [[UIScrollView alloc]init];
    sVC.frame = CGRectMake(0, [self getNavHight], 320, (iPhone5?568:480) - [self getNavHight]);
    sVC.showsHorizontalScrollIndicator = NO;
    sVC.showsVerticalScrollIndicator = NO;
    [self.view addSubview:sVC];
    
    if (!self.textField1) {
        self.textField1 = [[HJHMyTextField alloc]init];
    }
    self.textField1.frame = CGRectMake(10, 10, 250, 35);
    self.textField1.fromRight = 10;
    self.textField1.delegate = self;
    self.textField1.layer.cornerRadius = 5.0;
    self.textField1.text = @"";
    self.textField1.userInteractionEnabled = NO;
    self.textField1.backgroundColor = [UIColor whiteColor];
    self.textField1.layer.borderColor = [UIColor colorWithHexString:@"1B7DDE"].CGColor;
    self.textField1.layer.borderWidth = 0.5;
    self.textField1.font = [UIFont systemFontOfSize:15];
    [sVC addSubview:self.textField1];
    
    if (!self.textField2) {
        self.textField2 = [[HJHMyTextField alloc]init];
    }
    self.textField2.frame = CGRectMake(10, 55, 300, 35);
    self.textField2.fromRight = 10;
    self.textField2.delegate = self;
    self.textField2.layer.cornerRadius = 5.0;
    self.textField2.text = @"";
    self.textField2.placeholder = @"有效起始日期";
    self.textField2.backgroundColor = [UIColor whiteColor];
    self.textField2.layer.borderColor = [UIColor colorWithHexString:@"1B7DDE"].CGColor;
    self.textField2.layer.borderWidth = 0.5;
    self.textField2.font = [UIFont systemFontOfSize:15];
    [sVC addSubview:self.textField2];
    
    HJHMyButton *btn = [[HJHMyButton alloc]init];
    btn.frame = self.textField2.frame;
    btn.tag = 1001;
    [btn addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sVC addSubview:btn];
    
    if (!self.textField3) {
        self.textField3 = [[HJHMyTextField alloc]init];
    }
    self.textField3.frame = CGRectMake(10, 100, 300, 35);
    self.textField3.fromRight = 10;
    self.textField3.delegate = self;
    self.textField3.layer.cornerRadius = 5.0;
    self.textField3.text = @"";
    self.textField3.placeholder = @"有效截止日期";
    self.textField3.backgroundColor = [UIColor whiteColor];
    self.textField3.layer.borderColor = [UIColor colorWithHexString:@"1B7DDE"].CGColor;
    self.textField3.layer.borderWidth = 0.5;
    self.textField3.font = [UIFont systemFontOfSize:15];
    [sVC addSubview:self.textField3];
    
    HJHMyButton *btn2 = [[HJHMyButton alloc]init];
    btn2.frame = self.textField3.frame;
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sVC addSubview:btn2];
    
    if (!self.textField4) {
        self.textField4 = [[HJHMyTextField alloc]init];
    }
    self.textField4.frame = CGRectMake(10, 145, 300, 35);
    self.textField4.fromRight = 10;
    self.textField4.delegate = self;
    self.textField4.layer.cornerRadius = 5.0;
    self.textField4.text = @"";
    self.textField4.placeholder = @"标题";
    self.textField4.backgroundColor = [UIColor whiteColor];
    self.textField4.layer.borderColor = [UIColor colorWithHexString:@"1B7DDE"].CGColor;
    self.textField4.layer.borderWidth = 0.5;
    self.textField4.font = [UIFont systemFontOfSize:15];
    [sVC addSubview:self.textField4];
    
    self.textView = [[UITextView alloc]init];
    self.textView.frame = CGRectMake(10, 190, 300, 300);
    self.textView.delegate = self;
    self.textView.layer.cornerRadius = 5.0;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"1B7DDE"].CGColor;
    self.textView.layer.borderWidth = 0.5;
    [sVC addSubview:self.textView];
    
    HJHMyButton *rightClickBtn = [[HJHMyButton alloc]init];
    rightClickBtn.frame = CGRectMake(275, 10, 30, 30);
    [rightClickBtn setImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
    [rightClickBtn addTarget:self action:@selector(rightClickBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sVC addSubview:rightClickBtn];
}

-(void)rightClickBtnClick{
    addBuMenViewController *aVC = [[addBuMenViewController alloc]initWithBuMenArray:self.fisrtXiangQingArray];
    aVC.delegate2 = self;
    [self.navigationController pushViewController:aVC animated:YES];
}

-(void)selectBuMenArray:(NSArray *)array{
    self.textField1.text = @"";
    self.buMenArray = [[NSMutableArray alloc]initWithArray:array];
    for (int i = 0; i < self.buMenArray.count; i++) {
        NSDictionary *dic = [self.buMenArray objectAtIndex:i];
        if (i == 0) {
            self.textField1.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"];
        }
        else{
            self.textField1.text = [NSString stringWithFormat:@"%@,%@",self.textField1.text,[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]];
        }
        
    }
}

-(void)selectViewBtnClick:(HJHMyButton *)btn{
    if (btn.tag == 1001) {
        self.sV = [[HJHPickerView alloc]init];
        self.sV.delegate2 = self;
        [self.view addSubview:self.sV];
        self.selectTag = 10001;
    }
    if (btn.tag == 1002) {
        self.sV = [[HJHPickerView alloc]init];
        self.sV.delegate2 = self;
        [self.view addSubview:self.sV];
        self.selectTag = 10002;
    }
}

-(void)saveBtnClick{
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if (self.textView.text.length > 0 && self.textField1.text.length > 0 && self.textField2.text.length > 0 && self.textField3.text.length > 0 &&self.textField4.text.length > 0) {
        
        NSString *string1;
        NSString *string2;
        for (NSDictionary *dic in self.buMenArray) {
            if(string1.length > 0){
                string1 = [NSString stringWithFormat:@"%@ || %@",string1,[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"]];
            }
            else{
                string1 = [DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"];
            }
            if (string2.length > 0) {
                string2 = [NSString stringWithFormat:@"%@ || %@",string2,[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]];
            }
            else{
                string2 = [DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"];
            }
        }
        NSString *time1 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:self.textField2.text]];
        NSString *time2 = [NSString stringWithFormat:@"%@000",[TimeChange timeChage2:self.textField3.text]];
        [tNet savePlatformInformWithGradeWithInfoTitle:self.textField4.text infoContent:self.textView.text dateStart:time1 dateEnd:time2 semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] publicClass:string1 publicClassNames:string2 publicDept:@"" publicDeptNames:@"" platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
    }
    else{
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"还有信息没有填写完成" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
        [tipView show];
    }
}

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    if(self.selectTag == 10001){
        self.textField2.text = area;
    }
    else{
        self.textField3.text = area;
    }
    [self.sV removeFromSuperview];
    self.sV = nil;
}

-(void)hjhCancalbClicked{
    [self.sV removeFromSuperview];
    self.sV = nil;
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
