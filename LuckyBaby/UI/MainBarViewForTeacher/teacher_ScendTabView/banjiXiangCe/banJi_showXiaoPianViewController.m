//
//  banJi_showXiaoPianViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-5.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "banJi_showXiaoPianViewController.h"
#import "TeacherNetWork.h"
#import "showBigPhotoViewController.h"
#import "ChoseAblumTableViewController.h"
#import "VedioGetPhotoViewController.h"

@interface banJi_showXiaoPianViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,KGSelectViewDelegate,ChoseAblumDelegate,VediogetPhotoViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,KGTipViewDelegate>{
    KGTipView *_tipView;
}
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *photoArray;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)NSString *albumId;
@property(nonatomic,strong)NSString *albumName;
@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)KGSelectView *SView;

@property(nonatomic,strong)HJHMyImageView *tianjiaImageV;
@property(nonatomic,strong)HJHMyTextField *tianjiaTextFeild;

@property(nonatomic,strong)HJHMyImageView *editingFootBar;

@property(nonatomic,assign)BOOL isEditing;
@end

@implementation banJi_showXiaoPianViewController

-(instancetype)initWithStyle:(NSString *)albumId albumName:(NSString*)albumName classId:(NSString*)classId{
    if (self = [super init]) {
        self.albumId = albumId;
        self.albumName = albumName;
        self.classId = classId;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.btnArray = [NSMutableArray array];
    self.headNavView.titleLabel.text = self.albumName;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addVP) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainTableView];
    
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAlbumPhotoListSuccess:) name:@"getAlbumPhotoListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAlbumPhotoListFail:) name:@"getAlbumPhotoListFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSaveAlbumSuccess:) name:@"addSaveAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSaveAlbumFail:) name:@"addSaveAlbumFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delAlbumSuccess:) name:@"delAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delAlbumFail:) name:@"delAlbumFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delMediaSuccess:) name:@"delMediaSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delMediaFail:) name:@"delMediaFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getAlbumPhotoListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if ([arr isKindOfClass:[NSArray class]]) {
        self.photoArray = arr;
    }
    [self._tableView reloadData];
}

-(void)getAlbumPhotoListFail:(NSNotification*)noti{
    
}

-(void)addSaveAlbumSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addSaveAlbumFail:(NSNotification*)noti{
    
}

-(void)delAlbumSuccess:(NSNotification*)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)delAlbumFail:(NSNotification*)noti{
    
}

-(void)delMediaSuccess:(NSNotification*)noti{
    [self getData];
}

-(void)delMediaFail:(NSNotification*)noti{
    
}

