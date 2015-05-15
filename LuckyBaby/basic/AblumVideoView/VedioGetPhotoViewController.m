//
//  VedioGetPhotoViewController.m
//  xiaozhan
//
//  Created by huang on 11/27/13.
//  Copyright (c) 2013 Kugou. All rights reserved.
//

#import "VedioGetPhotoViewController.h"
#import "VedioAssetCollectionCell.h"
#import "VedioCustomImageView.h"
#import "VedioCustomImage.h"
#import "VedioPostDataBean.h"
#import "UIImage+UIImageExt.h"
#import "ColorEx.h"
#import "KGTipView.h"
#import "dongtaiNetWork.h"
#import "tianjiaBabyViewController.h"
#import "PostDataBean.h"
#define NUM4ROW 4

@interface VedioGetPhotoViewController ()
{
    CGRect currentRect;
    int sendPhotoI;
    bool isSmallPhone;
}
@property(nonatomic,assign)BOOL canPopBack;
@property(nonatomic,strong)UIView *currentBigView;
@property(nonatomic,strong)UIImage *currentBigImg;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger style;
@property(nonatomic,strong)VedioCustomImageView *currentSelectedView;
@property(nonatomic,assign)NSInteger currentNumber;
@property(nonatomic,strong)NSMutableArray *groundDataStringArray;
@property(nonatomic,strong)HJHMyButton *completeBtn;
@property(nonatomic,strong)HJHMyButton *bigPhotoBtn;
@property(nonatomic,assign)BOOL isBigPhotoOrPopBack;
@property(nonatomic,assign)BOOL canPopOrShowBigPhoto;
@property(nonatomic,assign)int maxPhotoNumber;
@property(nonatomic,assign)int maxPhotoNumber2;
//被选中的图片数
@property(nonatomic,assign)int selectedPhotoNumber;
@property(nonatomic,assign)BOOL canShowBigPhoto;

@property (nonatomic,strong) NSMutableArray        *groupArrays;

//压缩后的图片
@property(nonatomic,strong)NSMutableArray *zipPhoneA;
@property(nonatomic,strong)NSMutableArray *mediaListA;
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation VedioGetPhotoViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.canShowBigPhoto = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithStyle:(NSInteger)style{
    self.maxPhotoNumber = 10000;
    self.maxPhotoNumber2 = 10000;
    self.selectedPhotoNumber = 0;
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    //扩展到不透明的区域
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadMediaSuccess:) name:@"uploadMediaSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadMediaFail:) name:@"uploadMediaFail" object:nil];
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    self._dataArray = [NSMutableArray array];
    sendPhotoI = 0;
    isSmallPhone = NO;
    self.groundDataStringArray = [NSMutableArray array];
    self.canShowBigPhoto = YES;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectPhoto:) name:kCustomImageSelected object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(photoWatch:) name:kCustomImageTapped object:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.title = @"视频";
    [self setLeftReturnBtn];
    [self setRightReturnBtn];
    [self setGroupData];
    [self setTableView];
    [self setFootBar];
	// Do any additional setup after loading the view.
}

-(void)setGroupData{
    if (self.groupData == nil) {
        self.groupData = [[NSMutableArray alloc]initWithCapacity:0];
    }
    [self getPhotosFormSystem];
    
    assets = [[NSMutableArray alloc]initWithCapacity:[self.group numberOfAssets]];
    seleteddata = [[NSMutableArray alloc]initWithCapacity:0];
}

