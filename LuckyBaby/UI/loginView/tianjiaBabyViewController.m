//
//  tianjiaBabyViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "tianjiaBabyViewController.h"
#import "LoginNetWork.h"
#import "dongtaiNetWork.h"

@interface tianjiaBabyViewController ()<KGPcikerViewDelegate,HJHPickerViewDelegate,KGSelectViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)HJHMyImageView *mainImageView;
@property(nonatomic,strong)HJHMyImageView *imageVHeader;
@property(nonatomic,strong)NSString *imageVHeaderUrl;
@property(nonatomic,strong)NSString *mainImageViewUrl;
@property(nonatomic,strong)UIScrollView *MainscrollView;
@property(nonatomic,assign)NSInteger current;

@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;
@property(nonatomic,strong)HJHMyTextField *textField4;
@property(nonatomic,strong)HJHMyTextField *textField5;
@property(nonatomic,strong)HJHMyTextField *textField6;
@property(nonatomic,strong)HJHMyTextField *textField7;
@property(nonatomic,strong)HJHMyTextField *textField8;
@property(nonatomic,strong)HJHMyTextField *textField9;
@property(nonatomic,strong)HJHMyImageView *footFieldImage1;
@property(nonatomic,strong)HJHMyImageView *footFieldImage2;
@property(nonatomic,strong)HJHMyImageView *footFieldImage3;
@property(nonatomic,strong)HJHMyImageView *footFieldImage4;
@property(nonatomic,strong)HJHMyImageView *footFieldImage5;
@property(nonatomic,strong)HJHMyImageView *footFieldImage6;
@property(nonatomic,strong)HJHMyImageView *footFieldImage7;
@property(nonatomic,strong)HJHMyImageView *footFieldImage8;
@property(nonatomic,strong)HJHMyImageView *footFieldImage9;

@property(nonatomic,strong)HJHMyButton *mSelectBtn;
@property(nonatomic,strong)HJHMyButton *fmSelectBtn;
@property(nonatomic,strong)HJHMyButton *notEditBgImageView;
@property(nonatomic,assign)BOOL canHide;
@property(nonatomic,strong)KGPickerView *picker;
@property(nonatomic,strong)HJHPickerView *timePicker;
@property(nonatomic,strong)KGSelectView *relationSV;
@property(nonatomic,strong)KGSelectView *bloodSV;
@property(nonatomic,strong)KGSelectView *sV;
@property(nonatomic,assign)int selectTag;

@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation tianjiaBabyViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyhide) name:UIKeyboardWillHideNotification object:nil];
    
    
    if (self.style == 1 || self.style == 2) {
        [self getData];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyInfoSuccess:) name:@"getBabyInfoSuccess" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyInfoFail:) name:@"getBabyInfoFail" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyInfoSuccess:) name:@"delBabyInfoSuccess" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBabyInfoFail:) name:@"delBabyInfoFail" object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 getBabyInfoWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
}

-(void)getBabyInfoSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
    //[self._tableView reloadData];
    self.textField1.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"childName"];
    self.textField2.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"nickName"];
    self.textField3.text = [TimeChange timeChage:[DictionaryStringTool stringFromDictionary:dict forKey:@"birthday"]];
    self.textField4.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"bloodType"];
    self.textField5.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"height"];
    self.textField6.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"weight"];
    self.textField7.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"bornAddress"];
    self.textField8.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"address"];
    self.textField9.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"relationRole"];
    if ([[DictionaryStringTool stringFromDictionary:dict forKey:@"gender"] isEqualToString:@"0"]) {
        self.mSelectBtn.selected = YES;
        self.fmSelectBtn.selected = NO;
    }
    else{
        self.mSelectBtn.selected = NO;
        self.fmSelectBtn.selected = YES;
    }
    NSString *imageVHeaderString = [DictionaryStringTool stringFromDictionary:dict forKey:@"portraitUrl"];
    [self.imageVHeader setImageWithURL:[NSURL URLWithString:imageVHeaderString] placeholderImage:[UIImage imageNamed:@"imgheader.png"]];
    NSString *mainImageString = [DictionaryStringTool stringFromDictionary:dict forKey:@"coverUrl"];
    [self.mainImageView setImageWithURL:[NSURL URLWithString:mainImageString] placeholderImage:[UIImage imageNamed:@"mybaby_top_bg.png"]];
}

