//
//  dashijianViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-5.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "dashijianViewController.h"
#import "dongtaiNetWork.h"
#import "DaShiJianTableViewCell.h"
#import "dashijianXiangQingTableViewController.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0
@interface dashijianViewController ()<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,sendMessage,DaShiJianTableViewCellDelegate>
@property(nonatomic,strong)NSMutableArray *daShiJianArray;
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation dashijianViewController

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 0;
    [self getData];
    self.daShiJianArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStoryFirstListSuccess:) name:@"getStoryFirstListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStoryFirstListFail:) name:@"getStoryFirstListFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStoryCommentSuccess:) name:@"saveStoryCommentSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveStoryCommentFail:) name:@"saveStoryCommentFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    dongtaiNetWork *donT = [[dongtaiNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [donT getStoryFirstListWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
}

-(void)saveStoryCommentSuccess:(NSNotification*)noti{
    
}

-(void)saveStoryCommentFail:(NSNotification*)noti{
    
}

#pragma mark -logic data
-(void)getStoryFirstListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        if ([array isKindOfClass:[NSArray class]]) {
            if (self.currentPage == 0) {
                self.daShiJianArray = [[NSMutableArray alloc]initWithArray:array];
            }
            else{
                for (NSDictionary *dic in array) {
                    [self.daShiJianArray addObject:dic];
                }
            }
        }
    }
    
    //把［察汗］系列变成［p6］系列
    for (int i = 0; i < self.daShiJianArray.count; i++) {
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.daShiJianArray objectAtIndex:i]];
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
        [self.daShiJianArray replaceObjectAtIndex:i withObject:dcit];
    }
    //************************
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
    [self._tableView reloadData];
}

-(void)getStoryFirstListFail:(NSNotification*)noti{
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"大事件";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self setTableView];
    // Do any additional setup after loading the view.
}

-(void)setTableView{
    self._tableView = [[PullTableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    ((PullTableView*)(self._tableView)).pullDelegate = self;
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
    return self.daShiJianArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell removeFromSuperview];
    cell = nil;
    cell = [[DaShiJianTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    DaShiJianTableViewCell *qCell = (DaShiJianTableViewCell*)cell;
    qCell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    qCell.numberIndexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    qCell.delegate2 = self;
    [qCell resetViewView:[self.daShiJianArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DaShiJianTableViewCell *qCell=  [[DaShiJianTableViewCell alloc]init];
    float f = [qCell getCellHeight:[self.daShiJianArray objectAtIndex:indexPath.row]];
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dashijianXiangQingTableViewController *bVC = [[dashijianXiangQingTableViewController alloc]initWithXiangQingDic:[self.daShiJianArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:bVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btnClick
-(void)setCommentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.daShiJianArray objectAtIndex:[self.currentIndexrow integerValue]]];
        NSArray *comARR = [dcit objectForKey:@"commentList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"commentDesc"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"commentList"];
            [self.daShiJianArray replaceObjectAtIndex:[self.currentIndexrow integerValue] withObject:dcit];
        }
        //************************
        [self._tableView reloadData];
    });
}

#pragma mark - BinLiXiangQingCellDelegate
-(void)pingLunBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
//    self.currentIndexrow = numberIndexRow;
    [self showKeyboard];
}

-(void)yinPinBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    //    self.currentIndexrow = numberIndexRow;
    //    [self showKeyboard];
    AvaPlayer *player = [AvaPlayer sharedManager];
    NSDictionary *dic = [self.daShiJianArray objectAtIndex:[numberIndexRow integerValue]];
    [player playWithUrl:[DictionaryStringTool stringFromDictionary:dic forKey:@"voiceUrl"]];
}

#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.currentMessage = message;
    [self setCommentData];
    dongtaiNetWork *dongT = [[dongtaiNetWork alloc]init];
    message = [emojiStringChange emojiStringChange2:message];
    NSDictionary *dic = [self.daShiJianArray objectAtIndex:[self.currentIndexrow integerValue]];
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
        InputToolbarView.heightBreak = 0;
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
    //    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    self.currentPage ++;
    [self getData];
}


-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    NSLog(@"hello");
    NSLog(@"%@",pullTableView);
    //    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    self.currentPage = 0;
    [self getData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