-(void)getData{
    self.photoArray = [NSArray array];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    [tNet getAlbumPhotoListWithAlbumId:self.albumId ClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] userId:[DictionaryStringTool stringFromDictionary:dic forKey:@"userId"]];
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
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
    if (self.photoArray.count > 0) {
        return (self.photoArray.count/4) + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    for (int i = 0; i < 4; i++) {
        if (self.photoArray.count > indexPath.row * 4 + i) {
            HJHMyButton *photoBtn = [[HJHMyButton alloc]init];
            photoBtn.tag = indexPath.row * 4 + i;
            [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            photoBtn.frame = CGRectMake(4 + i*80, 2.5, 75, 75);
            NSDictionary *dic = [self.photoArray objectAtIndex:(indexPath.row*4 + i)];
            NSString *imageString = [DictionaryStringTool stringFromDictionary:dic forKey:@"photoUrl"];
            NSURL *imageUrl = [NSURL URLWithString:imageString];
            [photoBtn setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
            [cell addSubview:photoBtn];
            BOOL canAdd = YES;
            for (UIButton *btn in self.btnArray) {
                if (btn.tag == photoBtn.tag) {
                    canAdd = NO;
                    if (btn.selected == YES) {
                        HJHMyImageView *yesImageV = [[HJHMyImageView alloc]init];
                        yesImageV.frame = CGRectMake(50, 5, 20, 20);
                        yesImageV.tag = 10001;
                        yesImageV.image = [UIImage imageNamed:@"album_check"];
                        [photoBtn addSubview:yesImageV];
                        photoBtn.selected = YES;
                    }
                }
            }
            if (canAdd == YES) {
                [self.btnArray addObject:photoBtn];
            }
            
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}

#pragma mark - btnClick
-(void)photoBtnClick:(HJHMyButton*)btn{
    if(self.isEditing == YES){
        if (btn.selected == YES) {
            btn.selected = NO;
            for (UIView *view in btn.subviews) {
                if (view.tag == 10001) {
                    [view removeFromSuperview];
                }
            }
        }
        else{
            btn.selected = YES;
            HJHMyImageView *yesImageV = [[HJHMyImageView alloc]init];
            yesImageV.frame = CGRectMake(50, 5, 20, 20);
            yesImageV.tag = 10001;
            yesImageV.image = [UIImage imageNamed:@"album_check"];
            [btn addSubview:yesImageV];
        }
    }
    else{
        showBigPhotoViewController *sBPVC = [[showBigPhotoViewController alloc]initWithPhotoA:(self.photoArray) andTab:btn.tag isLocationPhoto:NO isClassShow:YES];
        [self.navigationController pushViewController:sBPVC animated:YES];
    }
}

-(void)addVP{
    self.SView = [[KGSelectView alloc]initWithDictionary:@[@"视频库(视频占用空间小于10M)",@"照片库(上传数量小于50张)",@"修改相册",@"删除相册",@"批量管理"] title:@"导入多媒体" cancelBtn:@"取消"];
    self.SView.delegate2 = self;
    [self.view addSubview:self.SView];
}

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
        VedioGetPhotoViewController *vc = [[VedioGetPhotoViewController alloc]initWithStyle:1];
        [vc maxPhotoCanChose:5];
        //计算又多少张图片
        [vc maxPhotoCanChose2:5];
        vc.delegate2 = self;
        vc.photoNumber = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag == 1){
        /*
         maxPhotoChose 控制的最多能选多少张图片
         maxPhotoChose2 控制的最多能选多少张图片，优先级更高
         */
        ChoseAblumTableViewController *cVC = [[ChoseAblumTableViewController alloc]init];
        cVC.sendPhotoStyle = 1;
        cVC.maxPhotoChose = 50;
        cVC.maxPhotoChose2 = 50;
        cVC.delegate2 = self;
        [self.navigationController pushViewController:cVC animated:YES];
    }
    else if(tag == 2){
        if (self.tianjiaImageV == nil) {
            self.tianjiaImageV =  [[HJHMyImageView alloc]init];
            self.tianjiaImageV.frame = self.view.bounds;
            self.tianjiaImageV.backgroundColor = [UIColor clearColor];
            [self.view addSubview:self.tianjiaImageV];
            
            HJHMyImageView *bgMengCeng = [[HJHMyImageView alloc]init];
            bgMengCeng.frame = self.tianjiaImageV.bounds;
            bgMengCeng.backgroundColor = [UIColor blackColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mCtap)];
            [bgMengCeng addGestureRecognizer:tap];
            bgMengCeng.alpha = 0.3;
            [self.tianjiaImageV addSubview:bgMengCeng];
            
            HJHMyImageView *mainView = [[HJHMyImageView alloc]init];
            mainView.frame = CGRectMake(10, 150, 300, 150);
            mainView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
            [self.tianjiaImageV addSubview:mainView];
            
            HJHMyLabel *titleLabel = [[HJHMyLabel alloc]init];
            titleLabel.frame = CGRectMake(10, 0, 280, 60);
            titleLabel.text = @"添加相册";
            titleLabel.font = [UIFont systemFontOfSize:22];
            titleLabel.textColor = [UIColor colorWithHexString:@"1B7DDE"];
            [mainView addSubview:titleLabel];
            
            HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
            footImage.frame = CGRectMake(0, 53, 300, 2);
            footImage.backgroundColor = [UIColor colorWithHexString:@"1B7DDE"];
            [mainView addSubview:footImage];
            
            self.tianjiaTextFeild = [[HJHMyTextField alloc]initWithFrame:CGRectMake(5, 65, 290, 30) andFromRight:10];
            self.tianjiaTextFeild.font = [UIFont systemFontOfSize:18];
            self.tianjiaTextFeild.backgroundColor = [UIColor whiteColor];
            self.tianjiaTextFeild.layer.cornerRadius = 5;
            self.tianjiaTextFeild.text = self.albumName;
            self.tianjiaTextFeild.textColor = [UIColor blackColor];
            [mainView addSubview:self.tianjiaTextFeild];
            
            HJHMyButton *quxiaoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(0 , 110, 150, 40)];
            quxiaoBtn.backgroundColor = [UIColor clearColor];
            quxiaoBtn.layer.borderColor = [UIColor colorWithHexString:@"C8C7CC"].CGColor;
            quxiaoBtn.layer.borderWidth = 0.5;
            [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
            [quxiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [quxiaoBtn addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:quxiaoBtn];
            
            HJHMyButton *quedingBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(149.5 , 110, 150.5, 40)];
            quedingBtn.backgroundColor = [UIColor clearColor];
            quedingBtn.layer.borderColor = [UIColor colorWithHexString:@"C8C7CC"].CGColor;
            quedingBtn.layer.borderWidth = 0.5;
            [quedingBtn setTitle:@"确认" forState:UIControlStateNormal];
            [quedingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            quedingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [quedingBtn addTarget:self action:@selector(querenClick) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:quedingBtn];
        }
        self.tianjiaImageV.hidden = NO;
    }
    else if(tag == 3){
        if(_tipView){
            [_tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
        }
        NSArray *buttons = [NSArray arrayWithObjects:@"确定", nil];
        _tipView = [[KGTipView alloc] initWithTitle:nil context:@"是否确定删除？" cancelButtonTitle:@"取消" otherCancelButton:buttons lockType:LockTypeGlobal delegate:self userInfo:nil];
        [_tipView show];
    }
    else if(tag == 4){
        if (self.editingFootBar == nil) {
            self.editingFootBar = [[HJHMyImageView alloc]init];
            self.editingFootBar.frame = CGRectMake(0, (iPhone5?568:480) - 60, 320, 60);
            self.editingFootBar.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:self.editingFootBar];
            HJHMyButton *quxiaoBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(170 , 10, 40, 40)];
            quxiaoBtn.backgroundColor = [UIColor clearColor];
            [quxiaoBtn setImage:[UIImage imageNamed:@"album_quit"] forState:UIControlStateNormal];
            [quxiaoBtn addTarget:self action:@selector(quxiaoClick2) forControlEvents:UIControlEventTouchUpInside];
            [self.editingFootBar addSubview:quxiaoBtn];
            
            HJHMyButton *quedingBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(110 , 10, 40, 40)];
            quedingBtn.backgroundColor = [UIColor clearColor];
            [quedingBtn setImage:[UIImage imageNamed:@"album_delete"] forState:UIControlStateNormal];
            [quedingBtn addTarget:self action:@selector(querenClick2) forControlEvents:UIControlEventTouchUpInside];
            [self.editingFootBar addSubview:quedingBtn];
        }
        self.isEditing = YES;
    }
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)cancalSelectClicked{
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)quxiaoClick{
    self.tianjiaImageV.hidden = YES;
    [self.tianjiaTextFeild resignFirstResponder];
}