-(void)getBabyInfoFail:(NSNotification*)noti{
    
}

-(void)delBabyInfoSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSDictionary *dict = [dic objectForKey:@"data"];
}

-(void)delBabyInfoFail:(NSNotification*)noti{
    
}


-(id)initWithStyle:(int)in_style{
    if (self = [super init]) {
        self.style = in_style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"宝宝信息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self setMainView];
    [self.rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    self.MainscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, iPhone5?568:480)];
    self.MainscrollView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    [self.MainscrollView setContentSize:CGSizeMake(320, 670)];
    if (self.style == 1) {
        self.MainscrollView.userInteractionEnabled = NO;
        [self.MainscrollView setContentSize:CGSizeMake(320, 620)];
        [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
    }
    if (self.style == 2) {
        self.MainscrollView.userInteractionEnabled = YES;
        [self.MainscrollView setContentSize:CGSizeMake(320, 520)];
        [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
    self.MainscrollView.bounces = NO;
    [self.view addSubview:self.MainscrollView];
    
    self.mainImageView = [[HJHMyImageView alloc]init];
    self.mainImageView.frame = CGRectMake(0, 0, ScreenWidth, 140);
    self.mainImageView.image = [UIImage imageNamed:@"mybaby_top_bg.png"];
    [self.MainscrollView addSubview:self.mainImageView];
    
    self.mainImageView.tag = 1002;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.mainImageView addGestureRecognizer:tap1];
    
    self.imageVHeader = [[HJHMyImageView alloc]init];
    self.imageVHeader.frame = CGRectMake(25, 95, 60, 60);
    self.imageVHeader.layer.cornerRadius = 30;
    self.imageVHeader.layer.borderWidth = 3;
    self.imageVHeader.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageVHeader.clipsToBounds = YES;
    self.imageVHeader.image = [UIImage imageNamed:@"imgheader.png"];
    [self.MainscrollView addSubview:self.imageVHeader];
    
    self.imageVHeader.tag = 1001;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.imageVHeader addGestureRecognizer:tap];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(15, 170, 60, 20);
    label1.text = @"姓名:";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(15, 220, 60, 20);
    label2.text = @"小名:";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.frame = CGRectMake(15, 270, 60, 20);
    label3.text = @"生日:";
    label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.frame = CGRectMake(15, 320, 60, 20);
    label4.text = @"性别:";
    label4.textColor = [UIColor blackColor];
    label4.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.frame = CGRectMake(15, 370, 100, 20);
    label5.text = @"出生身高:";
    label5.textColor = [UIColor blackColor];
    label5.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.frame = CGRectMake(15, 420, 100, 20);
    label6.text = @"出生体重:";
    label6.textColor = [UIColor blackColor];
    label6.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label6];
    
    if (self.style == 2) {
        [label6 removeFromSuperview];
        [label5 removeFromSuperview];
    }
    
    UILabel *label7 = [[UILabel alloc]init];
    label7.frame = CGRectMake(15, 470, 100, 20);
    label7.text = @"所在地区:";
    label7.textColor = [UIColor blackColor];
    label7.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.frame = CGRectMake(15, 520, 100, 20);
    label8.text = @"详细地址:";
    label8.textColor = [UIColor blackColor];
    label8.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label8];
    
    if (self.style == 2) {
        label8.frame = CGRectMake(15, 420, 100, 20);
        label7.frame = CGRectMake(15, 370, 100, 20);
    }
    
    if (self.style == 0) {
        UILabel *label9 = [[UILabel alloc]init];
        label9.frame = CGRectMake(15, 570, 100, 20);
        label9.text = @"与宝宝关系:";
        label9.textColor = [UIColor blackColor];
        label9.font = [UIFont systemFontOfSize:18];
        [self.MainscrollView addSubview:label9];
    }
    
    UILabel *label10 = [[UILabel alloc]init];
    label10.frame = CGRectMake(15 + 60 + 130, 270, 100, 20);
    label10.text = @"血型:";
    label10.textColor = [UIColor blackColor];
    label10.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label10];

    UILabel *label11 = [[UILabel alloc]init];
    label11.frame = CGRectMake(260, 370, 50, 20);
    label11.text = @"cm";
    label11.textColor = [UIColor blackColor];
    label11.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc]init];
    label12.frame = CGRectMake(260, 420, 50, 20);
    label12.text = @"kg";
    label12.textColor = [UIColor blackColor];
    label12.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:label12];
    
    if (self.style == 2) {
        [label11 removeFromSuperview];
        [label12 removeFromSuperview];
    }
    
    for (int i = 0; i < 7; i++) {
        UIImageView *footLayer = [[UIImageView alloc]init];
        footLayer.frame = CGRectMake(15, 255 + i * 50, 320, 0.5);
        footLayer.backgroundColor = [UIColor colorWithHexString:@"#C8C7CC"];
        [self.MainscrollView addSubview:footLayer];
    }
    
    [self setSelectBtnV];
    
    [self setTextFieldV];
}