-(void)setTableView{
    if (iPhone5) {
        collectionTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -60, self.view.frame.size.width, 424+88)];
    }else{
        collectionTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -60, self.view.frame.size.width, 424)];
    }
    if (iOS7) {
        CGRect r = collectionTable.frame;
        r.origin.y += 64;
        collectionTable.frame = r;
    }
    [collectionTable setBackgroundColor:[UIColor whiteColor]];
    collectionTable.delegate = self;
    collectionTable.dataSource = self;
    collectionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:collectionTable];
}
#pragma mark -navigationItemSet
//返回上一页的按钮
-(void)setLeftReturnBtn{
    UIButton* editeNoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editeNoteButton.frame = CGRectMake(0, 0, 40, 40);
    [editeNoteButton setTitle:@"返回" forState:UIControlStateNormal];
    [editeNoteButton addTarget:self action:@selector(returnLastPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editeNoteButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

//右barButton按钮
-(void)setRightReturnBtn{
}

-(void)setFootBar{
    HJHMyImageView *footBar = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 46, 320, 46)];
    footBar.backgroundColor = [UIColor colorWithHexString:@"#282828"];
    [self.view addSubview:footBar];
    self.completeBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(241, 11, 65, 29)];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.completeBtn.enabled = NO;
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeAbleBtn.png"] forState:UIControlStateNormal];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"Album_btn_selected.png"] forState:UIControlStateHighlighted];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeEnableBtn@2x.png"] forState:UIControlStateDisabled];
    [self.completeBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [footBar addSubview:self.completeBtn];
    
    self.bigPhotoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(14, 11, 65, 29)];
    self.bigPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"completeAbleBtn.png"] forState:UIControlStateNormal];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"Album_btn_selected.png"] forState:UIControlStateHighlighted];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"completeEnableBtn@2x.png"] forState:UIControlStateDisabled];
    self.bigPhotoBtn.enabled = NO;
    [self.bigPhotoBtn setTitle:@"" forState:UIControlStateNormal];
    [self.bigPhotoBtn addTarget:self action:@selector(getGaoQingPhoto) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 返回图片
-(void)popBack{
    dispatch_async(dispatch_get_main_queue(), ^{
//        VedioPostDataBean *bean = [self.groupData objectAtIndex:0];
//        NSLog(@"%@",bean.photo);
        
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray array];
        }

//        if (self.photoNumber + self.groupData.count > 10 && self.style == 1) {
//            NSString *tipString = [NSString stringWithFormat:@"你最多只能选择%ld张照片",10 - self.photoNumber];
//            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:tipString cancelButtonTitle:@"我知道了" otherCancelButton:nil lockType:LockTypeSelf delegate:self userInfo:nil];
//            [tipView setBackgroundColor:[UIColor whiteColor]];
////            [tipView defaultStyle];
//            [tipView show];
//        }else{
            if (!self.zipPhoneA) {
                self.zipPhoneA = [NSMutableArray array];
            }
            if (!self.mediaListA) {
                self.mediaListA = [NSMutableArray array];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"2014.08.08" forKey:@"mediaOriginaType"];
            [dic setObject:@"2014.08.08" forKey:@"createDatetime"];
            [dic setObject:@"123" forKey:@"albumId"];
            [dic setObject:@"jpg" forKey:@"mediaType"];
            [self.mediaListA addObject:dic];
            
            VedioCustomImage *image = [assets objectAtIndex:sendPhotoI];
            UIImage *imageV = (UIImage *)image;
            [self.zipPhoneA addObject:imageV];
            
            if (self.style == 1) {
                self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"上传中" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
                [self.tipView showWithLoading];
                [self sendPhone:image.photoUrl];
            }
            else{
                if ([self.delegate2 respondsToSelector:@selector(getPhotoDataArray:)]) {
                    if (self.groupData.count == 0) {
                        
                    }else{
//                        [self.delegate2 getPhotoDataArray:self.groupData];
                    }
                }
                if ([self.delegate2 respondsToSelector:@selector(reloadTableView)]) {
                    if (self.groupData.count == 0) {
                        
                    }else{
//                        [self.delegate2 reloadTableView];
                    }
                    
                }
                if (self.groupData.count == 0) {
                    
                }else{
                    if (self.navigationController.viewControllers.count >= 3) {
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
                    }
                }
            }

//        }
    });
}

#pragma mark -qiniuSendPhoto
-(void)sendPhone:(id)image{
    QNUploadManager *upManager2 = [[QNUploadManager alloc] init];
    
    NSData *data2;
    
    if ([image isKindOfClass:[UIImage class]]) {
        data2 = UIImagePNGRepresentation(image);
    }
    else if([image isKindOfClass:[NSURL class]]){
        if ([image isFileURL]) {
            
            NSString *path = [(NSURL*)image path];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                
                //url文件存在
                data2 = [NSData dataWithContentsOfFile:path];
            }
            
        }
        
    }