-(void)querenClick{
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    [tNet saveAlbumClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] userId:[DictionaryStringTool stringFromDictionary:dic forKey:@"userId"] albumName:self.tianjiaTextFeild.text albumId:self.albumId];
    self.tianjiaImageV.hidden = YES;
    [self.tianjiaTextFeild resignFirstResponder];
}

-(void)quxiaoClick2{
    self.editingFootBar.hidden = YES;
    for (UIButton *btn in self.btnArray) {
        for (UIView *view in btn.subviews) {
            [view removeFromSuperview];
            btn.selected = NO;
        }
    }
}

-(void)querenClick2{
    NSString *combinString = @"";
    for (UIButton *btn in self.btnArray) {
        if (btn.selected == YES) {
            NSDictionary *dict = [self.photoArray objectAtIndex:btn.tag];
            NSString *string = [DictionaryStringTool stringFromDictionary:dict forKey:@"photoId"];
            if (combinString.length == 0) {
                combinString = string;
            }
            else{
                combinString = [NSString stringWithFormat:@"%@,%@",combinString,string];
            }
        }
    }
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    [tNet delMediaWithClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] userId:[DictionaryStringTool stringFromDictionary:dic forKey:@"userId"] albumId:self.albumId photoCount:@"0" videoCount:@"0" mediaIdList:combinString];
    self.editingFootBar.hidden = YES;
}


-(void)mCtap{
    [self.tianjiaTextFeild resignFirstResponder];
}

#pragma mark - tipview delegate
- (void)KGTipVIew:(KGTipView *)tipView buttonOfIndex:(NSInteger)index userInfo:(id)userInfo
{
    [_tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    if(index == 1){
        NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
        TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
        [tNet delAlbumWithClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] userId:[DictionaryStringTool stringFromDictionary:dic forKey:@"userId"] albumId:self.albumId];
    }
}
@end