-(void)setTextFieldV{
    self.textField1 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60, 170, 150, 20) andFromRight:8];
    self.textField1.placeholder = @"真实姓名";
    self.textField1.layer.cornerRadius = 5.0;
    self.textField1.backgroundColor = [UIColor whiteColor];
    self.textField1.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField1];
    
    self.textField2 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60, 220, 150, 20) andFromRight:8];
    self.textField2.placeholder = @"必需";
    self.textField2.layer.cornerRadius = 5.0;
    self.textField2.backgroundColor = [UIColor whiteColor];
    self.textField2.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField2];
    
    self.textField3 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60, 270, 100, 20) andFromRight:8];
    self.textField3.placeholder = @"必需";
    self.textField3.layer.cornerRadius = 5.0;
    self.textField3.backgroundColor = [UIColor whiteColor];
    self.textField3.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField3];
    
    HJHMyImageView *textField3IV = [[HJHMyImageView alloc]init];
    textField3IV.frame = self.textField3.frame;
    [self.MainscrollView addSubview:textField3IV];
    
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeTap)];
    [textField3IV addGestureRecognizer:timeTap];
    
    self.textField4 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(255, 270, 40, 20) andFromRight:8];
    self.textField4.layer.cornerRadius = 5.0;
    self.textField4.backgroundColor = [UIColor whiteColor];
    self.textField4.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField4];
    
    HJHMyImageView *textField4IV = [[HJHMyImageView alloc]init];
    textField4IV.frame = self.textField4.frame;
    [self.MainscrollView addSubview:textField4IV];
    
    UITapGestureRecognizer *bSelectTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bSelectTap)];
    [textField4IV addGestureRecognizer:bSelectTap];
    
    self.textField5 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60 + 35, 370, 140, 20) andFromRight:8];
    self.textField5.layer.cornerRadius = 5.0;
    self.textField5.backgroundColor = [UIColor whiteColor];
    self.textField5.font = [UIFont systemFontOfSize:18];
    self.textField5.keyboardType = UIKeyboardTypeNumberPad;
    [self.MainscrollView addSubview:self.textField5];
    
    self.textField6 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60 + 35, 420, 140, 20) andFromRight:8];
    self.textField6.layer.cornerRadius = 5.0;
    self.textField6.backgroundColor = [UIColor whiteColor];
    self.textField6.font = [UIFont systemFontOfSize:18];
    self.textField6.keyboardType = UIKeyboardTypeNumberPad;
    [self.MainscrollView addSubview:self.textField6];
    
    self.textField7 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60 + 35, 470, 180, 20) andFromRight:8];
    self.textField7.layer.cornerRadius = 5.0;
    self.textField7.backgroundColor = [UIColor whiteColor];
    self.textField7.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField7];
    
    HJHMyImageView *textField7IV = [[HJHMyImageView alloc]init];
    textField7IV.frame = self.textField7.frame;
    [self.MainscrollView addSubview:textField7IV];
    
    UITapGestureRecognizer *areaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showArea)];
    [textField7IV addGestureRecognizer:areaTap];
    
    self.textField8 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60 + 35, 520, 145, 20) andFromRight:8];
    self.textField8.layer.cornerRadius = 5.0;
    self.textField8.backgroundColor = [UIColor whiteColor];
    self.textField8.font = [UIFont systemFontOfSize:18];
    [self.MainscrollView addSubview:self.textField8];
    
    if (self.style == 2) {
        [self.textField5 removeFromSuperview];
        self.textField5 = nil;
        [self.textField6 removeFromSuperview];
        self.textField6 = nil;
        
        self.textField7.frame = CGRectMake(15 + 60 + 35, 370, 180, 20);
        self.textField8.frame = CGRectMake(15 + 60 + 35, 420, 180, 20);
    }
    
    
    if (self.style == 0) {
        self.textField9 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(15 + 60 + 55, 570, 175, 20) andFromRight:8];
        self.textField9.layer.cornerRadius = 5.0;
        self.textField9.backgroundColor = [UIColor whiteColor];
        self.textField9.font = [UIFont systemFontOfSize:18];
        [self.MainscrollView addSubview:self.textField9];
        
        HJHMyImageView *textField9IV = [[HJHMyImageView alloc]init];
        textField9IV.frame = self.textField9.frame;
        [self.MainscrollView addSubview:textField9IV];
        
        UITapGestureRecognizer *relationTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(relationTap)];
        [textField9IV addGestureRecognizer:relationTap];
    }
}