//    if (UIImagePNGRepresentation(image) == nil) {
//        data2 = UIImageJPEGRepresentation(image, 1);
//    } else {
//        data2 = UIImagePNGRepresentation(image);
//    }
    NSString *token = @"yFQx87hgMNU5MRArsX24-6NdqG_YM4A_k8zUi8gB:OK72atoDetVPI8cqu0rqnriIj10=:eyJzY29wZSI6ImNoaWxkbWFuYWdlciIsImRlYWRsaW5lIjozNTY1MDk2NzYzfQ==";
    
    NSString *string2 = [NSString stringWithFormat:@"%@.jpg",gen_uuid()];
    [upManager2 putData:data2 key:string2 token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (isSmallPhone == NO) {
            if (sendPhotoI < self.groupData.count - 1) {
                NSMutableDictionary *dic = [self.mediaListA objectAtIndex:sendPhotoI];
                [dic setObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key] forKey:@"mediaOriginalUrl"];
                sendPhotoI ++;
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:@"2014.08.08" forKey:@"mediaOriginaType"];
                [dict setObject:@"2014.08.08" forKey:@"createDatetime"];
                [dict setObject:@"123" forKey:@"albumId"];
                [dict setObject:@"jpg" forKey:@"mediaType"];
                [self.mediaListA addObject:dict];
                
                VedioCustomImage *image = [assets objectAtIndex:sendPhotoI];
                UIImage *imageV = (UIImage *)image;
                [self.zipPhoneA addObject:image.photoUrl];
                [self.zipPhoneA addObject:imageV];
            }
            else if (sendPhotoI == self.groupData.count - 1) {
                NSMutableDictionary *dic = [self.mediaListA objectAtIndex:sendPhotoI];
                [dic setObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key] forKey:@"mediaOriginalUrl"];
                
                isSmallPhone = YES;
                sendPhotoI = 0;
                UIImage *image = [self.zipPhoneA objectAtIndex:sendPhotoI];
                [self sendPhone:image];
            }
        }
        else{
            if (sendPhotoI < self.zipPhoneA.count - 1) {
                NSMutableDictionary *dic = [self.mediaListA objectAtIndex:sendPhotoI];
                [dic setObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key] forKey:@"mediaThumbailUrl"];
                sendPhotoI ++;
                UIImage *image = [self.zipPhoneA objectAtIndex:sendPhotoI];
                [self sendPhone:image];
            }
            else if (sendPhotoI == self.zipPhoneA.count - 1) {
                NSMutableDictionary *dic = [self.mediaListA objectAtIndex:sendPhotoI];
                [dic setObject:[NSString stringWithFormat:@"%@/%@",qiniuAdrress,key] forKey:@"mediaThumbailUrl"];
                
                isSmallPhone = NO;
                sendPhotoI = 0;
                [self upLoadPhone];
            }
        }
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
    } option:nil];
    
}

#pragma mark - 添加一个上传的接口
//****************************
-(void)upLoadPhone{
    [self.tipView stopLoadingAnimationWithTitle:nil context:@"上传成功" duration:0.5];
    NSLog(@"%@",self.mediaListA);
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *don = [[dongtaiNetWork alloc]init];
    [don uploadMediaWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] mediaType:@"V" mediaList:self.mediaListA];
}

-(void)uploadMediaFail:(NSNotification *)noti{
    
}

-(void)uploadMediaSuccess:(NSNotification *)noti{
    if (self.navigationController.viewControllers.count >= 3) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
    }
}
//****************************

#pragma mark - BigPhotoViewDelegate
-(void)resetGetPhotoView:(NSMutableArray *)array grounArray:(NSMutableArray*)grounArray groundStringArray:(NSMutableArray *)groundStringArray{
    assets = array;
    self.groupData = grounArray;
    if (self.groupData.count == 0) {
        self.completeBtn.enabled = NO;
        self.bigPhotoBtn.enabled = NO;
    }else{
        self.completeBtn.enabled = YES;
        self.bigPhotoBtn.enabled = YES;
    }
    self.groundDataStringArray = groundStringArray;
    self.selectedPhotoNumber = self.groupData.count;
    [collectionTable reloadData];
}

////被选中的图片
//-(void)selectPhoto:(NSNotification*)noti{
//    
//}

