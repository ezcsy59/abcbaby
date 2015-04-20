//
//  NewBinLiTableViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-9.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "NewBinLiTableViewController.h"
#import "TQRichTextView.h"
#import "ChoseAblumTableViewController.h"
#import "PostDataBean.h"
#import "showBigPhotoViewController.h"
#import "jianKangNetWork.h"
#import "tianjiaBabyViewController.h"
#import "SoundRecord.h"
#import "KGVoiceView.h"
#import "KGEmojiView.h"

#define kDefaultToolbarHeight 42
#define kIOS7 0

@interface NewBinLiTableViewController ()<UITableViewDataSource,UITableViewDelegate,HJHPickerViewDelegate,KGActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChoseAblumDelegate,UITextViewDelegate,KGEmojiViewDelegate>{
    int sendPhotoI;
    bool isSmallPhone;
}
@property(nonatomic,strong)UITableView *_tableView;

@property(nonatomic,strong)HJHMyTextField *timeTextField;
@property(nonatomic,strong)HJHMyTextField *nameTextField;
@property(nonatomic,strong)HJHMyTextField *guoMinTextField;
@property(nonatomic,strong)UITextView *mainTextView;
@property(nonatomic,strong)HJHPickerView *pV;

@property(nonatomic,strong)NSMutableArray *photoBigImageArray;
@property(nonatomic,strong)NSMutableArray *photoSmallImageArray;
@property(nonatomic,strong)NSMutableArray *photoBigImageArrayList;
@property(nonatomic,strong)NSMutableArray *photoSmallImageArrayList;

@property(nonatomic,strong)SoundRecord *recorder;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;

@property(nonatomic,strong)HJHMyButton *voicePlayBtn;

@property(nonatomic,strong)HJHMyButton *voiceDeleBtn;

@property(nonatomic,strong)KGVoiceView *voiceView;

@property(nonatomic,strong)KGTipView *tipView;

@property(nonatomic,strong)KGEmojiView *emojiV;
@end

@implementation NewBinLiTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDiseaseSuccess:) name:@"saveDiseaseSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDiseaseFail:) name:@"saveDiseaseFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)saveDiseaseSuccess:(NSNotification*)noti{

}

-(void)saveDiseaseFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    
    self.photoBigImageArray = [NSMutableArray array];
    self.photoSmallImageArray = [NSMutableArray array];
    self.photoBigImageArrayList = [NSMutableArray array];
    self.photoSmallImageArrayList = [NSMutableArray array];
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"新病例";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTableMainView];
    
    [self setBgMengCeng];
}

