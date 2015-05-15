//
//  addShiJianTableViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-13.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addShiJianTableViewController.h"
#import "TQRichTextView.h"
#import "KGEmojiView.h"
#import "showBigPhotoViewController.h"
#import "ChoseAblumTableViewController.h"
#import "PostDataBean.h"
#import "SoundRecord.h"
#import "KGVoiceView.h"
#import "UIButton+WebCache.h"
#import "dongtaiNetWork.h"

@interface addShiJianTableViewController ()<UITableViewDataSource,UITableViewDelegate,KGEmojiViewDelegate,ChoseAblumDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HJHPickerViewDelegate,KGSelectViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)UITextView *xiangQingLabel;
@property(nonatomic,strong)KGEmojiView *emojiV;

@property(nonatomic,strong)NSMutableArray *photoBigImageArray;
@property(nonatomic,strong)NSMutableArray *photoSmallImageArray;
@property(nonatomic,strong)NSMutableArray *photoBigImageArrayList;
@property(nonatomic,strong)NSMutableArray *photoSmallImageArrayList;

@property(nonatomic,strong)HJHMyTextField *diDianTextField;
@property(nonatomic,strong)HJHMyLabel *timeLabel;
@property(nonatomic,strong)HJHMyLabel *keJianLabel;
@property(nonatomic,strong)HJHMyLabel *firstLabel;

@property(nonatomic,strong)HJHPickerView *sV;
@property(nonatomic,strong)KGSelectView *selectV;

@property(nonatomic,strong)SoundRecord *recorder;

@property(nonatomic,strong)HJHMyImageView *bgMengCeng;

@property(nonatomic,strong)HJHMyButton *voicePlayBtn;

@property(nonatomic,strong)HJHMyButton *voiceDeleBtn;

@property(nonatomic,strong)KGVoiceView *voiceView;

@property(nonatomic,strong)NSString *medioURL;

@property(nonatomic,strong)HJHMyButton *videoBtn;

@end

@implementation addShiJianTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStorySuccess:) name:@"saveStorySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStoryFail:) name:@"saveStoryFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)saveStorySuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveStoryFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoBigImageArray = [NSMutableArray array];
    self.photoSmallImageArray = [NSMutableArray array];
    self.photoBigImageArrayList = [NSMutableArray array];
    self.photoSmallImageArrayList = [NSMutableArray array];
    
    self.headNavView.titleLabel.text = @"生活记事";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTableView];
    
    [self setBgMengCeng];
    // Do any additional setup after loading the view.
}