#pragma mark 点击选中图片的方法
-(void)photoWatch:(NSNotification*)noti{
    VedioCustomImageView *view = [noti object];
    VedioCustomImage *image = (VedioCustomImage*)(view.image);
    if (image.isSelected == YES) {
        self.selectedPhotoNumber --;
        image.isSelected = NO;
    }else if(image.isSelected == NO && self.selectedPhotoNumber < self.maxPhotoNumber && self.selectedPhotoNumber < self.maxPhotoNumber2){
        self.selectedPhotoNumber ++;
        image.isSelected = YES;
    }
    
    //判断单张图片返回的逻辑 2014
    if (self.style == 0) {
        if (self.currentSelectedView && view.imageNumber != self.currentNumber) {
            VedioCustomImage *image = [assets objectAtIndex:self.currentNumber];
            NSLog(@"%d",image.isSelected);
            image.isSelected = NO;
            ((VedioCustomImage*)(self.currentSelectedView.image)).isSelected = NO;
            self.currentSelectedView.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
        }
        //重用使currentSelect里面的imageNumber改变出现的bug
        self.currentSelectedView = view;
        self.currentNumber = view.imageNumber;
    }

    for (VedioCustomImage *viii in assets) {
        if (viii.isSelected) {
            NSLog(@"%d,",viii.isSelected);
        }
    }
    
    if (image.isSelected == YES) {
        view.selectedImageView.image = [UIImage imageNamed:@"xuanzhongde.png"];
    }else if(image.isSelected == NO && self.selectedPhotoNumber < self.maxPhotoNumber && self.selectedPhotoNumber < self.maxPhotoNumber2){
        view.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
    }else{
        if (self.selectedPhotoNumber >= self.maxPhotoNumber2) {
            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"图片总数超过上限（20张）" cancelButtonTitle:@"确认" otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
            [tipView show];
        }else{
            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"本页最多可选6张照片" cancelButtonTitle:@"确认" otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
            [tipView show];
        }
    }
    VedioCustomImageView *imgView = [noti object];
    VedioAssetCollectionCell* cell = (VedioAssetCollectionCell*)([imgView superview]);
    NSLog(@"%ld,%ld",(long)cell.tag,(long)imgView.tag);
    if (image.isSelected == YES) {
        self.canPopBack = YES;
        //给一张高清的图
        if (self.style == 0) {
            [self.groundDataStringArray removeAllObjects];
        }
        [self.groundDataStringArray addObject:[NSString stringWithFormat:@"%ld",[cell superview].tag*4 + imgView.tag%1000]];
        image.groundDataString = [NSString stringWithFormat:@"%ld",[cell superview].tag*4 + imgView.tag%1000];
    }else{
        self.canPopBack = NO;
        //给一张高清的图
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSString *dataNumber in self.groundDataStringArray) {
            if (![dataNumber isEqualToString:[NSString stringWithFormat:@"%d",[cell superview].tag*4 + imgView.tag%1000]]) {
                [mArray addObject:dataNumber];
            }
        }
        self.groundDataStringArray = mArray;
    }
    
    //修改完成键和预览
    if (self.groundDataStringArray.count > 0) {
        self.completeBtn.enabled = YES;
        self.bigPhotoBtn.enabled = YES;
    }else{
        self.completeBtn.enabled = NO;
        self.bigPhotoBtn.enabled = NO;
    }
}

-(void)getGaoQingPhoto{
    if (self.canShowBigPhoto == YES) {
        self.canPopOrShowBigPhoto = YES;
        self.isBigPhotoOrPopBack = YES;
        self.canPopBack = YES;
        [self.groupData removeAllObjects];
        
        for (NSString *dataNumber in self.groundDataStringArray) {
            //[self getOnePhotosFormSystem:[dataNumber integerValue]];
        }
        self.canShowBigPhoto = NO;
    }
    
}

-(void)customImageStyleChange:(VedioCustomImage*)image{
    
}

-(void)getGaoQingPhoto2{
    self.canPopOrShowBigPhoto = YES;
    self.isBigPhotoOrPopBack = NO;
    self.canPopBack = YES;
    [self.groupData removeAllObjects];
    for (NSString *dataNumber in self.groundDataStringArray) {
        //[self getOnePhotosFormSystem:[dataNumber integerValue]];
    }
}

-(void)showBigPhoto{

}

