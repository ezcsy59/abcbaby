//
//  Tab5_insertFirstTabVC.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "Tab5_insertFirstTabVC.h"
#import "HJHMainCell.h"
#import "tianjiaBabyViewController.h"
#import "qinLieBiaoViewController.h"
#import "xiangCeViewController.h"
#import "dashijianViewController.h"
#import "firstXiangQingTableViewCell.h"
#import "dongtaiNetWork.h"
#import "firstXiangQingViewController.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface Tab5_insertFirstTabVC ()<firstXiangQingTableViewCell,sendMessage>
@property(nonatomic,strong)EGORefreshTableHeaderView *_refreshHeaderView;
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)HJHMyImageView *mainImageView;

@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSMutableArray *fisrtXiangQingArray;

@end

@implementation Tab5_insertFirstTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStoryListSuccess:) name:@"getStoryListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStoryListFail:) name:@"getStoryListFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStoryCommentSuccess:) name:@"saveStoryCommentSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStoryCommentFail:) name:@"saveStoryCommentFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.fisrtXiangQingArray = [NSMutableArray array];
    dongtaiNetWork *donT = [[dongtaiNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [donT getStoryListWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:@"0" pageSize:@"10"];
}

#pragma mark -logic data
-(void)getStoryListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.fisrtXiangQingArray = [[NSMutableArray alloc]initWithArray:array];
    }
    
    //把［察汗］系列变成［p6］系列
    for (int i = 0; i < self.fisrtXiangQingArray.count; i++) {
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.fisrtXiangQingArray objectAtIndex:i]];
        NSString *stirng = [dcit objectForKey:@"storyDesc"];
        if ([stirng isKindOfClass:[NSString class]]) {
            stirng = [emojiStringChange emojiStringChange:stirng];
            [dcit setObject:stirng forKey:@"storyDesc"];
        }
        NSArray *comARR = [dcit objectForKey:@"commentList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            for (int i = 0; i < commintArr.count; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[commintArr objectAtIndex:i]];
                NSString *stirng = [dict objectForKey:@"commentDesc"];
                if ([stirng isKindOfClass:[NSString class]]) {
                    stirng = [emojiStringChange emojiStringChange:stirng];
                    [dict setObject:stirng forKeyedSubscript:@"commentDesc"];
                }
                [commintArr replaceObjectAtIndex:i withObject:dict];
            }
            [dcit setObject:commintArr forKey:@"commentList"];
        }
        [self.fisrtXiangQingArray replaceObjectAtIndex:i withObject:dcit];
    }
    //************************
    [self._tableView reloadData];
}

-(void)getStoryListFail:(NSNotification*)noti{
    
}

-(void)saveStoryCommentSuccess:(NSNotification*)noti{
    
}

-(void)saveStoryCommentFail:(NSNotification*)noti{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMainImageView];
    [self setMainTableView];
    // Do any additional setup after loading the view.
}

