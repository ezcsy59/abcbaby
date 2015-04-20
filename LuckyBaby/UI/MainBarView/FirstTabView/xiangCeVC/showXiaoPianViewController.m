//
//  showXiaoPianViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-5.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "showXiaoPianViewController.h"
#import "dongtaiNetWork.h"
#import "showBigPhotoViewController.h"

@interface showXiaoPianViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *photoArray;
@end

@implementation showXiaoPianViewController

-(instancetype)initWithBigPhotoUrlArray:(NSArray*)bPArray smallPhotoArray:(NSArray*)sPArray{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"宝宝所有照片";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllPhotosSuccess:) name:@"getAllPhotosSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllPhotosFail:) name:@"getAllPhotosFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)getAllPhotosSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *arr = [dic objectForKey:@"data"];
    if ([arr isKindOfClass:[NSArray class]]) {
        self.photoArray = arr;
    }
    [self._tableView reloadData];
}

-(void)getAllPhotosFail:(NSNotification*)noti{
    
}

-(void)getData{
    NSDictionary *dic = [plistDataManager getDataWithKey:@"user_loginList.plist"];
    dongtaiNetWork *dongN = [[dongtaiNetWork alloc]init];
    [dongN getAllPhotosWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:@"0" size:@"20"];
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
            NSString *imageString = [DictionaryStringTool stringFromDictionary:dic forKey:@"mediaThumbailUrl"];
            NSURL *imageUrl = [NSURL URLWithString:imageString];
            [photoBtn setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"ic_picture_loading.png"]];
            [cell addSubview:photoBtn];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}

#pragma mark - btnClick
-(void)photoBtnClick:(HJHMyButton*)btn{
    showBigPhotoViewController *sBPVC = [[showBigPhotoViewController alloc]initWithPhotoA:(self.photoArray) andTab:btn.tag isLocationPhoto:NO];
    [self.navigationController pushViewController:sBPVC animated:YES];
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
