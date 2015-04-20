//
//  SetPasswordViewController.m
//  shuoshuo3
//
//  Created by Dickson on 14-3-22.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "LoginNetWork.h"
#import "yaoQingViewController.h"
#import "tianjiaBabyViewController.h"

@interface SetPasswordViewController ()
@property(nonatomic,strong)HJHMyTextField *userIdField;
@property(nonatomic,strong)HJHMyTextField *passWordField;
@property(nonatomic,strong)HJHMyTextField *userNickNameField;
@property(nonatomic,strong)HJHMyTextField *passComformPasswordField;
@property(nonatomic,strong)HJHMyButton *notEditBgImageView;
@property(nonatomic,assign)BOOL canHide;
@property(nonatomic,strong)KGTipView *tipView;
@property(nonatomic,strong)HJHMyImageView *textImageView;
@end

@implementation SetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyshow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyhide) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regiterSuccess:) name:@"registerSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regiterFail:) name:@"registerFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginFail:) name:@"loginFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [self setMainTextView];
    
    [self setRegisterBtn];

	// Do any additional setup after loading the view.
}

-(void)setMainTextView{
    self.textImageView = [[HJHMyImageView alloc]init];
    self.textImageView.frame = CGRectMake(0, 100, 320, 200);
    self.textImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textImageView];
    
    HJHMyImageView *headLayer = [[HJHMyImageView alloc]init];
    headLayer.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    headLayer.frame = CGRectMake(0, 0, 320, 1);
    [self.textImageView addSubview:headLayer];
    
    HJHMyImageView *footLayer = [[HJHMyImageView alloc]init];
    footLayer.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    footLayer.frame = CGRectMake(0, 199, 320, 1);
    [self.textImageView addSubview:footLayer];
    
    HJHMyImageView *Layer1 = [[HJHMyImageView alloc]init];
    Layer1.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    Layer1.frame = CGRectMake(15, 50, 290, 1);
    [self.textImageView addSubview:Layer1];
    
    HJHMyImageView *Layer2 = [[HJHMyImageView alloc]init];
    Layer2.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    Layer2.frame = CGRectMake(15, 100, 290, 1);
    [self.textImageView addSubview:Layer2];
    
    HJHMyImageView *Layer3 = [[HJHMyImageView alloc]init];
    Layer3.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    Layer3.frame = CGRectMake(15, 150, 290, 1);
    [self.textImageView addSubview:Layer3];
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    label1.frame = CGRectMake(15, 1, 70, 48);
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = @"账号 :";
    [self.textImageView addSubview:label1];
    
    self.userIdField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1, 200, 48) andFromRight:10];
    self.userIdField.font = [UIFont systemFontOfSize:16];
    self.userIdField.placeholder = @"请输入手机号码";
    self.userIdField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textImageView addSubview:self.userIdField];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    label2.frame = CGRectMake(15, 1 + 50, 70, 48);
    label2.font = [UIFont systemFontOfSize:16];
    label2.text = @"密码 :";
    [self.textImageView addSubview:label2];
    
    self.passWordField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 50, 200, 48) andFromRight:10];
    self.passWordField.font = [UIFont systemFontOfSize:16];
    self.passWordField.placeholder = @"请输入密码（至少6位）";
    [self.textImageView addSubview:self.passWordField];
    
    HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
    label3.frame = CGRectMake(15, 1 + 100, 90, 48);
    label3.font = [UIFont systemFontOfSize:16];
    label3.text = @"确认密码 :";
    [self.textImageView addSubview:label3];
    
    self.passComformPasswordField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 100, 200, 48) andFromRight:10];
    self.passComformPasswordField.font = [UIFont systemFontOfSize:16];
    self.passComformPasswordField.placeholder = @"请再次输入上面的密码";
    [self.textImageView addSubview:self.passComformPasswordField];
    
    HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
    label4.frame = CGRectMake(15, 1 + 150, 70, 48);
    label4.font = [UIFont systemFontOfSize:16];
    label4.text = @"昵称 :";
    [self.textImageView addSubview:label4];
    
    self.userNickNameField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 150, 200, 48) andFromRight:10];
    self.userNickNameField.font = [UIFont systemFontOfSize:16];
    self.userNickNameField.placeholder = @"请输入你的名字或昵称";
    [self.textImageView addSubview:self.userNickNameField];
}

