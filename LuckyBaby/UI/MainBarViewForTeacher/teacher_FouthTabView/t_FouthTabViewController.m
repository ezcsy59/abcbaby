//
//  t_FouthTabViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "t_FouthTabViewController.h"
#import "t_HJHFouthMainCell.h"
#import "baiduDiTuViewController.h"
#import "xigaiMimaViewController.h"
#import "tiXingViewController.h"
#import "guanyuViewController.h"
#import "UIButton+WebCache.h"
@interface t_FouthTabViewController ()<KGTipViewDelegate>{
    KGTipView *_tipView;
}
@property(nonatomic,strong)UITableView *_tableView;
@end

@implementation t_FouthTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setBiaoMianView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMainTableView];
	// Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor whiteColor];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(10, -15, ScreenWidth - 20, 568 - 198 + 88);
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(10, -5, ScreenWidth - 20, 568 - 198 + 78 - 88);
    }
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
    
    self._tableView.bounces = NO;
    self._tableView.showsHorizontalScrollIndicator = NO;
    self._tableView.showsVerticalScrollIndicator = NO;
    
    HJHMyImageView *headerImagView = [[HJHMyImageView alloc]init];
    headerImagView.contentMode = UIViewContentModeScaleToFill;
    headerImagView.frame = CGRectMake(0, 0, ScreenWidth, 135);
    self._tableView.tableHeaderView = headerImagView;
    
    HJHMyImageView *bgColorImageV = [[HJHMyImageView alloc]init];
    bgColorImageV.frame = CGRectMake(0, 30, 300, 95);
    bgColorImageV.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [headerImagView addSubview:bgColorImageV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgColorTap)];
    [headerImagView addGestureRecognizer:tap];
    
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    HJHMyLabel *headerLabel = [[HJHMyLabel alloc]init];
    headerLabel.frame = CGRectMake(95, 35, 100, 80);
    headerLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"nickName"];
    headerLabel.font = [UIFont systemFontOfSize:20];
    [headerImagView addSubview:headerLabel];
    
    HJHMyButton *headerBtn = [[HJHMyButton alloc]init];
    headerBtn.frame = CGRectMake(10, 40, 70, 70);
    headerBtn.layer.cornerRadius = 35;
    headerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    headerBtn.layer.borderWidth = 2;
    headerBtn.userInteractionEnabled = NO;
    headerBtn.clipsToBounds = YES;
    [headerBtn setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:dic forKey:@"portraitUrl"]] placeholderImage:[UIImage imageNamed:@"ic_picture_loadfailed"]];
    [headerImagView addSubview:headerBtn];
    
    
    HJHMyImageView *footImagView = [[HJHMyImageView alloc]init];
    footImagView.backgroundColor = [UIColor whiteColor];
    footImagView.contentMode = UIViewContentModeScaleToFill;
    footImagView.frame = CGRectMake(0, 0, ScreenWidth, 71);
    self._tableView.tableFooterView = footImagView;
    
    HJHMyButton *logoutBtn = [[HJHMyButton alloc]init];
    logoutBtn.frame = CGRectMake(10, 10, 280, 51);
    UIImage *image =[UIImage imageNamed:@"ic_btn_add_course_green_pressed.9.png"];
    image  = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [logoutBtn setBackgroundImage:image forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"注销登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footImagView addSubview:logoutBtn];
    
    
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
        return 3;
    }
    else{
        return 2;
    }
    // Return the number of rows in the section.
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[t_HJHFouthMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    t_HJHFouthMainCell* comCell = (t_HJHFouthMainCell*)cell;
    comCell.rightImage.image = [UIImage imageNamed:@"ic_course_more_classmates.png"];
    comCell.label2.hidden = YES;
    comCell.footLayer.hidden = NO;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                break;
            case 0:
            {
                comCell.label.text = @"修改账户";
                comCell.leftImage.image = [UIImage imageNamed:@"up_password.png"];
            }
                break;
            case 2:
            {
                comCell.label.text = @"跳转到家长端";
                comCell.leftImage.image = [UIImage imageNamed:@"remind_img.png"];
            }
                break;
            case 1:
            {
                comCell.label.text = @"关于APP";
                comCell.leftImage.image = [UIImage imageNamed:@"about_app_img.png"];
            }
                break;
            default:
                break;
        }
    }
//    else if(indexPath.section == 1){
//        switch (indexPath.row) {
//            case 0:
//            {
//                comCell.label.text = @"清除缓存";
//                comCell.leftImage.image = [UIImage imageNamed:@"clear_cache_img.png"];
//            }
//                break;
//            case 1:
//            {
//                comCell.label.text = @"检查更新";
//                comCell.label2.hidden = NO;
//                comCell.label2.text = @"v1.0.0.3";
//                comCell.leftImage.image = [UIImage imageNamed:@"version_updating_img.png"];
//            }
//                break;
//            default:
//                break;
//        }
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        xigaiMimaViewController *bVC = [[xigaiMimaViewController alloc]initWithStyle:1];
        [self.navigationController pushViewController:bVC animated:YES];
    }
    if(indexPath.section == 0 && indexPath.row == 1){
        guanyuViewController *gVC = [[guanyuViewController alloc]initWithStyle:1];
        [self.navigationController pushViewController:gVC animated:YES];
    }
    if(indexPath.section == 0 && indexPath.row == 2){
        RootViewController* root = (RootViewController*)getCurrentRootController;
        [self dismissViewControllerAnimated:NO completion:nil];
        [root deleteT_MainView];
        [root addMainView];
    }
}

#pragma mark - btnClick
- (void)loginBtnClick
{
    if(_tipView){
        [_tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    }
    NSArray *buttons = [NSArray arrayWithObjects:@"确定", nil];
    _tipView = [[KGTipView alloc] initWithTitle:nil context:@"确定要退出登录吗？" cancelButtonTitle:@"取消" otherCancelButton:buttons lockType:LockTypeGlobal delegate:self userInfo:nil];
    [_tipView show];
}

-(void)bgColorTap{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tipview delegate
- (void)KGTipVIew:(KGTipView *)tipView buttonOfIndex:(NSInteger)index userInfo:(id)userInfo
{
    [_tipView stopLoadingAnimationWithTitle:nil context:nil duration:0];
    if(index == 1){
        //登录中的提示
        RootViewController* root = (RootViewController*)getCurrentRootController;
        [root deleteMainView];
        [root addLoginView];
        
        NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
        //改plist的值childIdFamily和childNicknameFamily
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:dic];
        [dict setObject:@"" forKey:@"userId"];
        NSMutableDictionary *dictData = [NSMutableDictionary dictionary];
        [dictData setObject:dict forKey:@"data"];
        [plistDataManager writeData:dictData withKey:user_loginList];
    }
}
@end
