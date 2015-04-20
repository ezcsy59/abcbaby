//
//  xigaiMimaViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-18.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "xigaiMimaViewController.h"
#import "LoginNetWork.h"

@interface xigaiMimaViewController (){
    HJHMyButton *firstBtn;
}
@property(nonatomic,strong)HJHMyTextField *userIdField;
@property(nonatomic,strong)HJHMyTextField *userIdField2;
@property(nonatomic,strong)HJHMyTextField *passWordField;
@property(nonatomic,strong)HJHMyTextField *passWordField2;
@property(nonatomic,strong)HJHMyTextField *userNickNameField;
@property(nonatomic,strong)HJHMyTextField *passComformPasswordField;
@property(nonatomic,strong)HJHMyButton *notEditBgImageView;
@property(nonatomic,assign)BOOL canHide;
@property(nonatomic,strong)KGTipView *tipView;
@property(nonatomic,strong)HJHMyImageView *textImageView;
@end

@implementation xigaiMimaViewController

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
    
    self.headNavView.titleLabel.text = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [self setMainTextView];
    
    // Do any additional setup after loading the view.
}

-(void)setMainTextView{
    self.textImageView = [[HJHMyImageView alloc]init];
    self.textImageView.frame = CGRectMake(0, [self getNavHight], 320, 300);
    self.textImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textImageView];
    
    HJHMyImageView *headLayer = [[HJHMyImageView alloc]init];
    headLayer.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    headLayer.frame = CGRectMake(0, 0, 320, 1);
    [self.textImageView addSubview:headLayer];
    
    HJHMyImageView *footLayer = [[HJHMyImageView alloc]init];
    footLayer.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    footLayer.frame = CGRectMake(0, 299, 320, 1);
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
    
//    HJHMyImageView *Layer4 = [[HJHMyImageView alloc]init];
//    Layer4.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
//    Layer4.frame = CGRectMake(15, 200, 290, 1);
//    [self.textImageView addSubview:Layer4];
    
    HJHMyImageView *Layer5 = [[HJHMyImageView alloc]init];
    Layer5.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
    Layer5.frame = CGRectMake(15, 250, 290, 1);
    [self.textImageView addSubview:Layer5];
    
    HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
    label3.frame = CGRectMake(15, 1, 70, 48);
    label3.font = [UIFont systemFontOfSize:16];
    label3.text = @"旧密码 :";
    [self.textImageView addSubview:label3];
    
    self.passWordField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 50, 200, 48) andFromRight:10];
    self.passWordField.font = [UIFont systemFontOfSize:16];
    self.passWordField.placeholder = @"请输入密码（至少6位）";
    [self.textImageView addSubview:self.passWordField];
    
    HJHMyLabel *label4 = [[HJHMyLabel alloc]init];
    label4.frame = CGRectMake(15, 1 + 50, 70, 48);
    label4.font = [UIFont systemFontOfSize:16];
    label4.text = @"新密码 :";
    [self.textImageView addSubview:label4];
    
    self.passWordField2 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 50, 200, 48) andFromRight:10];
    self.passWordField2.font = [UIFont systemFontOfSize:16];
    self.passWordField2.placeholder = @"请输入密码（至少6位）";
    [self.textImageView addSubview:self.passWordField2];
    
    HJHMyLabel *label5 = [[HJHMyLabel alloc]init];
    label5.frame = CGRectMake(15, 1 + 100, 90, 48);
    label5.font = [UIFont systemFontOfSize:16];
    label5.text = @"确认密码 :";
    [self.textImageView addSubview:label5];
    
    self.passComformPasswordField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(90, 1 + 100, 200, 48) andFromRight:10];
    self.passComformPasswordField.font = [UIFont systemFontOfSize:16];
    self.passComformPasswordField.placeholder = @"请再次输入上面的密码";
    [self.textImageView addSubview:self.passComformPasswordField];
    
    HJHMyLabel *label1 = [[HJHMyLabel alloc]init];
    label1.frame = CGRectMake(15, 1 + 200, 70, 48);
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = @"旧账号 :";
    [self.textImageView addSubview:label1];
    
    self.userIdField = [[HJHMyTextField alloc]initWithFrame:CGRectMake(140, 1, 200, 48) andFromRight:10];
    self.userIdField.font = [UIFont systemFontOfSize:16];
    self.userIdField.placeholder = @"";
    self.userIdField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textImageView addSubview:self.userIdField];
    
    HJHMyLabel *label2 = [[HJHMyLabel alloc]init];
    label2.frame = CGRectMake(15, 1 + 250, 70, 48);
    label2.font = [UIFont systemFontOfSize:16];
    label2.text = @"新账号 :";
    [self.textImageView addSubview:label2];
    
    self.userIdField2 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(190, 1, 200, 48) andFromRight:10];
    self.userIdField2.font = [UIFont systemFontOfSize:16];
    self.userIdField2.placeholder = @"";
    self.userIdField2.keyboardType = UIKeyboardTypeNumberPad;
    [self.textImageView addSubview:self.userIdField2];
    
    HJHMyImageView *xiugaiImage = [[HJHMyImageView alloc]init];
    xiugaiImage.frame =CGRectMake(0, 150, 320, 50);
    xiugaiImage.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.textImageView addSubview:xiugaiImage];
    
    firstBtn = [[HJHMyButton alloc]init];
    firstBtn.frame = CGRectMake(15, 10, 30, 30);
    [firstBtn setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [xiugaiImage addSubview:firstBtn];
    
    
    HJHMyLabel *firstLabel = [[HJHMyLabel alloc]init];
    firstLabel.text = @"同时修改账户名称";
    firstLabel.frame = CGRectMake(60, 0, 160, 50);
    firstLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    firstLabel.font = [UIFont systemFontOfSize:18];
    [xiugaiImage addSubview:firstLabel];

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

-(void)firstBtnClick:(HJHMyButton*)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else{
        btn.selected = YES;
    }
}

@end