-(void)setSelectBtnV{
    if (self.style == 0 || self.style == 2) {
        self.mSelectBtn = [[HJHMyButton alloc]init];
        self.mSelectBtn.frame = CGRectMake(15 + 65, 320, 20, 20);
        [self.mSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.mSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.mSelectBtn.selected = YES;
        self.mSelectBtn.tag = 1002;
        [self.mSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.MainscrollView addSubview:self.mSelectBtn];
        
        self.fmSelectBtn = [[HJHMyButton alloc]init];
        self.fmSelectBtn.frame = CGRectMake(15 + 165, 320, 20, 20);
        [self.fmSelectBtn setImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
        [self.fmSelectBtn setImage:[UIImage imageNamed:@"yuan_selected.png"] forState:UIControlStateSelected];
        self.fmSelectBtn.tag = 1001;
        [self.fmSelectBtn addTarget:self action:@selector(selectSexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.MainscrollView addSubview:self.fmSelectBtn];
        
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 100, 320, 60, 20);
        label13.text = @"男";
        label13.textColor = [UIColor blackColor];
        label13.font = [UIFont systemFontOfSize:18];
        [self.MainscrollView addSubview:label13];
        
        UILabel *label14 = [[UILabel alloc]init];
        label14.frame = CGRectMake(15 + 200, 320, 60, 20);
        label14.text = @"女";
        label14.textColor = [UIColor blackColor];
        label14.font = [UIFont systemFontOfSize:18];
        [self.MainscrollView addSubview:label14];
    }
    if (self.style == 1) {
        UILabel *label13 = [[UILabel alloc]init];
        label13.frame = CGRectMake(15 + 60, 320, 60, 20);
        label13.text = @"男";
        label13.textColor = [UIColor blackColor];
        label13.font = [UIFont systemFontOfSize:18];
        [self.MainscrollView addSubview:label13];
    }
}

#pragma mark - btnClick
//生成UUID
NSString * gen_uuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

//是否能传数据
bool canSendMessage = NO;
//右上角按钮控件事件
-(void)rigthBtnClick{
    if (self.style == 0 || self.style == 2) {
        NSString *token = @"yFQx87hgMNU5MRArsX24-6NdqG_YM4A_k8zUi8gB:OK72atoDetVPI8cqu0rqnriIj10=:eyJzY29wZSI6ImNoaWxkbWFuYWdlciIsImRlYWRsaW5lIjozNTY1MDk2NzYzfQ==";
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
        [self.tipView showWithLoading];
        
        if (self.imageVHeader.image) {
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            
            NSData *data;
            
            if (UIImagePNGRepresentation(self.imageVHeader.image) == nil) {
                data = UIImageJPEGRepresentation(self.imageVHeader.image, 1);
            } else {
                data = UIImagePNGRepresentation(self.imageVHeader.image);
            }
            NSString *string = [NSString stringWithFormat:@"%@.jpg",gen_uuid()];
            [upManager putData:data key:string token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                self.imageVHeaderUrl = [NSString stringWithFormat:@"%@/%@",qiniuAdrress,key];
                if (canSendMessage == NO) {
                    canSendMessage = YES;
                }
                else{
                    canSendMessage = NO;
                    [self sendMessage];
                }
                NSLog(@"%@", info);
                NSLog(@"%@", resp);
            } option:nil];
        }else{
            canSendMessage = YES;
        }
        
        if (self.mainImageView.image) {
            QNUploadManager *upManager2 = [[QNUploadManager alloc] init];
            
            NSData *data2;
            
            if (UIImagePNGRepresentation(self.mainImageView.image) == nil) {
                data2 = UIImageJPEGRepresentation(self.mainImageView.image, 1);
            } else {
                data2 = UIImagePNGRepresentation(self.mainImageView.image);
            }
            NSString *string2 = [NSString stringWithFormat:@"%@.jpg",gen_uuid()];
            [upManager2 putData:data2 key:string2 token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                self.mainImageViewUrl = [NSString stringWithFormat:@"%@/%@",qiniuAdrress,key];
                if (canSendMessage == NO) {
                    canSendMessage = YES;
                }
                else{
                    canSendMessage = NO;
                    [self sendMessage];
                }
                NSLog(@"%@", info);
                NSLog(@"%@", resp);
            } option:nil];
        }
        else{
            canSendMessage = YES;
        }
        
    }
    else{
        self.sV = [[KGSelectView alloc]initWithDictionary:@[@"修改宝宝信息",@"重置邀请码",@"删除宝宝"] title:@"更多操作" cancelBtn:@"取消"];
        self.sV.delegate2 = self;
        self.selectTag = 1005;
        [self.view addSubview:self.sV];
    }
}

