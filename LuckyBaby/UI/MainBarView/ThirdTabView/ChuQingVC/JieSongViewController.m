//
//  JieSongViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-5-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "JieSongViewController.h"
#import "youErYuanNetWork.h"
#import "qinShuJieSongMsgViewController.h"

@interface JieSongViewController ()<UITableViewDataSource,UITableViewDelegate,qinShuJieSongMsgViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSMutableArray *qingjiaListArray;
@property(nonatomic,strong)HJHMyImageView *headerMainView;
@property(nonatomic,strong)HJHMyButton *header_babyBtn;
@property(nonatomic,strong)HJHMyLabel *header_babyLabel;
@end

@implementation JieSongViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listPickableRelativesSuccess:) name:@"listPickableRelativesSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listPickableRelativesFail:) name:@"listPickableRelativesFail" object:nil];
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

-(void)listPickableRelativesSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if([array isKindOfClass:[NSArray class]]){
        if ([array isKindOfClass:[NSArray class]]) {
            self.qingjiaListArray = [[NSMutableArray alloc]initWithArray:array];
            
            NSDictionary *dic = [self.qingjiaListArray objectAtIndex:0];
            [self.header_babyBtn setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"accompanyPhoto"]] placeholderImage:nil];
            self.header_babyLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"relativesName"];
        }
    }
    [self._tableView reloadData];
}

