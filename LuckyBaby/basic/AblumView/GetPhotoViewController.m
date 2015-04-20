//
//  GetPhotoViewController.m
//  xiaozhan
//
//  Created by huang on 11/27/13.
//  Copyright (c) 2013 Kugou. All rights reserved.
//
#import "tianjiaBabyViewController.h"
#import "dongtaiNetWork.h"

#import "GetPhotoViewController.h"
#import "AssetCollectionCell.h"
#import "CustomImageView.h"
#import "CustomImage.h"
#import "PostDataBean.h"
#import "UIImage+UIImageExt.h"
#import "ColorEx.h"
#import "KGTipView.h"
#import "dongtaiNetWork.h"
#define NUM4ROW 4

@interface GetPhotoViewController ()
{
    CGRect currentRect;
}
@property(nonatomic,assign)BOOL canPopBack;
@property(nonatomic,strong)UIView *currentBigView;
@property(nonatomic,strong)UIImage *currentBigImg;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger style;
@property(nonatomic,strong)CustomImageView *currentSelectedView;
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

//压缩后的图片
@property(nonatomic,strong)NSMutableArray *zipPhoneA;
@property(nonatomic,strong)NSMutableArray *mediaListA;
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation GetPhotoViewController

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadMediaSuccess:) name:@"uploadMediaSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadMediaFail:) name:@"uploadMediaFail" object:nil];
    //扩展到不透明的区域
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
    self.groundDataStringArray = [NSMutableArray array];
    self.canShowBigPhoto = YES;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(photoWatch:) name:kCustomImageTapped object:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.title = @"相册";
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
//    UIButton* editeNoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    editeNoteButton.frame = CGRectMake(0, 0, 40, 40);
//    [editeNoteButton setTitle:@"保存" forState:UIControlStateNormal];
//    [editeNoteButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editeNoteButton];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
}

-(void)setFootBar{
    HJHMyImageView *footBar = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 46, 320, 46)];
//    footBar.backgroundColor = [UIColor colorWithHexString:@"#1eb6b6"];
    footBar.backgroundColor = [UIColor colorWithHexString:@"#282828"];
    [self.view addSubview:footBar];
    self.completeBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(241, 11, 65, 29)];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.completeBtn.enabled = NO;
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeAbleBtn.png"] forState:UIControlStateNormal];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"Album_btn_selected.png"] forState:UIControlStateHighlighted];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeEnableBtn@2x.png"] forState:UIControlStateDisabled];
    [self.completeBtn addTarget:self action:@selector(getGaoQingPhoto2) forControlEvents:UIControlEventTouchUpInside];
    [footBar addSubview:self.completeBtn];
    
    self.bigPhotoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(14, 11, 65, 29)];
    self.bigPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"completeAbleBtn.png"] forState:UIControlStateNormal];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"Album_btn_selected.png"] forState:UIControlStateHighlighted];
    [self.bigPhotoBtn setBackgroundImage:[UIImage imageNamed:@"completeEnableBtn@2x.png"] forState:UIControlStateDisabled];
    self.bigPhotoBtn.enabled = NO;
    [self.bigPhotoBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self.bigPhotoBtn addTarget:self action:@selector(getGaoQingPhoto) forControlEvents:UIControlEventTouchUpInside];
    [footBar addSubview:self.bigPhotoBtn];
}

//
////设置确定按钮
//-(void)setConfirmBtn{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(60, 450, 200, 40);
//    if (iOS7) {
//        CGRect r = btn.frame;
//        r.origin.y += 64;
//        btn.frame = r;
//    }
//    [btn setTitle:@"确认" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//}

