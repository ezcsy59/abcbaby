//
//  yaoQingViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "yaoQingViewController.h"

@interface yaoQingViewController ()<KGSelectViewDelegate>
@property(nonatomic,strong)UIScrollView *MainscrollView;
@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;
@property(nonatomic,strong)HJHMyButton *notEditBgImageView;
@property(nonatomic,assign)BOOL canHide;
@property(nonatomic,strong)KGTipView *tipView;
@property(nonatomic,strong)KGSelectView *relationSV;
@property(nonatomic,assign)int selectTag;
@end

@implementation yaoQingViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyhide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"验证邀请码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    self.MainscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, iPhone5?568:480)];
    self.MainscrollView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    [self.MainscrollView setContentSize:CGSizeMake(320, iPhone5?568:480)];
    self.MainscrollView.bounces = NO;
    [self.view addSubview:self.MainscrollView];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(15, 30, 300, 20);
    label1.text = @"请输入邀请码关联宝宝（9位数字）";
    label1.textColor = [UIColor colorWithHexString:@"666666"];
    label1.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(15, 130, 300, 20);
    label2.text = @"亲属关系";
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    label2.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.frame = CGRectMake(15, 230, 300, 20);
    label3.text = @"宝宝对您的称呼";
    label3.textColor = [UIColor colorWithHexString:@"666666"];
    label3.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label3];
    
    self.textField1 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15, 70, 290, 40) andFromRight:8];
    self.textField1.layer.cornerRadius = 5.0;
    self.textField1.backgroundColor = [UIColor whiteColor];
    self.textField1.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField1];
    
    self.textField2 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15, 170, 290, 40) andFromRight:8];
    self.textField2.text = @"妈妈";
    self.textField2.layer.cornerRadius = 5.0;
    self.textField2.backgroundColor = [UIColor whiteColor];
    self.textField2.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField2];
    
    HJHMyImageView *textField2IV = [[HJHMyImageView alloc]init];
    textField2IV.frame = self.textField2.frame;
    [self.MainscrollView addSubview:textField2IV];
    
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(relationTap)];
    [textField2IV addGestureRecognizer:timeTap];
    
    self.textField3 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15, 270, 290, 40) andFromRight:8];
    self.textField3.layer.cornerRadius = 5.0;
    self.textField3.delegate = self;
    self.textField3.backgroundColor = [UIColor whiteColor];
    self.textField3.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField3];
    
    
    
    HJHMyButton *compBtnClick = [[HJHMyButton alloc]init];
    if (iPhone5) {
        compBtnClick.frame = CGRectMake(15, 460, 290, 51);
    }
    else{
        compBtnClick.frame = CGRectMake(15, 400, 290, 51);
    }
    [compBtnClick setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [compBtnClick setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [compBtnClick setTitle:@"提交" forState:UIControlStateNormal];
    [compBtnClick addTarget:self action:@selector(compBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:compBtnClick];
}

-(void)compBtnClick{
    if (self.textField1.text.length == 0) {
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"你还没有填写邀请码！" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
    }
    else if (self.textField2.text.length == 0){
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"你还未填写宝宝对您的昵称！" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
    }
    else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboardNoti
-(void)keyshow:(NSNotification*)noti{
    if (!self.notEditBgImageView) {
        self.notEditBgImageView = [[HJHMyButton alloc]initWithFrame:self.view.bounds];
        [self.notEditBgImageView addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.notEditBgImageView];
    }
    if (self.canHide == NO) {
        self.canHide = YES;
    }
    self.notEditBgImageView.hidden = NO;
}

-(void)hideKeyboard{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
}

-(void)keyhide{
    if (self.canHide == YES) {
        self.notEditBgImageView.hidden = YES;
    }
}

#pragma mark - textfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.canHide = YES;
    [HJHKeyBoardViewChange keybaordShowChange:self.view];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.canHide == YES) {
        [HJHKeyBoardViewChange keybaordHideChange:self.view];
        self.canHide = NO;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)relationTap{
    self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:[groupOfArray getRelationArray]]];
    self.relationSV.delegate2 = self;
    [self.view addSubview:self.relationSV];
    self.selectTag = 10001;
}

-(void)selectBtnClick:(int)tag{
    if (self.selectTag == 10001) {
        self.textField2.text = [[groupOfArray getRelationArray] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
}

-(void)cancalSelectClicked{
    if (self.selectTag == 10001) {
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
}
@end
