//
//  xiangCeViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "xiangCeViewController.h"
#import "xiangCeTableViewCell.h"
#import "dongtaiNetWork.h"
#import "ChoseAblumTableViewController.h"
#import "VedioGetPhotoViewController.h"
#import "showXiaoPianViewController.h"

@interface xiangCeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,KGSelectViewDelegate,ChoseAblumDelegate,VediogetPhotoViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *allXiangCeArray;
@property(nonatomic,strong)NSArray *yearXiangCeArray;
@property(nonatomic,strong)KGSelectView *SView;
@property(nonatomic,strong)UIImagePickerController* Videopicker;
@end

@implementation xiangCeViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllAlbumSuccess:) name:@"getAllAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllAlbumFail:) name:@"getAllAlbumFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAlbumListSuccess:) name:@"getAlbumListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAlbumListFail:) name:@"getAlbumListFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getData{
    self.allXiangCeArray = [NSArray array];
    self.yearXiangCeArray = [NSArray array];
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *dongtaiNetWork1 = [[dongtaiNetWork alloc]init];
    [dongtaiNetWork1 getAllAlbumWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
    [dongtaiNetWork1 getAlbumListWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:@"0" size:@"10"];
}

-(void)getAllAlbumSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if (arr.count > 0) {
        self.allXiangCeArray = arr;
    }
    [self._tableView reloadData];
}

-(void)getAllAlbumFail:(NSNotification*)noti{
    
}

-(void)getAlbumListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if (arr.count > 0) {
        self.yearXiangCeArray = arr;
    }
    [self._tableView reloadData];
}

-(void)getAlbumListFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"宝宝相册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addVP) forControlEvents:UIControlEventTouchUpInside];
    [self setMainTableView];
    [self getData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.allXiangCeArray.count;
    }
    if (section == 1) {
        return self.yearXiangCeArray.count;
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
    if (indexPath.section == 0) {
        xiangCeTableViewCell *qCell = (xiangCeTableViewCell*)cell;
        NSDictionary *dic = [self.allXiangCeArray objectAtIndex:indexPath.row];
        [qCell.leftImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"coverImageUrl"]] placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
        if (indexPath.row == 0) {
            qCell.leftLabel1.text = @"所有相片";
        }
        else{
            qCell.leftLabel1.text = @"所有视频";
        }
        qCell.leftLabel2.hidden = YES;
        qCell.leftLabel3.hidden = YES;
        qCell.leftLabel4.hidden = YES;
    }
    if (indexPath.section == 1) {
        xiangCeTableViewCell *qCell = (xiangCeTableViewCell*)cell;
        NSDictionary *dic = [self.yearXiangCeArray objectAtIndex:indexPath.row];
        [qCell.leftImage setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"coverImageUrl"]] placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
        qCell.leftLabel1.text = @"所有相片";
        qCell.leftLabel2.hidden = YES;
        qCell.leftLabel3.hidden = YES;
        qCell.leftLabel4.hidden = YES;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        showXiaoPianViewController *sVC = [[showXiaoPianViewController alloc]init];
        [self.navigationController pushViewController:sVC animated:YES];
    }
}

#pragma mark - btnClick
-(void)addVP{
    self.SView = [[KGSelectView alloc]initWithDictionary:@[@"视频库(视频占用空间小于10M)",@"照片库(上传数量小于50张)"] title:@"导入多媒体" cancelBtn:@"取消"];
    self.SView.delegate2 = self;
    [self.view addSubview:self.SView];
}

#pragma mark - KGSelectViewDelegate
-(void)selectBtnClick:(int)tag{
    if (tag == 0) {
//        VedioGetPhotoViewController *vc = [[VedioGetPhotoViewController alloc]initWithStyle:1];
//        [vc maxPhotoCanChose:5];
//        //计算又多少张图片
//        [vc maxPhotoCanChose2:5];
//        vc.delegate2 = self;
//        vc.photoNumber = 0;
//        [self.navigationController pushViewController:vc animated:YES];
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        //打开摄像画面作为背景
        [self presentViewController:picker animated:YES completion:nil];
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
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)cancalSelectClicked{
    [self.SView removeFromSuperview];
    self.SView = nil;
}

#pragma mark - ChoseAblumDelegate
-(void)getPhotoDataArray:(NSMutableArray*)array{
    [self.SView removeFromSuperview];
    self.SView = nil;
}

-(void)reloadTableView{
    [self.SView removeFromSuperview];
    self.SView = nil;
}

#pragma mark - VediogetPhotoDelegate
//直接传到上一级
-(void)VediogetPhotoDataArray:(NSMutableArray *)array{
    
}

-(void)VedioreloadTableView{
    //[self.delegate2 reloadTableView];
}
@end
