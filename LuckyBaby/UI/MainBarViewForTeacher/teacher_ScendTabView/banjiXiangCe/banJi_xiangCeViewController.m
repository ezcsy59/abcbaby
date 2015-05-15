//
//  banJi_xiangCeViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "banJi_xiangCeViewController.h"
#import "xiangCeTableViewCell.h"
#import "TeacherNetWork.h"
#import "ChoseAblumTableViewController.h"
#import "VedioGetPhotoViewController.h"
#import "banJi_showXiaoPianViewController.h"

@interface banJi_xiangCeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,KGSelectViewDelegate,ChoseAblumDelegate,VediogetPhotoViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *allXiangCeArray;
@property(nonatomic,strong)KGSelectView *SView;
@property(nonatomic,strong)UIImagePickerController* Videopicker;

@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSString *className;
@property(nonatomic,assign)int style;

@property(nonatomic,strong)HJHMyImageView *tianjiaImageV;
@property(nonatomic,strong)HJHMyTextField *tianjiaTextFeild;
@end

@implementation banJi_xiangCeViewController

-(instancetype)initWithClassId:(NSString*)classId className:(NSString*)className style:(int)style{
    if (self = [super init]) {
        self.classId = classId;
        self.className = className;
        self.style = style;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAlbumListSuccess:) name:@"getAlbumListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllAlbumFail:) name:@"getAllAlbumFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSaveAlbumSuccess:) name:@"addSaveAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSaveAlbumFail:) name:@"addSaveAlbumFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    self.allXiangCeArray = [NSArray array];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    NSDictionary *dic2 = [plistDataManager getDataWithKey:user_playformList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    
    if (self.style == 0) {
        [tNet getAlbumListWithClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic2 forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic2 forKey:@"platformId"]];
    }
    else{
        [tNet getAlbumListWithClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
    }
    
}

-(void)getAlbumListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if (arr.count > 0) {
        self.allXiangCeArray = arr;
    }
    [self._tableView reloadData];
}

-(void)getAllAlbumFail:(NSNotification*)noti{
    
}

-(void)addSaveAlbumSuccess:(NSNotification*)noti{
    [self getData];
}

-(void)addSaveAlbumFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = [NSString stringWithFormat:@"%@相册",self.className];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    if (self.style != 0) {
        self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    }
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addVP) forControlEvents:UIControlEventTouchUpInside];
    [self setMainTableView];
    //    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

/*设置标题头的名称*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.allXiangCeArray.count;
    }
    // Return the number of rows in the section.
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[xiangCeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    NSDictionary *dic = [self.allXiangCeArray objectAtIndex:indexPath.row];
    
    HJHMyImageView *leftImage = [[HJHMyImageView alloc]init];
    leftImage.frame = CGRectMake(10, 10, 100, 100);
    [leftImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"coverImageUrl"]] placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
    [cell addSubview:leftImage];
    
    
    HJHMyLabel *leftLabel2 = [[HJHMyLabel alloc]init];
    leftLabel2.frame = CGRectMake(120, 30, 120, 20);
    leftLabel2.font = [UIFont systemFontOfSize:20];
    leftLabel2.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"albumName"];
    leftLabel2.textColor = [UIColor colorWithHexString:@"0A9B0A"];
    [cell addSubview:leftLabel2];
    
    HJHMyLabel *leftLabel3 = [[HJHMyLabel alloc]init];
    leftLabel3.frame = CGRectMake(120, 60, 120, 20);
    leftLabel3.font = [UIFont systemFontOfSize:16];
    leftLabel3.text = [NSString stringWithFormat:@"照片%@张",[DictionaryStringTool stringFromDictionary:dic forKey:@"photoCount"]];
    leftLabel3.textColor = [UIColor blackColor];
    [cell addSubview:leftLabel3];
    
    HJHMyLabel *leftLabel4 = [[HJHMyLabel alloc]init];
    leftLabel4.frame = CGRectMake(120, 85, 120, 18);
    leftLabel4.font = [UIFont systemFontOfSize:16];
    leftLabel4.text = [NSString stringWithFormat:@"视频%@个",[DictionaryStringTool stringFromDictionary:dic forKey:@"videoCount"]];
    leftLabel4.textColor = [UIColor blackColor];
    [cell addSubview:leftLabel4];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    footImage.frame = CGRectMake(0, 119, 320, 0.5);
    [cell addSubview:footImage];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.allXiangCeArray objectAtIndex:indexPath.row];
    banJi_showXiaoPianViewController *sVC = [[banJi_showXiaoPianViewController alloc]initWithStyle:[DictionaryStringTool stringFromDictionary:dic forKey:@"albumId"] albumName:[DictionaryStringTool stringFromDictionary:dic forKey:@"albumName"] classId:self.classId];
    [self.navigationController pushViewController:sVC animated:YES];
}

#pragma mark - btnClick
-(void)addVP{
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
    self.tianjiaTextFeild.text = @"";
}

-(void)quxiaoClick{
    self.tianjiaImageV.hidden = YES;
    [self.tianjiaTextFeild resignFirstResponder];
}

-(void)querenClick{
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    [tNet saveAlbumClassId:self.classId SemesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] userId:[DictionaryStringTool stringFromDictionary:dic forKey:@"userId"] albumName:self.tianjiaTextFeild.text albumId:@""];
    self.tianjiaImageV.hidden = YES;
    [self.tianjiaTextFeild resignFirstResponder];
}

-(void)mCtap{
    [self.tianjiaTextFeild resignFirstResponder];
}
@end