-(void)setTableView{
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

-(void)hideKeyBoard{
    [self.xiangQingLabel resignFirstResponder];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
    if(indexPath.row == 0){
        cell.backgroundColor = [UIColor whiteColor];
        self.xiangQingLabel = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
        self.xiangQingLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.xiangQingLabel.backgroundColor = [UIColor clearColor];
        self.xiangQingLabel.font = [UIFont systemFontOfSize:18];
        self.xiangQingLabel.userInteractionEnabled = YES;
        self.xiangQingLabel.delegate = self;
        [cell addSubview:self.xiangQingLabel];
    }
    if(indexPath.row == 1){
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
        
        HJHMyButton *firsttimeBtn = [[HJHMyButton alloc]init];
        firsttimeBtn.frame = CGRectMake(110, 10, 40, 40);
        [firsttimeBtn setImage:[UIImage imageNamed:@"firsttime"] forState:UIControlStateNormal];
        [firsttimeBtn addTarget:self action:@selector(firsttimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:firsttimeBtn];
        
        self.firstLabel = [[HJHMyLabel alloc]init];
        self.firstLabel.frame = CGRectMake(155, 0, 100, 60);
        self.firstLabel.text = @"";
        self.firstLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.firstLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.firstLabel];
        
    }
    if(indexPath.row == 2){
        cell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
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
    }
    if(indexPath.row == 3){
        cell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
        self.videoBtn = [[HJHMyButton alloc]init];
        self.videoBtn.frame = CGRectMake(10, 7.5, 55, 55);
        [self.videoBtn setImage:[UIImage imageNamed:@"video_record"] forState:UIControlStateNormal];
        [self.videoBtn addTarget:self action:@selector(videoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.videoBtn.tag = 0;
        [cell addSubview:self.videoBtn];
    }
    if(indexPath.row == 4){
        cell.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
        nameLabel.frame = CGRectMake(10, 0, 80, 60);
        nameLabel.text = @"记录日期:";
        nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:nameLabel];
        
        self.timeLabel = [[HJHMyLabel alloc]init];
        self.timeLabel.frame = CGRectMake(200, 0, 100, 60);
        self.timeLabel.text = @"2015-04-13";
        self.timeLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.timeLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.timeLabel];
        
        HJHMyButton *timeBtn = [[HJHMyButton alloc]init];
        timeBtn.frame = self.timeLabel.frame;
        [timeBtn addTarget:self action:@selector(timeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:timeBtn];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if(indexPath.row == 5){
        cell.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
        nameLabel.frame = CGRectMake(10, 0, 80, 60);
        nameLabel.text = @"所在地点:";
        nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:nameLabel];
        
        if (!self.diDianTextField) {
            self.diDianTextField = [[HJHMyTextField alloc]init];
        }
        self.diDianTextField.fromRight = 10;
        self.diDianTextField.frame = CGRectMake(100, 20, 130, 20);
        self.diDianTextField.placeholder = @"位置信息";
        self.diDianTextField.backgroundColor = [UIColor whiteColor];
        self.diDianTextField.layer.cornerRadius = 5.0;
        self.diDianTextField.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.diDianTextField.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.diDianTextField];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    if(indexPath.row == 6){
        cell.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        HJHMyLabel *nameLabel = [[HJHMyLabel alloc]init];
        nameLabel.frame = CGRectMake(10, 0, 80, 60);
        nameLabel.text = @"可见范围:";
        nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:nameLabel];
        
        self.keJianLabel = [[HJHMyLabel alloc]init];
        self.keJianLabel.frame = CGRectMake(240, 0, 100, 60);
        self.keJianLabel.text = @"所有人";
        self.keJianLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
        self.keJianLabel.font = [UIFont systemFontOfSize:18];
        [cell addSubview:self.keJianLabel];
        
        HJHMyButton *keJianBtn = [[HJHMyButton alloc]init];
        keJianBtn.frame = self.keJianLabel.frame;
        [keJianBtn addTarget:self action:@selector(keJianBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:keJianBtn];
        
        HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
        rightImage.frame = CGRectMake(300, 20, 12, 20);
        rightImage.image = [UIImage imageNamed:@"right_icon"];
        [cell addSubview:rightImage];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 59, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    }
    if (indexPath.row == 1) {
        return 60;
    }
    if (indexPath.row == 2) {
        if(self.photoSmallImageArray.count < 4){
            return 90;
        }
        else{
            return 90 + 70;
        }
    }
    if (indexPath.row == 3) {
        return 70;
    }
    return 60;
}

#pragma mark - btnClick
-(void)emojiBtnClick{
    self.emojiV = [[KGEmojiView alloc]initWithEmoji];
    self.emojiV.delegate2 = self;
    [self.view addSubview:self.emojiV];
}

-(void)firsttimeBtnClick{
    self.emojiV = [[KGEmojiView alloc]initWithFirstEmoji];
    self.emojiV.delegate2 = self;
    [self.view addSubview:self.emojiV];
}

-(void)keJianBtnClick{
    NSMutableArray *yiMiaoArray = @[@"所有人",@"我",@"父母"];
    self.selectV = [[KGSelectView alloc]initWithDictionary:yiMiaoArray withTitile:@"可见范围"];
    self.selectV.delegate2 = self;
    [self.view addSubview:self.selectV];
}

-(void)timeBtnClick{
    self.sV = [[HJHPickerView alloc]init];
    self.sV.delegate2 = self;
    [self.view addSubview:self.sV];
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
        showBigPhotoViewController *sBPVC = [[showBigPhotoViewController alloc]initWithPhotoA:(self.photoBigImageArray) andTab:btn.tag%1000 isLocationPhoto:YES isClassShow:NO];
        [self.navigationController pushViewController:sBPVC animated:YES];
    }
}

-(void)deleBtn:(HJHMyButton *)btn{
    [self.photoSmallImageArray removeObjectAtIndex:btn.tag%1000];
    [self.photoBigImageArray removeObjectAtIndex:btn.tag%1000];
    
    [self._tableView reloadData];
}

-(void)voiceBtnClick{
    if (!self.recorder) {
        self.recorder = [[SoundRecord alloc]init];
    }
    self.voiceView = [[KGVoiceView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.voiceView];
    [self.recorder buttonSayBegin];
}

-(void)videoBtnClick:(HJHMyButton *)btn{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *)  kUTTypeMovie  , nil];;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

-(void)postBtnClick{
    dongtaiNetWork *dongT = [[dongtaiNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [dongT saveStoryWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] storyDesc:self.xiangQingLabel.text voiceUrl:@"" videoUrl:@"" firstType:self.firstLabel.text storyPlace:self.diDianTextField.text publicRange:self.keJianLabel.text storyLatitude:@"" storyLongitude:@"" imageList:@[]];
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

#pragma mark - KGEmojiViewDelegate
-(void)hideView{
    [self.emojiV removeFromSuperview];
}

-(void)addEmoji:(NSString *)emoji{
    self.xiangQingLabel.text = [NSString stringWithFormat:@"%@%@",self.xiangQingLabel.text,[emojiStringChange emojiStringChange2:emoji]];
}

-(void)addFirstEmoji:(NSString *)emoji isFirst:(BOOL)isFirst{
    if (isFirst == YES) {
        self.firstLabel.text = [NSString stringWithFormat:@"第一次:%@",emoji];
    }
    else{
        self.firstLabel.text = emoji;
    }
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSURL *videoString = [info objectForKey:UIImagePickerControllerMediaURL];
    //把相片存储到相机的相册中
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
    
    if (image) {
        
    }
    else{
        UIImage *image = [self thumbnailImageForVideo:videoString atTime:0];
        [self.videoBtn setImage:image forState:UIControlStateNormal];
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
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

#pragma mark - HJHPickerViewDelegate
-(void)hjhGetDifang:(NSString*)area{
    self.timeLabel.text = area;
    [self.sV removeFromSuperview];
    self.sV = nil;
}

-(void)hjhCancalbClicked{
    [self.sV removeFromSuperview];
    self.sV = nil;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.bgMengCeng.userInteractionEnabled = NO;
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

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    switch (tag) {
        case 0:
        {
            self.keJianLabel.text = @"所有人";
        }
            break;
        case 1:
        {
            self.keJianLabel.text = @"我";
        }
            break;
        case 2:
        {
            self.keJianLabel.text = @"父母";
        }
            break;
        default:
            break;
    }
    [self.selectV removeFromSuperview];
    self.selectV = nil;
}

-(void)cancalSelectClicked{
    
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