-(void)listPickableRelativesFail:(NSNotification*)noti{

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.headNavView.titleLabel.text = @"接送亲属";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self setHeadMainView];
    
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]) style:UITableViewStylePlain];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.tableHeaderView = self.headerMainView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setHeadMainView{
    self.headerMainView = [[HJHMyImageView alloc]init];
    self.headerMainView.backgroundColor = [UIColor colorWithHexString:@"93C6E9"];
    self.headerMainView.frame = CGRectMake(0, 0, 320, 190);
    
    self.header_babyBtn = [[HJHMyButton alloc]init];
    self.header_babyBtn.frame = CGRectMake(320/2 - 140/2, 15, 140, 140);
    self.header_babyBtn.layer.cornerRadius = 70;
    self.header_babyBtn.clipsToBounds = YES;
    [self.header_babyBtn addTarget:self action:@selector(addPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerMainView addSubview:self.header_babyBtn];
    
    self.header_babyLabel = [[HJHMyLabel alloc]init];
    self.header_babyLabel.frame = CGRectMake(320/2 - 100/2, 160, 100, 20);
    self.header_babyLabel.textAlignment = NSTextAlignmentCenter;
    self.header_babyLabel.font = [UIFont systemFontOfSize:18];
    self.header_babyLabel.textColor = [UIColor blackColor];
    self.header_babyLabel.text = @"宝宝头像";
    [self.headerMainView addSubview:self.header_babyLabel];
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
    if (self.qingjiaListArray.count > 1 && self.qingjiaListArray.count < 4) {
        return (self.qingjiaListArray.count - 1)/2  + 1;
    }
    if(self.qingjiaListArray.count > 3){
        return (self.qingjiaListArray.count - 2)/2  + 1;
    }
    return 1;
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
    cell.backgroundColor = [UIColor colorWithHexString:@"93C6E9"];
    
    if (self.qingjiaListArray.count > (indexPath.row)*2 + 1) {
        NSDictionary *dic = [self.qingjiaListArray objectAtIndex:(indexPath.row)*2 + 1];
        
        HJHMyImageView *bgImageV = [[HJHMyImageView alloc]init];
        bgImageV.frame = CGRectMake(0, 0, 157.5, 155);
        bgImageV.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgImageV];
        
        HJHMyButton *headBtn = [[HJHMyButton alloc]init];
        headBtn.frame = CGRectMake(20, 10, 120, 120);
        headBtn.tag = 1000 + (indexPath.row)*2 + 1;
        [headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headBtn setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"accompanyPhoto"]] placeholderImage:nil];
        [cell addSubview:headBtn];
        
        HJHMyLabel *headLabel = [[HJHMyLabel alloc]init];
        headLabel.frame = CGRectMake(0, 135, 160, 20);
        headLabel.textAlignment = NSTextAlignmentCenter;
        headLabel.font = [UIFont systemFontOfSize:18];
        headLabel.textColor = [UIColor blackColor];
        headLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"relationsName"];
        [cell addSubview:headLabel];
    }
    
    if (self.qingjiaListArray.count > (indexPath.row)*2 + 2) {
        NSDictionary *dict = [self.qingjiaListArray objectAtIndex:(indexPath.row)*2 + 2];
        
        HJHMyImageView *bgImageV2 = [[HJHMyImageView alloc]init];
        bgImageV2.frame = CGRectMake(162.5, 0, 157.5, 155);
        bgImageV2.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgImageV2];
        
        HJHMyButton *headBtn2 = [[HJHMyButton alloc]init];
        headBtn2.frame = CGRectMake(162.5 + 20, 10, 120, 120);
        headBtn2.tag = 1000 + (indexPath.row)*2 + 2;
        [headBtn2 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headBtn2 setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dict forKey:@"accompanyPhoto"]] placeholderImage:nil];
        [cell addSubview:headBtn2];
        
        HJHMyLabel *headLabel2 = [[HJHMyLabel alloc]init];
        headLabel2.frame = CGRectMake(162.5, 135, 160, 20);
        headLabel2.textAlignment = NSTextAlignmentCenter;
        headLabel2.font = [UIFont systemFontOfSize:18];
        headLabel2.textColor = [UIColor blackColor];
        headLabel2.text = [DictionaryStringTool stringFromDictionary:dict forKey:@"relationsName"];
        [cell addSubview:headLabel2];
    }
    
    if (self.qingjiaListArray.count < 5 && (indexPath.row) * 2 + 1 > self.qingjiaListArray.count - 1) {
        HJHMyImageView *bgImageV2 = [[HJHMyImageView alloc]init];
        bgImageV2.frame = CGRectMake(0, 0, 157.5, 155);
        bgImageV2.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgImageV2];
        
        HJHMyButton *headBtn2 = [[HJHMyButton alloc]init];
        headBtn2.frame = CGRectMake(0, 135, 160, 20);
        headBtn2.tag = 100001;
        [headBtn2 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headBtn2 setImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
        [cell addSubview:headBtn2];
        
        HJHMyLabel *headLabel2 = [[HJHMyLabel alloc]init];
        headLabel2.frame = CGRectMake(162.5, 135, 160, 20);
        headLabel2.textAlignment = NSTextAlignmentCenter;
        headLabel2.font = [UIFont systemFontOfSize:18];
        headLabel2.textColor = [UIColor blackColor];
        headLabel2.text = @"添加";
        [cell addSubview:headLabel2];
    }
    else if(self.qingjiaListArray.count < 5 && (indexPath.row) * 2 + 2 > self.qingjiaListArray.count - 1){
        HJHMyImageView *bgImageV2 = [[HJHMyImageView alloc]init];
        bgImageV2.frame = CGRectMake(162.5, 0, 157.5, 155);
        bgImageV2.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgImageV2];
        
        HJHMyButton *headBtn2 = [[HJHMyButton alloc]init];
        headBtn2.frame = CGRectMake(162.5 + 20, 10, 120, 120);
        headBtn2.tag = 100001;
        [headBtn2 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headBtn2 setImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
        [cell addSubview:headBtn2];
        
        HJHMyLabel *headLabel2 = [[HJHMyLabel alloc]init];
        headLabel2.frame = CGRectMake(162.5, 135, 160, 20);
        headLabel2.textAlignment = NSTextAlignmentCenter;
        headLabel2.font = [UIFont systemFontOfSize:18];
        headLabel2.textColor = [UIColor blackColor];
        headLabel2.text = @"添加";
        [cell addSubview:headLabel2];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - btnClick
-(void)headBtnClick:(HJHMyButton*)btn{
    if(btn.tag > 100000){
        qinShuJieSongMsgViewController *qVC = [[qinShuJieSongMsgViewController alloc]initWithDic:nil];
        qVC.delegate2 = self;
        [self.navigationController pushViewController:qVC animated:YES];
    }
    else{
        qinShuJieSongMsgViewController *qVC = [[qinShuJieSongMsgViewController alloc]initWithDic:[self.qingjiaListArray objectAtIndex:btn.tag%1000]];
        qVC.delegate2 = self;
        [self.navigationController pushViewController:qVC animated:YES];
    }
    
}

-(void)addPhotoBtnClick{
    KGActionSheet *sheet = [[KGActionSheet alloc]initWithCancelTittle:@"取消" ButtonTittles:@[@"照相",@"从手机相册选择"] delegate:self];
    [sheet defaultStyle];
    [sheet setFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] state:UIControlStateNormal];
    [sheet setCancelFontWithColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
    [sheet show];
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

#pragma mark - qinShuJieSongMsgViewDelegate
-(void)getDataByDelegete{
    [self getData];
}
@end
