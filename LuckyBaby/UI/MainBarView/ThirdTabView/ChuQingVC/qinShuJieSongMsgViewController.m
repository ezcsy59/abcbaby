//
//  qinShuJieSongMsgViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-5-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//
#import "tianjiaBabyViewController.h"
#import "qinShuJieSongMsgViewController.h"
#import "youErYuanNetWork.h"

@interface qinShuJieSongMsgViewController ()<UITableViewDataSource,UITableViewDelegate,KGActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSMutableArray *qingjiaListArray;
@property(nonatomic,strong)HJHMyImageView *headerMainView;
@property(nonatomic,strong)HJHMyButton *header_babyBtn;
@property(nonatomic,strong)HJHMyLabel *header_babyLabel;

@property(nonatomic,strong)HJHMyTextField *textField1;
@property(nonatomic,strong)HJHMyTextField *textField2;
@property(nonatomic,strong)HJHMyTextField *textField3;

@property(nonatomic,strong)KGTipView *tipView;

@property(nonatomic,strong)NSDictionary *msgDic;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;
@end

@implementation qinShuJieSongMsgViewController

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.msgDic = dic;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePickableRelativesSuccess:) name:@"savePickableRelativesSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePickableRelativesFail:) name:@"savePickableRelativesFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delPickableRelativesSuccess:) name:@"delPickableRelativesSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delPickableRelativesFail:) name:@"delPickableRelativesFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
    [youE listPickableRelativesWithChildIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"]];
}

-(void)savePickableRelativesSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate2 getDataByDelegete];
}

-(void)savePickableRelativesFail:(NSNotification*)noti{
    
}

-(void)delPickableRelativesSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate2 getDataByDelegete];
}

-(void)delPickableRelativesFail:(NSNotification*)noti{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"接送亲属信息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setFootMainView];
    
    [self setMainTableView];
    
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

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.tableFooterView = self.headerMainView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setFootMainView{
    self.headerMainView = [[HJHMyImageView alloc]init];
    self.headerMainView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    self.headerMainView.frame = CGRectMake(0, 0, 320, 350);
    
    self.header_babyBtn = [[HJHMyButton alloc]init];
    self.header_babyBtn.frame = CGRectMake(320/2 - 200/2, 30, 200, 200);
    [self.header_babyBtn setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"accompanyPhoto"]] placeholderImage:[UIImage imageNamed:@"addPhoto"]];
    self.header_babyBtn.clipsToBounds = YES;
    [self.header_babyBtn addTarget:self action:@selector(addPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerMainView addSubview:self.header_babyBtn];
    
    self.header_babyLabel = [[HJHMyLabel alloc]init];
    self.header_babyLabel.frame = CGRectMake(320/2 - 260/2, 240, 260, 20);
    self.header_babyLabel.textAlignment = NSTextAlignmentCenter;
    self.header_babyLabel.font = [UIFont systemFontOfSize:18];
    self.header_babyLabel.textColor = [UIColor blackColor];
    self.header_babyLabel.text = @"点击图片设置接送对比照片";
    [self.headerMainView addSubview:self.header_babyLabel];
    
    HJHMyButton *logoutBtn = [[HJHMyButton alloc]init];
    logoutBtn.frame = CGRectMake(20, 275, 280, 51);
    UIImage *image =[UIImage imageNamed:@"ic_btn_add_course_green_pressed.9.png"];
    image  = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [logoutBtn setBackgroundImage:image forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"删除" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(DeleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerMainView addSubview:logoutBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    
    if (indexPath.row == 0) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"与宝宝关系";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField1) {
            self.textField1 = [[HJHMyTextField alloc]init];
        }
        self.textField1.frame = CGRectMake(150, 20, 150, 20);
        self.textField1.fromRight = 8;
        self.textField1.delegate = self;
        self.textField1.layer.cornerRadius = 5.0;
        self.textField1.text = [DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"relationsName"];
        self.textField1.backgroundColor = [UIColor whiteColor];
        self.textField1.textAlignment = NSTextAlignmentRight;
        self.textField1.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.textField1.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField1];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    
    if (indexPath.row == 1) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"姓名";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField2) {
            self.textField2 = [[HJHMyTextField alloc]init];
        }
        self.textField2.frame = CGRectMake(150, 20, 150, 20);
        self.textField2.fromRight = 8;
        self.textField2.delegate = self;
        self.textField2.layer.cornerRadius = 5.0;
        self.textField2.text = [DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"relativesName"];
        self.textField2.backgroundColor = [UIColor whiteColor];
        self.textField2.textAlignment = NSTextAlignmentRight;
        self.textField2.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.textField2.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField2];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }

    
    if (indexPath.row == 2) {
        HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
        zuijinLabel.textColor = [UIColor blackColor];
        zuijinLabel.text = @"手机";
        zuijinLabel.backgroundColor = [UIColor clearColor];
        zuijinLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:zuijinLabel];
        
        if (!self.textField3) {
            self.textField3 = [[HJHMyTextField alloc]init];
        }
        self.textField3.frame = CGRectMake(150, 20, 150, 20);
        self.textField3.fromRight = 8;
        self.textField3.delegate = self;
        self.textField3.layer.cornerRadius = 5.0;
        self.textField3.text = [DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"relativesMobile"];
        self.textField3.backgroundColor = [UIColor whiteColor];
        self.textField3.textAlignment = NSTextAlignmentRight;
        self.textField3.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.textField3.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.textField3];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - btnClick