-(void)setTableMainView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setBgMengCeng{
    self.bgMengCeng = [[HJHMyImageView alloc]init];
    self.bgMengCeng.frame = self.view.frame;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.bgMengCeng addGestureRecognizer:tap];
    [self.view addSubview:self.bgMengCeng];
    self.bgMengCeng.userInteractionEnabled = NO;
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
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    if (indexPath.row < 3) {
        HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
        nameLabel.frame = CGRectMake(10, 0, 80, 60);
        nameLabel.textAlignment = NSTextAlignmentRight;
        if (indexPath.row == 0) {
            nameLabel.text = @"日期:";
            if (!self.timeTextField) {
                self.timeTextField = [[HJHMyTextField alloc]init];
            }
            self.timeTextField.fromRight = 10;
            self.timeTextField.frame = CGRectMake(100, 20, 190, 20);
            self.timeTextField.backgroundColor = [UIColor whiteColor];
            self.timeTextField.layer.cornerRadius = 5.0;
            self.timeTextField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.timeTextField.font = [UIFont systemFontOfSize:18];
            [cell addSubview:self.timeTextField];
            
            HJHMyButton *btn = [[HJHMyButton alloc]init];
            btn.frame = self.timeTextField.frame;
            [btn addTarget:self action:@selector(timeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }
        if (indexPath.row == 1) {
            nameLabel.text = @"疾病名称:";
            if (!self.nameTextField) {
                self.nameTextField = [[HJHMyTextField alloc]init];
            }
            self.nameTextField.fromRight = 10;
            self.nameTextField.frame = CGRectMake(100, 20, 190, 20);
            self.nameTextField.backgroundColor = [UIColor whiteColor];
            self.nameTextField.layer.cornerRadius = 5.0;
            self.nameTextField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.nameTextField.font = [UIFont systemFontOfSize:18];
            [cell addSubview:self.nameTextField];
        }
        if (indexPath.row == 2) {
            nameLabel.text = @"过敏源:";
            if (!self.guoMinTextField) {
                self.guoMinTextField = [[HJHMyTextField alloc]init];
            }
            self.guoMinTextField.fromRight = 10;
            self.guoMinTextField.frame = CGRectMake(100, 20, 190, 20);
            self.guoMinTextField.backgroundColor = [UIColor whiteColor];
            self.guoMinTextField.layer.cornerRadius = 5.0;
            self.guoMinTextField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
            self.guoMinTextField.font = [UIFont systemFontOfSize:18];
            [cell addSubview:self.guoMinTextField];
        }
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:nameLabel];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
        
    }
    if (indexPath.row == 3) {
        //第一段文字label
        if (!self.mainTextView) {
            self.mainTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        }
        self.mainTextView.backgroundColor = [UIColor whiteColor];
        self.mainTextView.font = [UIFont systemFontOfSize:18];
        self.mainTextView.userInteractionEnabled = YES;
        self.mainTextView.delegate = self;
        self.mainTextView.textColor = [UIColor colorWithHexString:@"666666"];
        [cell addSubview:self.mainTextView];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 199, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    
    if (indexPath.row == 4) {
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyButton *voiceBtn = [[HJHMyButton alloc]init];
        voiceBtn.frame = CGRectMake(10, 10, 40, 40);
        [voiceBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
        [voiceBtn addTarget:self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchDown];
        [voiceBtn addTarget:self action:@selector(voiceBtnClickUp) forControlEvents:UIControlEventTouchUpInside];
        [voiceBtn addTarget:self action:@selector(voiceBtnClickUp) forControlEvents:UIControlEventTouchUpOutside];
        [cell addSubview:voiceBtn];
        
        self.voicePlayBtn = [[HJHMyButton alloc]init];
        self.voicePlayBtn.frame = CGRectMake(240, 10, 40, 40);
        [self.voicePlayBtn setImage:[UIImage imageNamed:@"voice1"] forState:UIControlStateNormal];
        [self.voicePlayBtn addTarget:self action:@selector(voicePlayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.voicePlayBtn.hidden = YES;
        [cell addSubview:self.voicePlayBtn];
        
        self.voiceDeleBtn = [[HJHMyButton alloc]init];
        self.voiceDeleBtn.frame = CGRectMake(280, 10, 40, 40);
        [self.voiceDeleBtn setImage:[UIImage imageNamed:@"voice1_del"] forState:UIControlStateNormal];
        self.voiceDeleBtn.hidden = YES;
        [self.voiceDeleBtn addTarget:self action:@selector(voiceDeleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.voiceDeleBtn];
        
        HJHMyButton *emojiBtn = [[HJHMyButton alloc]init];
        emojiBtn.frame = CGRectMake(60, 10, 40, 40);
        [emojiBtn setImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
        [emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:emojiBtn];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if (indexPath.row == 5) {
        for (int i = 0; i < self.photoSmallImageArray.count + 1; i ++) {
            if (i == self.photoSmallImageArray.count) {
                HJHMyButton *photoBtn = [[HJHMyButton alloc]init];
                photoBtn.frame = CGRectMake(10 + 77.5*(i%4), 10+ 77.5*(i/4), 67.5, 67.5);
                [photoBtn setImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
                [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                photoBtn.tag = 0;
                [cell addSubview:photoBtn];
            }
            else{
                HJHMyButton *photoBtn = [[HJHMyButton alloc]init];
                photoBtn.frame = CGRectMake(10 + 77.5*(i%4), 10+ 77.5*(i/4), 67.5, 67.5);
                [photoBtn setImage:[self.photoSmallImageArray objectAtIndex:i] forState:UIControlStateNormal];
                [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                photoBtn.tag = 1000 + i;
                [cell addSubview:photoBtn];
                
                HJHMyButton *deleBtn = [[HJHMyButton alloc]init];
                deleBtn.frame = CGRectMake(45, 0, 20, 20);
                [deleBtn setImage:[UIImage imageNamed:@"umeng_update_close_bg_tap"] forState:UIControlStateNormal];
                [deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
                deleBtn.tag = 1000 + i;
                [photoBtn addSubview:deleBtn];
            }
        }
        
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        if (self.photoSmallImageArray.count < 4) {
            footImage.frame = CGRectMake(0, 119, 320, 0.5);
        }
        else{
            footImage.frame = CGRectMake(0, 119 + 70, 320, 0.5);
        }
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3 || indexPath.row == 4) {
        return 60;
    }
    if (indexPath.row == 3) {
        return 200;
    }
    if (indexPath.row == 5) {
        if(self.photoSmallImageArray.count < 4){
            return 120;
        }
        else{
            return 120 + 70;
        }
    }
    return 0;
}

#pragma mark - btnClick
-(void)timeBtnClick{
    self.pV = [[HJHPickerView alloc]init];
    [self.pV setPickerV];
    self.pV.delegate2 = self;
    [self.view addSubview:self.pV];
}

-(void)voiceBtnClick{
    if (!self.recorder) {
        self.recorder = [[SoundRecord alloc]init];
    }
    self.voiceView = [[KGVoiceView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.voiceView];
    [self.recorder buttonSayBegin];
}

-(void)voiceBtnClickUp{
    [self.voiceView hideView];
    [self.voiceView removeFromSuperview];
    self.voiceView = nil;
    
    [self.recorder buttonSayEnd];
    self.voiceDeleBtn.hidden = NO;
    self.voicePlayBtn.hidden = NO;
}

-(void)voicePlayBtnClick{
    [self.recorder buttonPlay];
}

-(void)voiceDeleBtnClick{
    self.voiceDeleBtn.hidden = YES;
    self.voicePlayBtn.hidden = YES;
}

-(void)emojiBtnClick{
    self.emojiV = [[KGEmojiView alloc]initWithEmoji];
    self.emojiV.delegate2 = self;
    [self.view addSubview:self.emojiV];
}

-(void)photoBtnClick:(HJHMyButton *)btn{
    if (btn.tag == 0) {
        KGActionSheet *sheet = [[KGActionSheet alloc]initWithCancelTittle:@"取消" ButtonTittles:@[@"照相",@"从手机相册选择"] delegate:self];
        [sheet defaultStyle];
        [sheet setFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] state:UIControlStateNormal];
        [sheet setCancelFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
        [sheet show];
    }
    else{
        showBigPhotoViewController *sBPVC = [[showBigPhotoViewController alloc]initWithPhotoA:(self.photoBigImageArray) andTab:btn.tag%1000 isLocationPhoto:YES];
        [self.navigationController pushViewController:sBPVC animated:YES];
    }
}

-(void)deleBtn:(HJHMyButton *)btn{
    [self.photoSmallImageArray removeObjectAtIndex:btn.tag%1000];
    [self.photoBigImageArray removeObjectAtIndex:btn.tag%1000];
    
    [self._tableView reloadData];
}

-(void)addData{
    sendPhotoI = 0;
    isSmallPhone = NO;
    UIImage *image = [self.photoBigImageArray objectAtIndex:sendPhotoI];
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"上传中" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    [self sendPhone:image];
}

-(void)hideKeyBoard{
    [self.mainTextView resignFirstResponder];
}

#pragma mark -qiniuSendPhoto
-(void)sendPhone:(UIImage*)image{
    QNUploadManager *upManager2 = [[QNUploadManager alloc] init];
    
    NSData *data2;
    
    if (UIImagePNGRepresentation(image) == nil) {
        data2 = UIImageJPEGRepresentation(image, 1);
    } else {
        data2 = UIImagePNGRepresentation(image);
    }
    NSString *token = @"yFQx87hgMNU5MRArsX24-6NdqG_YM4A_k8zUi8gB:OK72atoDetVPI8cqu0rqnriIj10=:eyJzY29wZSI6ImNoaWxkbWFuYWdlciIsImRlYWRsaW5lIjozNTY1MDk2NzYzfQ==";
    
    NSString *string2 = [NSString stringWithFormat:@"%@.jpg",gen_uuid()];
    [upManager2 putData:data2 key:string2 token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (isSmallPhone == NO) {
            if (sendPhotoI < self.photoBigImageArray.count - 1) {
                [self.photoBigImageArrayList addObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key]];
                sendPhotoI ++;
                
                UIImage *image = [self.photoBigImageArray objectAtIndex:sendPhotoI];
                [self sendPhone:image];
            }
            else if (sendPhotoI == self.photoBigImageArray.count - 1) {
                [self.photoBigImageArrayList addObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key]];
                isSmallPhone = YES;
                sendPhotoI = 0;
                [self sendPhone:image];
            }
        }
        else{
            if (sendPhotoI < self.photoSmallImageArray.count - 1) {
                [self.photoSmallImageArrayList addObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key]];
                sendPhotoI ++;
                
                UIImage *image = [self.photoSmallImageArray objectAtIndex:sendPhotoI];
                [self sendPhone:image];
            }
            else if (sendPhotoI == self.photoSmallImageArray.count - 1) {
                [self.photoSmallImageArrayList addObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key]];
                
                isSmallPhone = NO;
                sendPhotoI = 0;
                [self upLoadPhone];
            }
        }
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
    } option:nil];
    
}

-(void)upLoadPhone{
    NSMutableArray *photoArrayList = [NSMutableArray array];
    for (int i = 0; i < self.photoBigImageArrayList.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[self.photoBigImageArrayList objectAtIndex:i] forKey:@"imageOriginalUrl"];
        [dic setObject:[self.photoSmallImageArrayList objectAtIndex:i] forKey:@"imageThumbailUrl"];
        [photoArrayList addObject:dic];
    }
    
    [self.tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSString *string = [emojiStringChange emojiStringChange2:self.mainTextView.text];
    [jianK saveDiseaseWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] diseaseType:self.nameTextField.text diseaseDesc:string voiceUrl:@"" videoUrl:@"" imageList:photoArrayList];
}

#pragma mark - hjhPickerDelegate
-(void)hjhGetDifang:(NSString*)area{
    self.timeTextField.text = area;
    [self.pV removeFromSuperview];
    self.pV = nil;
}

-(void)hjhCancalbClicked{
    [self.pV removeFromSuperview];
    self.pV = nil;
}



#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.mainTextView.text = message;
}

-(void)removeFormParent{
    InputToolbarView = nil;
    [InputToolbarView removeFromParentViewController];
}

//键盘栏目弹出
#pragma mark - keyboard
-(void)showKeyboard{
    // NSLog(@"%@",InputToolbarView);
    if (InputToolbarView == nil) {
        InputToolbarView = [[UIInputToolbarViewController2 alloc]init];
        InputToolbarView.changeBarShowY = 573;
        [self addChildViewController:InputToolbarView];
        
        //InputToolbarView.mineNewComment = self.mineNewComment;
        InputToolbarView.delegate2 = self;
        InputToolbarView.delegate3 = self;
        InputToolbarView.view.frame = CGRectMake(0, (iPhone5?568:480), 320, kDefaultToolbarHeight);
        [InputToolbarView.view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:InputToolbarView.view];
        //付值放在addsubview后面
        //NSLog(@"%@",self.mineNewComment);
        //        if (self.mineNewComment == nil) {
        //            self.InputToolbarView.inputToolbar.textView.placeholder = @"发表评论";
        //        }else{
        //            self.InputToolbarView.inputToolbar.textView.placeholder = [NSString stringWithFormat:@"回复：",self.mineNewComment];
        //        }
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
        /*
         maxPhotoChose 控制的最多能选多少张图片
         maxPhotoChose2 控制的最多能选多少张图片，优先级更高
         */
        ChoseAblumTableViewController *cVC = [[ChoseAblumTableViewController alloc]init];
        cVC.sendPhotoStyle = 0;
        cVC.maxPhotoChose = 7;
        cVC.maxPhotoChose2 = 7 - self.photoSmallImageArray.count;
        cVC.delegate2 = self;
        [self.navigationController pushViewController:cVC animated:YES];
    }
    return YES;
}

#pragma mark - ChoseAblumDelegate
-(void)getPhotoDataArray:(NSMutableArray*)array{
    for (PostDataBean *pBean in array) {
        [self.photoBigImageArray addObject:pBean.photo];
        [self.photoSmallImageArray addObject:[self zipImage:pBean.photo]];
    }
    [self._tableView reloadData];
}

-(void)reloadTableView{
    
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = NO;
}

#pragma mark - KGEmojiViewDelegate
-(void)hideView{
    [self.emojiV removeFromSuperview];
}

-(void)addEmoji:(NSString *)emoji{
    self.mainTextView.text = [NSString stringWithFormat:@"%@%@",self.mainTextView.text,[emojiStringChange emojiStringChange2:emoji]];
}

-(UIImage *)zipImage:(UIImage *)image{
    NSData* imageData = UIImageJPEGRepresentation(image, 1);
    
    
    float fCompress = 0.3;
    while (imageData.length > 10 * 1024) {
        
        if(fCompress <= 0.0f)
        {
            break;
        }
        imageData = UIImageJPEGRepresentation(image, fCompress);
        fCompress -= 0.1;
        
    }
    
    if (!imageData) {
        imageData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    UIImage *image2 = [[UIImage alloc]initWithData:imageData];
    
    return image2;
}
@end