#pragma mark - 返回图片
int sendPhotoI = 0;
bool isSmallPhone = NO;
-(void)popBack{
    dispatch_async(dispatch_get_main_queue(), ^{
        PostDataBean *bean = [self.groupData objectAtIndex:0];
        NSLog(@"%@",bean.photo);
        
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray array];
        }

        if (self.photoNumber + self.groupData.count > 10 && self.style == 1) {
            NSString *tipString = [NSString stringWithFormat:@"你最多只能选择%ld张照片",10 - self.photoNumber];
            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:tipString cancelButtonTitle:@"我知道了" otherCancelButton:nil lockType:LockTypeSelf delegate:self userInfo:nil];
            [tipView setBackgroundColor:[UIColor whiteColor]];
//            [tipView defaultStyle];
            [tipView show];
        }else{
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
            
            PostDataBean *pData = [self.groupData objectAtIndex:sendPhotoI];
            [self.zipPhoneA addObject:[self zipImage:pData.photo]];
            
            if (self.sendPhotoStyle == 1) {
                self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"上传中" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
                [self.tipView showWithLoading];
                [self sendPhone:pData.photo];
            }
            else{
                if ([self.delegate2 respondsToSelector:@selector(getPhotoDataArray:)]) {
                    if (self.groupData.count == 0) {
                        
                    }else{
                        [self.delegate2 getPhotoDataArray:self.groupData];
                    }
                }
                if ([self.delegate2 respondsToSelector:@selector(reloadTableView)]) {
                    if (self.groupData.count == 0) {
                        
                    }else{
                        [self.delegate2 reloadTableView];
                    }
                    
                }
                if (self.groupData.count == 0) {
                    
                }else{
                    if (self.navigationController.viewControllers.count >= 3) {
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
                    }
                }
            }
        }
    });
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
                
                PostDataBean *pData = [self.groupData objectAtIndex:sendPhotoI];
                [self sendPhone:pData.photo];
                [self.zipPhoneA addObject:[self zipImage:pData.photo]];
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

-(void)uploadMediaFail:(NSNotification *)noti{
    
}

-(void)uploadMediaSuccess:(NSNotification *)noti{
    if (self.navigationController.viewControllers.count >= 3) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
    }
}

#pragma mark - 添加一个上传的接口
//****************************
-(void)upLoadPhone{
    [self.tipView stopLoadingAnimationWithTitle:nil context:@"上传成功" duration:0.5];
    NSLog(@"%@",self.mediaListA);
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *don = [[dongtaiNetWork alloc]init];
    [don uploadMediaWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] mediaType:@"P" mediaList:self.mediaListA];
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
    CustomImageView *view = [noti object];
    CustomImage *image = (CustomImage*)(view.image);
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
            CustomImage *image = [assets objectAtIndex:self.currentNumber];
            NSLog(@"%d",image.isSelected);
            image.isSelected = NO;
            ((CustomImage*)(self.currentSelectedView.image)).isSelected = NO;
            self.currentSelectedView.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
        }
        //重用使currentSelect里面的imageNumber改变出现的bug
        self.currentSelectedView = view;
        self.currentNumber = view.imageNumber;
    }

    for (CustomImage *viii in assets) {
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
            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"图片总数超过上限（7张）" cancelButtonTitle:@"确认" otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
//            [tipView defaultStyle];
            [tipView show];
        }else{
            KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"本页最多可选7张照片" cancelButtonTitle:@"确认" otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
//            [tipView defaultStyle];
            [tipView show];
        }
    }
    CustomImageView *imgView = [noti object];
    AssetCollectionCell* cell = (AssetCollectionCell*)([imgView superview]);
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
            [self getOnePhotosFormSystem:[dataNumber integerValue]];
        }
        self.canShowBigPhoto = NO;
    }
    
}

-(void)customImageStyleChange:(CustomImage*)image{
    
}

-(void)getGaoQingPhoto2{
    self.canPopOrShowBigPhoto = YES;
    self.isBigPhotoOrPopBack = NO;
    self.canPopBack = YES;
    [self.groupData removeAllObjects];
    for (NSString *dataNumber in self.groundDataStringArray) {
        [self getOnePhotosFormSystem:[dataNumber integerValue]];
    }
}