-(void)DeleteBtnClick{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    [youE delPickableRelativesWithRecId:[DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"recId"]];
}

-(void)saveBtnClick{
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"上传中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
    [self.tipView showWithLoading];
    
    if (!(self.textField1.text.length > 0 && self.textField2.text.length > 0 && self.textField3.text.length > 0)) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"填写信息不完整！" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeSelf delegate:self userInfo:nil];
        [tipView show];
        
        return;
    }
    
    if(self.header_babyBtn.imageView.image || self.msgDic){
        if (self.msgDic) {
            youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
            NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
            [youE savePickableRelativesWithType:@"relatives" childIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] relativesName:self.textField2.text relationsName:self.textField1.text relativesMobile:self.textField3.text accompanyPhoto:[DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"accompanyPhoto"] recId:[DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"recId"]];
        }
        else if (self.header_babyBtn.imageView.image) {
            QNUploadManager *upManager2 = [[QNUploadManager alloc] init];
            
            NSData *data2;
            
            if (UIImagePNGRepresentation(self.header_babyBtn.imageView.image) == nil) {
                data2 = UIImageJPEGRepresentation(self.header_babyBtn.imageView.image, 1);
            } else {
                data2 = UIImagePNGRepresentation(self.header_babyBtn.imageView.image);
            }
            NSString *token = @"yFQx87hgMNU5MRArsX24-6NdqG_YM4A_k8zUi8gB:OK72atoDetVPI8cqu0rqnriIj10=:eyJzY29wZSI6ImNoaWxkbWFuYWdlciIsImRlYWRsaW5lIjozNTY1MDk2NzYzfQ==";
            
            NSString *string2 = [NSString stringWithFormat:@"%@.jpg",gen_uuid()];
            [upManager2 putData:data2 key:string2 token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                
                [self.tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *photoUrl = [NSString stringWithFormat:@"%@/%@",qiniuAdrress,key];
                    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
                    NSDictionary *dic = [plistDataManager getDataWithKey:user_playformList];
                    [youE savePickableRelativesWithType:@"relatives" childIdPlatform:[DictionaryStringTool stringFromDictionary:dic forKey:@"childId"] relativesName:self.textField2.text relationsName:self.textField1.text relativesMobile:self.textField3.text accompanyPhoto:photoUrl recId:[DictionaryStringTool stringFromDictionary:self.msgDic forKey:@"recId"]];
                });
                
            } option:nil];
        }
    }
}

-(void)addPhotoBtnClick{
    KGActionSheet *sheet = [[KGActionSheet alloc]initWithCancelTittle:@"取消" ButtonTittles:@[@"照相",@"从手机相册选择"] delegate:self];
    [sheet defaultStyle];
    [sheet setFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] state:UIControlStateNormal];
    [sheet setCancelFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
    [sheet show];
}

-(void)hideKeyBoard{
    if([self.textField1 isKindOfClass:[HJHMyTextField class]]){
        [self.textField1 resignFirstResponder];
    }
    if([self.textField2 isKindOfClass:[HJHMyTextField class]]){
        [self.textField2 resignFirstResponder];
    }
    if([self.textField3 isKindOfClass:[HJHMyTextField class]]){
        [self.textField3 resignFirstResponder];
    }
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
    [self.header_babyBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - UITextViewDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.bgMengCeng.userInteractionEnabled = NO;
}
@end