-(void)setRegisterBtn{
    HJHMyButton *registerBtn = [[HJHMyButton alloc]init];
    registerBtn.frame = CGRectMake(30, 320, 260, 51);
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}

-(void)loginBtnClick{
    if(self.userIdField.text.length != 11){
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"账号为11位手机号码" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
    }
    else if (self.passWordField.text.length < 6 || [self.passWordField.text containsString:@"*"] || [self.passWordField.text containsString:@"#"] || [self.passWordField.text containsString:@"@"]){
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"密码长度大于6位，且不包含＊，＃，@等特殊字符。" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
    }
    else if (![self.passWordField.text isEqualToString:self.passComformPasswordField.text]){
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"密码不一致！" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
    }
    else{
        LoginNetWork *LoginNetWork1 = [[LoginNetWork alloc]init];
        [LoginNetWork1 registerWithUserName:self.userIdField.text passwd:self.passWordField.text nickName:self.userNickNameField.text];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"\n登录中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeSelf delegate:self userInfo:nil];
        [self.tipView showWithLoading];
    }
}


#pragma mark - keyboardNoti
-(void)keyshow{
    if (!self.notEditBgImageView) {
        self.notEditBgImageView = [[HJHMyButton alloc]initWithFrame:self.view.bounds];
        [self.notEditBgImageView addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.notEditBgImageView];
        [self.view bringSubviewToFront:self.textImageView];
    }
    if (self.canHide == NO) {
        self.notEditBgImageView.hidden = NO;
//        [HJHKeyBoardViewChange keybaordShowChange:self.view];
        self.canHide = YES;
    }
}

-(void)hideKeyboard{
    [self.passWordField resignFirstResponder];
    [self.userIdField resignFirstResponder];
    [self.passComformPasswordField resignFirstResponder];
    [self.userNickNameField resignFirstResponder];
}

-(void)keyhide{
    if (self.canHide == YES) {
        self.notEditBgImageView.hidden = YES;
//        [HJHKeyBoardViewChange keybaordHideChange:self.view];
        self.canHide = NO;
    }
}

-(void)regiterSuccess:(NSNotification*)noti{
    LoginNetWork *LoginNetWork1 = [[LoginNetWork alloc]init];
    [LoginNetWork1 loginWithUserName:self.userIdField.text passwd:self.passWordField.text];
}

-(void)regiterFail:(NSNotification*)noti{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:[noti object] cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
    [self.tipView show];
}

-(void)login{
    [self.tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    RootViewController* root = (RootViewController*)getCurrentRootController;
    [self dismissViewControllerAnimated:NO completion:nil];
    [root deleteLoginView];
    [root addMainView];
}

-(void)loginSuccess:(NSNotification*)noti{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    KGSelectView *SView = [[KGSelectView alloc]initWithDictionary:@[@"我的宝宝",@"使用邀请码"] title:@"添加宝宝" cancelBtn:@"取消"];
    SView.delegate2 = self;
    [self.view addSubview:SView];
}

-(void)loginFail:(NSNotification*)noti{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:[noti object] cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
    [self.tipView show];
    
}

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
        tianjiaBabyViewController *qVC = [[tianjiaBabyViewController alloc]initWithStyle:0];
        [self.navigationController pushViewController:qVC animated:YES];
    }
    else if (tag == 1){
        yaoQingViewController *qVC = [[yaoQingViewController alloc]init];
        [self.navigationController pushViewController:qVC animated:YES];
    }
    else{
        [self login];
    }
}
@end