-(void)setMainTableView{
    self._tableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, -5, ScreenWidth, 568 - 198 + 78) style:UITableViewStylePlain];
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, -5, ScreenWidth, 568 - 198 + 78 - 88);
    }
    
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.tableHeaderView = self.mainImageView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.mainImageView = [[HJHMyImageView alloc]init];
    self.mainImageView.frame = CGRectMake(0, 0, ScreenWidth, 198 + 60);
    self.mainImageView.image = [UIImage imageNamed:@"mybaby_top_bg.png"];
    
    for (int i = 0; i < 4; i++) {
        HJHMyButton *btn = [[HJHMyButton alloc]init];
        btn.frame = CGRectMake(i*80, 198, 80, 60);
        btn.tag = i;
        [btn addTarget:self action:@selector(fistViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainImageView addSubview:btn];
        HJHMyLabel *label = [[HJHMyLabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(0, 40, 80, 20);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
        switch (i) {
            case 0:
            {
                btn.backgroundColor = [UIColor colorWithHexString:@"#4FCEAD"];
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"main_album_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(20, 5, 40, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"相册";
            }
                break;
            case 1:
            {
                btn.backgroundColor = [UIColor colorWithHexString:@"#FED43F"];
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"main_friends_and_family_img.png"];
                btnImageView.contentMode = UIViewContentModeScaleAspectFit;
                btnImageView.frame = CGRectMake(20, 5, 40, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"亲友团";
            }
                break;
            case 2:
            {
                btn.backgroundColor = [UIColor colorWithHexString:@"#5F9FEA"];
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"mian_baby_info_img.png"];
                btnImageView.frame = CGRectMake(20, 5, 40, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"宝贝信息";
            }
                break;
            case 3:
            {
                btn.backgroundColor = [UIColor colorWithHexString:@"#EF717E"];
                HJHMyImageView *btnImageView = [[HJHMyImageView alloc]init];
                btnImageView.userInteractionEnabled = NO;
                btnImageView.image = [UIImage imageNamed:@"main_breaking_news_img.png"];
                btnImageView.frame = CGRectMake(20, 5, 40, 35);
                [btn addSubview:btnImageView];
                
                label.text = @"大事记";
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - btnClick
-(void)fistViewBtnClick:(HJHMyButton*)btn{
    switch (btn.tag) {
        case 0:
        {
            xiangCeViewController *xiangC = [[xiangCeViewController alloc]init];
            [self.navigationController pushViewController:xiangC animated:YES];
        }
            break;
        case 1:
        {
            qinLieBiaoViewController *qinB = [[qinLieBiaoViewController alloc]init];
            [self.navigationController pushViewController:qinB animated:YES];
        }
            break;
        case 2:
        {
            tianjiaBabyViewController *babayM = [[tianjiaBabyViewController alloc]initWithStyle:1];
            [self.navigationController pushViewController:babayM animated:YES];
        }
            break;
        case 3:
        {
            dashijianViewController *daVC = [[dashijianViewController alloc]init];
            [self.navigationController pushViewController:daVC animated:YES];
        }
            break;
            
        default:
            break;
    }
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
    return self.fisrtXiangQingArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell = [[firstXiangQingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    firstXiangQingTableViewCell *qCell = (firstXiangQingTableViewCell*)cell;
    qCell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    qCell.numberIndexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    qCell.delegate2 = self;
    [qCell resetViewView:[self.fisrtXiangQingArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    firstXiangQingTableViewCell *qCell=  [[firstXiangQingTableViewCell alloc]init];
    float f = [qCell getCellHeight:[self.fisrtXiangQingArray objectAtIndex:indexPath.row]];
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    firstXiangQingViewController *bVC = [[firstXiangQingViewController alloc]initWithXiangQingDic:[self.fisrtXiangQingArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:bVC animated:YES];
}

#pragma mark - btnClick
-(void)setCommentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.fisrtXiangQingArray objectAtIndex:[self.currentIndexrow integerValue]]];
        NSArray *comARR = [dcit objectForKey:@"commentList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"commentDesc"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"commentList"];
            [self.fisrtXiangQingArray replaceObjectAtIndex:[self.currentIndexrow integerValue] withObject:dcit];
        }
        else{
            NSMutableArray *commintArr = [NSMutableArray array];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"commentDesc"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"commentList"];
            [self.fisrtXiangQingArray replaceObjectAtIndex:[self.currentIndexrow integerValue] withObject:dcit];
        }
        //************************
        [self._tableView reloadData];
    });
}

#pragma mark -firstXiangQingDelegate
-(void)pingLunBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    self.currentIndexrow = numberIndexRow;
    [self showKeyboard];
}

#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.currentMessage = message;
    [self setCommentData];
    dongtaiNetWork *dongT = [[dongtaiNetWork alloc]init];
    message = [emojiStringChange emojiStringChange2:message];
    NSDictionary *dic = [self.fisrtXiangQingArray objectAtIndex:[self.currentIndexrow integerValue]];
    [dongT saveStoryCommentWithStoryId:[DictionaryStringTool stringFromDictionary:dic forKey:@"storyId"] commentDesc:message voiceUrl:@""];
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
        //heightBreak
        InputToolbarView.heightBreak = 70;
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

#pragma mark - pullTableViewDelegate


-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
}


-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    NSLog(@"hello");
    NSLog(@"%@",pullTableView);
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
}

-(void)refreshListDataBack{
    [self pullTableRefresh:(PullTableView*)self._tableView];
}

-(void)loadMoreListDataBack{
    [self pullTableViewLoadMore:(PullTableView*)self._tableView];
}

-(void)changeStyle{
    NSDate* date = [NSDate date];
    ((PullTableView*)self._tableView).pullLastRefreshDate = date;
    ((PullTableView*)self._tableView).pullTableIsRefreshing = NO;
    ((PullTableView*)self._tableView).pullTableIsLoadingMore = NO;
}

-(void)pullTableRefresh:(PullTableView*)pullTableView
{
    NSDate* date = [NSDate date];
    pullTableView.pullLastRefreshDate = date;
    pullTableView.pullTableIsRefreshing = NO;
    pullTableView.loadMoreView.isLoading = NO;
}

-(void)pullTableViewLoadMore:(PullTableView*)pullTableView
{
    NSDate* date = [NSDate date];
    pullTableView.pullLastRefreshDate = date;
    pullTableView.pullTableIsLoadingMore = NO;
    pullTableView.refreshView.isLoading = NO;
}


@end
