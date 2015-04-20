//
//  HJHLoginViewController.h
//  shuoshuo3
//
//  Created by huang on 3/4/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHLoginViewController.h"
#import "SetPasswordViewController.h"
#import "HJHUserManager.h"
#import "AppDelegate.h"
#import "LoginNetWork.h"

@interface HJHLoginViewController ()
@property(nonatomic,strong)HJHMyTextField *userIdField;
@property(nonatomic,strong)HJHMyTextField *passWordField;
@property(nonatomic,strong)HJHMyButton *notEditBgImageView;
@property(nonatomic,strong)HJHMyImageView *UserFieldView;
@property(nonatomic,assign)BOOL canHide;
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation HJHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    if ([[dic objectForKey:@"userId"]isKindOfClass:[NSString class]]) {
        NSString *string = [dic objectForKey:@"userId"];
        if (string.length > 0) {
            [self login];
        }
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyshow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyhide) name:UIKeyboardWillHideNotification object:nil];
    
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
    self.headNavView.titleLabel.text = @"登录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self setLogoView];
    [self setUserFieldView];
    [self setRegisterBtn];
    [self setLoginBtn];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)setLogoView{
    HJHMyImageView *logoImageView = [[HJHMyImageView alloc]init];
    logoImageView.image = [UIImage imageNamed:@"ic_launcher.png"];
    logoImageView.frame = CGRectMake(160 - 54, 120, 108, 108);
    [self.view addSubview:logoImageView];
    
    if (!iPhone5) {
        logoImageView.frame = CGRectMake(160 - 54, 120 - 15, 108, 108);
    }
}

-(void)setUserFieldView{
    self.UserFieldView = [[HJHMyImageView alloc]init];
    self.UserFieldView.image = [UIImage imageNamed:@"login_txt_bg.png"];
    self.UserFieldView.contentMode = UIViewContentModeScaleToFill;
    self.UserFieldView.frame = CGRectMake(30, 280, 260, 108);
    [self.view addSubview:self.UserFieldView];
    
    HJHMyImageView *userNameImage = [[HJHMyImageView alloc]init];
    userNameImage.image = [UIImage imageNamed:@"login_name.png"];
    userNameImage.frame = CGRectMake(14, 14, 27.0/1.5, 32.0/1.5);
    [self.UserFieldView addSubview:userNameImage];
    
    HJHMyImageView *passworldImage = [[HJHMyImageView alloc]init];
    passworldImage.image = [UIImage imageNamed:@"login_pwd.png"];
    passworldImage.frame = CGRectMake(14, 14 + 54, 27.0/1.5, 32.0/1.5);
    [self.UserFieldView addSubview:passworldImage];
    
    HJHMyImageView *userVertical_line = [[HJHMyImageView alloc]init];
    userVertical_line.image = [UIImage imageNamed:@"login_vertical_line.png"];
    userVertical_line.frame = CGRectMake(10 + 27 + 10, 11, 1, 32);
    [self.UserFieldView addSubview:userVertical_line];
    
    HJHMyImageView *userVertical_line2 = [[HJHMyImageView alloc]init];
    userVertical_line2.image = [UIImage imageNamed:@"login_vertical_line.png"];
    userVertical_line2.frame = CGRectMake(10 + 27 + 10, 11 + 54, 1, 32);
    [self.UserFieldView addSubview:userVertical_line2];
    
    self.userIdField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(10 + 27 + 10 + 2, 2, self.UserFieldView.frame.size.width - 51, 50) andFromRight:10];
    self.userIdField.placeholder = @"请输入账号" ;
    self.userIdField.font = [UIFont systemFontOfSize:20];
    [self.UserFieldView addSubview:self.userIdField];
    
    self.passWordField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(10 + 27 + 10 + 2, 2 + 54, self.UserFieldView.frame.size.width - 51, 50) andFromRight:10];
    self.passWordField.placeholder = @"请输入密码" ;
    self.passWordField.secureTextEntry = YES;
    self.passWordField.font = [UIFont systemFontOfSize:20];
    [self.UserFieldView addSubview:self.passWordField];
    
    if(!iPhone5){
        self.UserFieldView.frame = CGRectMake(30, 280 - 30, 260, 108);
    }
}

-(void)setRegisterBtn{
    HJHMyButton *registerBtn = [[HJHMyButton alloc]init];
    registerBtn.frame = CGRectMake(170, 400, 160, 20);
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#F08221"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(gotoRegisterView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    if (!iPhone5) {
        registerBtn.frame = CGRectMake(170, 400 - 30, 160, 20);
    }
}

-(void)setLoginBtn{
    HJHMyButton *loginBtn = [[HJHMyButton alloc]init];
    loginBtn.frame = CGRectMake(30, 460, 260, 51);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    if (!iPhone5) {
        loginBtn.frame = CGRectMake(30, 460 - 40, 260, 41);
    }
}

#pragma mark - BtnClickMethod
-(void)gotoRegisterView{
    SetPasswordViewController *pVC = [[SetPasswordViewController alloc]init];
    [self.navigationController pushViewController:pVC animated:YES];
}

-(void)loginBtnClick{
    [self loginLogic];
}

#pragma mark - keyboardNoti
-(void)keyshow{
    if (!self.notEditBgImageView) {
        self.notEditBgImageView = [[HJHMyButton alloc]initWithFrame:self.view.bounds];
        [self.notEditBgImageView addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.notEditBgImageView];
        [self.view bringSubviewToFront:self.UserFieldView];
    }
    if (self.canHide == NO) {
        self.notEditBgImageView.hidden = NO;
        [HJHKeyBoardViewChange keybaordShowChange:self.view];
        self.canHide = YES;
    }
}

-(void)hideKeyboard{
    [self.passWordField resignFirstResponder];
    [self.userIdField resignFirstResponder];
}

-(void)keyhide{
    if (self.canHide == YES) {
        self.notEditBgImageView.hidden = YES;
        [HJHKeyBoardViewChange keybaordHideChange:self.view];
        self.canHide = NO;
    }
}

-(void)login{
    [self.tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    RootViewController* root = (RootViewController*)getCurrentRootController;
    [self dismissViewControllerAnimated:NO completion:nil];
    [root deleteLoginView];
    [root addMainView];
}

#pragma loginLogic
-(void)loginLogic{
    if (self.userIdField.text.length > 0 && self.passWordField.text.length > 0) {
        LoginNetWork *LoginNetWork1 = [[LoginNetWork alloc]init];
        [LoginNetWork1 loginWithUserName:self.userIdField.text passwd:self.passWordField.text];
        
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"\n登录中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView showWithLoading];
    }
    else{
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"用户名或者密码不能为空！" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
//        [self login];
    }
}

-(void)loginSuccess:(NSNotification*)noti{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    [self login];
}

-(void)loginFail:(NSNotification*)noti{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:[noti object] cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
    [self.tipView show];

}
@end