-(void)showBigPhoto{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.groupData.count == 0) {
        }else{
            BigPhotoViewController *bpVC = [[BigPhotoViewController alloc]initWithGroupData:self.groupData];
            bpVC.assests = assets;
            bpVC.groundStringArray = self.groundDataStringArray;
            bpVC.photoNumber = self.photoNumber;
            bpVC.delegate = self;
            bpVC.delegate2 = (id<getPhotoViewDelegate>)self.delegate2;
            bpVC.style = self.style;
            [self.navigationController pushViewController:bpVC animated:YES];
        }
    });
}

//-(void)addImage{
//    self.bpVC.photoImageView.image = self.currentBigImg;
//    NSLog(@"%f,%f",self.currentBigImg.size.height,self.currentBigImg.size.width);
//    self.bpVC.photoImageView.frame = CGRectMake(0, ScreenHeigth/2 - 320*self.currentBigImg.size.height/self.currentBigImg.size.width/2 , 320, 320*self.currentBigImg.size.height/self.currentBigImg.size.width);
//    [self.bpVC addBiggerAnimation];
//}

//返回上一页的方法
-(void)returnLastPage{
    if ([self.delegate2 respondsToSelector:@selector(reloadTableView)]) {
        [self.delegate2 reloadTableView];
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

//从数据库取相片
-(void)getPhotosFormSystem{
    self.library = [[ALAssetsLibrary alloc]init];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //
        NSLog(@"%@",group);
        NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
        NSString *g2 = [self cutString:g];
        //
        if (group && [g2 isEqualToString:self.ablumName]) {
            self.group = group;
            [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    //NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    CustomImage* image = [[CustomImage alloc]initWithCGImage:[result thumbnail]];
                    image.isSelected = NO;
                    image.asset = result;
                    //image.photoUrl = urlstr;
                    [assets addObject:image];
                }
                if (index==[self.group numberOfAssets]-1) {
                    [self.groundDataStringArray removeAllObjects];
                    [collectionTable reloadData];
                    
                    //设置为相册的最后一行
                    NSLog(@"%lu",(unsigned long)assets.count);
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
            }];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

//切割不同的group
-(NSString*)cutString:(NSString*)string{
    NSString *g2 = @"";
    if (string && [string isKindOfClass:[NSString class]] && string.length > 16) {
        NSLog(@"gg:%@",string);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
        
        NSString *g1=[string substringFromIndex:16] ;
        NSArray *arr= nil;
        arr=[g1 componentsSeparatedByString:@","];
        g2=[[arr objectAtIndex:0] substringFromIndex:5];
    }
    return g2;
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



//从数据库取单张高清相片
-(void)getOnePhotosFormSystem:(NSInteger)groupNumber{
    ALAssetsLibrary* library2 = [[ALAssetsLibrary alloc]init];
    [library2 enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //
        NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
        NSString *g2 = [self cutString:g];
        //
        if (group && [g2 isEqualToString:self.ablumName]) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                [result valueForProperty:ALAssetPropertyType];
                if (result) {
                    if (index == groupNumber) {
                        if (self.canPopBack) {
                            ALAssetRepresentation * representation =  [result defaultRepresentation];
                            CustomImage* image = nil;
                          
                            if (representation.size > 10 * 1024 * 1024) {
                                ALAssetOrientation A = representation.orientation;
                                image = [[CustomImage alloc] initWithCGImage:[representation fullScreenImage] scale:[representation scale] orientation:[self coverOrientation:A]];
                            }
                            else{
                                ALAssetOrientation A = representation.orientation;
                                image = [[CustomImage alloc] initWithCGImage:[representation fullResolutionImage] scale:[representation scale] orientation:[self coverOrientation:A]];
                            }
                            
                            
//                            long long size = representation.size;
//                            uint8_t *picByts = malloc(size);
//                            [representation getBytes:picByts fromOffset:0 length:size - 1 error:NULL];
//                            NSData* picData = [NSData dataWithBytes:picByts length:size];
//                            UIImage* picImage = [UIImage imageWithData:picData];
//                            NSData* ppData = UIImageJPEGRepresentation(picImage, 0.6);
                            
                            
                           
                            
                            //NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                            image.isSelected = NO;
                            image.asset = result;
                            //image.photoUrl = urlstr;
                            self.currentBigImg = image;
                            //[self addImage];
                            PostDataBean *data1 = [[PostDataBean alloc]init];
                            //data1.photo = image;
                            //data1.photoUrl = image.photoUrl;
                            data1.photoNumber = groupNumber;
                            //先做一次压缩
                            
//                            CGSize imageSize = image.size;
//                            float with = 290 * 2;
//                            float heigth = imageSize.height * with /imageSize.width;
//                            UIImage *imageTemp = [image imageByScalingAndCroppingForSize:CGSizeMake(with, heigth)];
                            
//                            NSData* imageData = UIImageJPEGRepresentation(image, 1);
//                            if (imageData.length > 100 * 1024) {
//                                imageData = UIImageJPEGRepresentation(image, 100 * 1024 / imageData.length);
//                            }
                        //    data1.photo = [UIImage imageWithData:imageData];
                            data1.photo = image;
                            
                            //判断是不是单张显示
                            if (self.style == 0) {
                                [self.groupData removeAllObjects];
                            }
                            [self.groupData addObject:data1];
                        }else{
                            NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];
                            NSMutableArray *arry = [NSMutableArray array];
                            for (PostDataBean *dataBean in self.groupData) {
                                NSLog(@"%@\n%@",dataBean.photoUrl,urlstr);
                                if (![dataBean.photoUrl isEqualToString:urlstr]) {
                                    [arry addObject:dataBean];
                                }else{
                                    
                                }
                            }
                            self.groupData = arry;
                        }
                    }
                    
                    if (self.groupData.count == self.groundDataStringArray.count && self.canPopOrShowBigPhoto) {
                        if (self.isBigPhotoOrPopBack) {
                            [self showBigPhoto];
                        }else{
                            [self popBack];
                        }
                        self.canPopOrShowBigPhoto = NO;
                    }
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

-(NSInteger)rowsForGroup:(NSInteger)num{
    if (num%NUM4ROW!=0) {
        return ((NSInteger)num/NUM4ROW)+1;
    }else return num/NUM4ROW;
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self rowsForGroup:[self.group numberOfAssets]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indentifier = @"collectioncell";
    AssetCollectionCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[AssetCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier numForRow:NUM4ROW];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    int index = indexPath.row*NUM4ROW;
    for (int i =0; i<NUM4ROW; i++) {
        if (index + i < assets.count) {
            CustomImageView* imageV = (CustomImageView*)[cell viewWithTag:i+1000];
            imageV.hidden = NO;
            int tag = index+i;
            //2014 需要加上现在tableview的实际位置
            imageV.imageNumber = tag;
            if (tag>assets.count-1) {
                imageV.image = nil;
                [imageV setUserInteractionEnabled:NO];
            }else{
                for (CustomImage *viii in assets) {
                    if (viii.isSelected) {
                        NSLog(@"%d,",viii.isSelected);
                    }
                }
                
                CustomImage* asset = [assets objectAtIndex:tag];
                imageV.image = asset;
                NSLog(@"+_+_++%d",imageV.subviews.count);
                if (asset.isSelected == YES) {
//                    [self.groundDataStringArray addObject:[NSString stringWithFormat:@"%d",[cell superview].tag*4 + imageV.imageNumber%1000]];
                    imageV.selectedImageView.image = [UIImage imageNamed:@"xuanzhongde.png"];
                }else{
                    imageV.selectedImageView.image = [UIImage imageNamed:@"weixuan.png"];
//                    NSMutableArray *mArray = [NSMutableArray array];
//                    for (NSString *dataNumber in self.groundDataStringArray) {
//                        if (![dataNumber isEqualToString:[NSString stringWithFormat:@"%d",[cell superview].tag*4 + imageV.imageNumber%1000]]) {
//                            [mArray addObject:dataNumber];
//                        }
//                    }
//                    self.groundDataStringArray = mArray;
                }
                [imageV setUserInteractionEnabled:YES];
            }
        }else{
            CustomImageView* imageV = (CustomImageView*)[cell viewWithTag:i+1000];
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