//发送添加宝宝请求
-(void)sendMessage{
    [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
    LoginNetWork *LoginNetWork1 = [[LoginNetWork alloc]init];
    NSString *time = [TimeChange timeChage2:self.textField3.text];
    [LoginNetWork1 addBabyWithChildName:self.textField1.text nickName:self.textField2.text gender:@"0" birthday:time bloodType:self.textField4.text portraitUrl:self.imageVHeaderUrl coverUrl:self.mainImageViewUrl bornAddress:self.textField6.text address:self.textField7.text weight:self.textField6.text height:self.textField5.text];
}

-(void)tapClick:(UITapGestureRecognizer*)tag{
    self.current = tag.view.tag;
    KGActionSheet *sheet = [[KGActionSheet alloc]initWithCancelTittle:@"取消" ButtonTittles:@[@"照相",@"从手机相册选择"] delegate:self];
    [sheet defaultStyle];
    [sheet setFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] state:UIControlStateNormal];
    [sheet setCancelFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
    [sheet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectSexBtnClick:(HJHMyButton*)btn{
    if (btn.tag == 1001) {
        self.fmSelectBtn.selected = YES;
        self.mSelectBtn.selected = NO;
    }
    else if (btn.tag == 1002){
        self.fmSelectBtn.selected = NO;
        self.mSelectBtn.selected = YES;
    }
}

//显示地址选择器
-(void)showArea{
    self.picker = [[KGPickerView alloc]init];
    self.picker.delegate2 = self;
    [self.view addSubview:self.picker];
}
//显示时间选择器
-(void)timeTap{
    self.timePicker = [[HJHPickerView alloc]init];
    self.timePicker.delegate2 = self;
    [self.view addSubview:self.timePicker];
    
    [self.timePicker setPickerV];
}

-(void)relationTap{
    self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:[groupOfArray getRelationArray]]];
    self.relationSV.delegate2 = self;
    [self.view addSubview:self.relationSV];
    self.selectTag = 10001;
}

-(void)bSelectTap{
    self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:[groupOfArray bloodArray]]];
    self.relationSV.delegate2 = self;
    [self.view addSubview:self.relationSV];
    self.selectTag = 10002;
}