//返回上一页的方法
-(void)returnLastPage{
    if ([self.delegate2 respondsToSelector:@selector(VedioreloadTableView)]) {
        [self.delegate2 VedioreloadTableView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)removeView{
    [self.currentBigView removeFromSuperview];
    self.currentBigView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//从数据库取视频
-(void)getPhotosFormSystem{
    __weak VedioGetPhotoViewController *weakSelf = self;
    self.groupArrays = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                [weakSelf.groupArrays addObject:group];
            } else {
                [weakSelf.groupArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        if (result) {
                            // 视频
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo] ){
                                NSLog(@"%@",result);
                                NSURL *url = [result valueForProperty:ALAssetPropertyAssetURL];
                                VedioCustomImage* image = [[VedioCustomImage alloc]initWithCGImage:[self thumbnailImageForVideo:url atTime:0].CGImage];
                                image.isSelected = NO;
                                AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
//                                NSLog(@"%@",assets.)
                                image.photoUrl = url;
                                // 和图片方法类似
                                [assets addObject:image];
                            }
                            if (index == [weakSelf.groupArrays count]-1) {
                                [self.groundDataStringArray removeAllObjects];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [collectionTable reloadData];
                                });
                                
                                //设置为相册的最后一行
                                NSLog(@"+_+_+%lu",(unsigned long)assets.count);
                                int lines = assets.count / 4;
                                lines += assets.count%4==0?0:1;
                                float height = lines * 80;
                                float diff;
                                if (iPhone5) {
                                    diff = 568 - 40;
                                }else{
                                    diff = 480 - 40;
                                }
                                if (height - diff < 0) {
                                    
                                }else{
                                    [collectionTable setContentOffset:CGPointMake(0, height - diff)];
                                }
                                
                            }
                        }
                    }];
                }];
                
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
        {
            
            NSString *errorMessage = nil;
            
            switch ([error code]) {
                case ALAssetsLibraryAccessUserDeniedError:
                case ALAssetsLibraryAccessGloballyDeniedError:
                    errorMessage = @"用户拒绝访问相册,请在<隐私>中开启";
                    break;
                    
                default:
                    errorMessage = @"Reason unknown.";
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误,无法访问!"
                                                                   message:errorMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil, nil];
                [alertView show];
            });
        };
        
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]  init];
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                     usingBlock:listGroupBlock failureBlock:failureBlock];
    });
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

-(UIImageOrientation)coverOrientation:(ALAssetOrientation)orientation
{
    switch (orientation) {
        case ALAssetOrientationUp:
        { return UIImageOrientationUp;
          break;
        }
        case ALAssetOrientationDown:
        {   return UIImageOrientationDown;
            break;
        }
        case ALAssetOrientationLeft:
        {   return UIImageOrientationLeft;
            break;
        }
        case ALAssetOrientationRight:
        {   return UIImageOrientationRight;
            break;
        }
        case ALAssetOrientationUpMirrored:
        {  return UIImageOrientationUpMirrored;
            break;
        }
        case ALAssetOrientationDownMirrored:
        {   return UIImageOrientationDownMirrored;
            break;
        }
        case ALAssetOrientationLeftMirrored:
        {  return UIImageOrientationLeftMirrored;
            break;
        }
        case ALAssetOrientationRightMirrored:
        {   return UIImageOrientationRightMirrored;
            break;
        }
        default:
        {   return UIImageOrientationUp;
            break;
        }
    }
}

-(NSInteger)rowsForGroup:(NSInteger)num{
    if (num%NUM4ROW!=0) {
        return ((NSInteger)num/NUM4ROW)+1;
    }else return num/NUM4ROW;
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (assets.count / 4) + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indentifier = @"collectioncell";
    VedioAssetCollectionCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[VedioAssetCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier numForRow:NUM4ROW];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    int index = indexPath.row*NUM4ROW;
    for (int i =0; i<NUM4ROW; i++) {
        if (index + i < assets.count) {
            VedioCustomImageView* imageV = (VedioCustomImageView*)[cell viewWithTag:i+1000];
            imageV.hidden = NO;
            int tag = index+i;
            //2014 需要加上现在tableview的实际位置
            imageV.imageNumber = tag;
            if (tag>assets.count-1) {
                imageV.image = nil;
                [imageV setUserInteractionEnabled:NO];
            }else{
                for (VedioCustomImage *viii in assets) {
                    if (viii.isSelected) {
                        NSLog(@"%d,",viii.isSelected);
                    }
                }
                
                VedioCustomImage* asset = [assets objectAtIndex:tag];
                imageV.image = asset;
                NSLog(@"+_+_++%d",imageV.subviews.count);
                if (asset.isSelected == YES) {
                    imageV.selectedImageView.image = [UIImage imageNamed:@"xuanzhongde.png"];
                }else{
                    imageV.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
                }
                [imageV setUserInteractionEnabled:YES];
            }
        }else{
            VedioCustomImageView* imageV = (VedioCustomImageView*)[cell viewWithTag:i+1000];
            imageV.hidden = YES;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - 外部调用改变的方法
-(void)maxPhotoCanChose:(int)photoNumber{
    self.maxPhotoNumber = photoNumber;
}

-(void)maxPhotoCanChose2:(int)photoNumber{
    self.maxPhotoNumber2 = photoNumber;
}

-(void)resetSelectedPhoto:(int)selectedPhoto{
    self.selectedPhotoNumber = selectedPhoto;
}
@end
