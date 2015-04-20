//
//  qinMessageViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "qinMessageViewController.h"
#import "dongtaiNetWork.h"

@interface qinMessageViewController ()<KGSelectViewDelegate>
@property(nonatomic,strong)HJHMyTextField *relationField;
@property(nonatomic,strong)HJHMyTextField *nickNameField;
@property(nonatomic,strong)HJHMyTextField *textField4;
@property(nonatomic,strong)HJHMyTextField *textField5;
@property(nonatomic,strong)KGSelectView *relationSV;

@property(nonatomic,strong)NSString *RecId;
@property(nonatomic,strong)NSString *nickName;
@end

@implementation qinMessageViewController

-(id)initWithRecId:(NSString*)RecId nickName:(NSString*)nickName{
    if (self = [super init]) {
        self.RecId = RecId;
        self.nickName = nickName;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateFollowSuccess:) name:@"updateFollowSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateFollowFail:) name:@"updateFollowFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delFollowSuccess:) name:@"delFollowSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delFollowFail:) name:@"delFollowFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)delFollowSuccess:(NSNotification*)noti{

}

-(void)delFollowFail:(NSNotification*)noti{
    
}

-(void)updateFollowSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateFollowFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"亲信息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(deleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setMainView];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    HJHMyImageView *labelBg = [[HJHMyImageView alloc]init];
    labelBg.frame = CGRectMake(15, 25 + [self getNavHight], 290, 100);
    labelBg.contentMode = UIViewContentModeScaleToFill;
    UIImage *image = [UIImage imageNamed:@"bg_bt_cyan_n.png"];
    labelBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [self.view addSubview:labelBg];
    
    HJHMyLabel *relationLabel = [[HJHMyLabel alloc]init];
    relationLabel.frame = CGRectMake(10, 10, 100, 30);
    relationLabel.text = @"与宝宝的关系:";
    relationLabel.font = [UIFont systemFontOfSize:15];
    relationLabel.textColor = [UIColor blackColor];
    [labelBg addSubview:relationLabel];
    
    HJHMyLabel *nickNameLabel = [[HJHMyLabel alloc]init];
    nickNameLabel.frame = CGRectMake(10, 10 + 50, 100, 30);
    nickNameLabel.text = @"宝宝对您称呼:";
    nickNameLabel.font = [UIFont systemFontOfSize:15];
    nickNameLabel.textColor = [UIColor blackColor];
    [labelBg addSubview:nickNameLabel];
    
    UIImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    footImage.frame = CGRectMake(0, 49, 290, 0.5);
    [labelBg addSubview:footImage];
    
    self.textField4 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(120, 10, 140, 30) andFromRight:8];
    self.textField4.layer.cornerRadius = 5.0;
    self.textField4.text = self.nickName;
    self.textField4.backgroundColor = [UIColor whiteColor];
    self.textField4.font = [UIFont systemFontOfSize:18];
    [labelBg addSubview:self.textField4];
    
    HJHMyImageView *textField4IV = [[HJHMyImageView alloc]init];
    textField4IV.frame = self.textField4.frame;
    [labelBg addSubview:textField4IV];
    
    UITapGestureRecognizer *bSelectTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bSelectTap)];
    [textField4IV addGestureRecognizer:bSelectTap];
    
    self.textField5 = [[HJHMyTextField alloc]initWithFrame:CGRectMake(120, 10 + 50, 140, 30) andFromRight:8];
    self.textField5.layer.cornerRadius = 5.0;
    self.textField5.backgroundColor = [UIColor whiteColor];
    self.textField5.font = [UIFont systemFontOfSize:18];
    [labelBg addSubview:self.textField5];
    
    HJHMyButton *saveBtn = [[HJHMyButton alloc]init];
    saveBtn.frame = CGRectMake(110, 160 + [self getNavHight], 100, 40);
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"register_bg_s.png"] forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    

}

-(void)deleBtnClick{
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 delFollowWithRecId:self.RecId];
}

-(void)saveBtnClick{
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 updateFollowWithRecId:self.RecId relationsName:self.textField4.text relativesNickname:self.textField5.text relativesRole:@""];
}

-(void)bSelectTap{
    self.relationSV = [[KGSelectView alloc]initWithDictionary:[NSMutableArray arrayWithArray:[groupOfArray getRelationArray]]];
    self.relationSV.delegate2 = self;
    [self.view addSubview:self.relationSV];
}

-(void)selectBtnClick:(int)tag{
    self.textField4.text = [[groupOfArray getRelationArray] objectAtIndex:tag];
    [self.relationSV removeFromSuperview];
    self.relationSV = nil;
}

-(void)cancalSelectClicked{
    [self.relationSV removeFromSuperview];
    self.relationSV = nil;
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