#pragma mark - KGActionSheet delegate
-(BOOL)KGActionSheet:(KGActionSheet *)sheet willDissmissWithButtonIndex:(NSInteger)index{
    if (index == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }else if(index == 2){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    return YES;
}

#pragma mark - image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //把相片存储到相机的相册中
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
    if (self.current == 1001) {
        [self.imageVHeader setImage:image];
    }
    else{
        [self.mainImageView setImage:image];
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - keyboardNoti
-(void)keyshow:(NSNotification*)noti{
    if (!self.notEditBgImageView) {
        self.notEditBgImageView = [[HJHMyButton alloc]initWithFrame:self.view.bounds];
        [self.notEditBgImageView addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.notEditBgImageView];
    }
    if (self.canHide == NO) {
        self.notEditBgImageView.hidden = NO;
        [HJHKeyBoardViewChange keybaordShowChange:self.view];
        self.canHide = YES;
    }
}

-(void)hideKeyboard{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textField5 resignFirstResponder];
    [self.textField6 resignFirstResponder];
    [self.textField7 resignFirstResponder];
    [self.textField8 resignFirstResponder];
    [self.textField9 resignFirstResponder];
}

-(void)keyhide{
    if (self.canHide == YES) {
        self.notEditBgImageView.hidden = YES;
        [HJHKeyBoardViewChange keybaordHideChange:self.view];
        self.canHide = NO;
    }
}

#pragma mark - pickerDelegate
-(void)cancalbClicked{
    [self.picker removeFromSuperview];
    self.picker = nil;
}

-(void)getDifang:(NSString *)area{
    self.textField7.text = area;
    [self.picker removeFromSuperview];
    self.picker = nil;
}

-(void)hjhCancalbClicked{
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}

-(void)hjhGetDifang:(NSString *)area{
    self.textField3.text = area;
    [self.timePicker removeFromSuperview];
    self.timePicker = nil;
}

#pragma mark -selectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (self.selectTag == 10001) {
        self.textField9.text = [[groupOfArray getRelationArray] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 10002){
        self.textField4.text = [[groupOfArray bloodArray] objectAtIndex:tag];
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 1005){
        if (tag == 0) {
            if (self.style == 1) {
                self.style = 2;
            }
            else if (self.style == 2){
                self.style = 1;
            }
            [self.MainscrollView removeFromSuperview];
            self.MainscrollView = nil;
            [self setMainView];
            [self getData];
        }
        else if (tag == 1){
           
        }
        else if (tag == 2){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"是否确认删除宝宝？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alertView.delegate = self;
            [alertView show];
        }
        NSLog(@"%d",tag);
        [self.sV removeFromSuperview];
        self.sV = nil;
    }
}

-(void)cancalSelectClicked{
    if (self.selectTag == 10001) {
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
    else if (self.selectTag == 10002){
        [self.relationSV removeFromSuperview];
        self.relationSV = nil;
    }
}

#pragma mark - alterView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }
    else{
        NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
        dongtaiNetWork *donN = [[dongtaiNetWork alloc]init];
        [donN delBabyInfoWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] relativesId:[DictionaryStringTool stringFromDictionary:dic forKey:@"relativesId"]];
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

@end
