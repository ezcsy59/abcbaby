//
//  BanjiQuanViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "BanjiQuanViewController.h"
#import "pengyouquanTableViewCell.h"
#import "penyouquanXiangQingViewController.h"
#import "youErYuanNetWork.h"
#import "pengyouqunFaBuViewController.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0

@interface BanjiQuanViewController ()<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,pengyouquanTableViewCell,sendMessage>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)HJHMyImageView *mainImageView;
@property(nonatomic,strong)NSMutableArray *benliBenArray;
@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSString *className;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation BanjiQuanViewController

-(instancetype)initWithClassId:(NSString*)classId className:(NSString*)className{
    if (self = [super init]) {
        self.classId = classId;
        self.className = className;

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 0;
    self.benliBenArray = [NSMutableArray array];
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCircleListSuccess:) name:@"getCircleListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCircleListFail:) name:@"getCircleListFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(praiseAndReplySuccess:) name:@"praiseAndReplySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(praiseAndReplyFail:) name:@"praiseAndReplyFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    if (self.classId.length > 0) {
        [youE getCircleListWithClassId:self.classId semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
    }
    else{
        [youE getCircleListWithClassId:[DictionaryStringTool stringFromDictionary:dic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"] page:[NSString stringWithFormat:@"%d",self.currentPage] pageSize:@"10"];
    }
    
}

#pragma mark -logic data
-(void)getCircleListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        if (self.currentPage == 0) {
            self.benliBenArray = [[NSMutableArray alloc]initWithArray:array];
        }
        else{
            for (NSDictionary *dic in array) {
                [self.benliBenArray addObject:dic];
            }
        }
    }
    
    //把［察汗］系列变成［p6］系列
    for (int i = 0; i < self.benliBenArray.count; i++) {
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.benliBenArray objectAtIndex:i]];
        NSString *stirng = [dcit objectForKey:@"articleContent"];
        if ([stirng isKindOfClass:[NSString class]]) {
            stirng = [emojiStringChange emojiStringChange:stirng];
            [dcit setObject:stirng forKeyedSubscript:@"articleContent"];
        }
        NSArray *comARR = [dcit objectForKey:@"replyList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            for (int i = 0; i < commintArr.count; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[commintArr objectAtIndex:i]];
                NSString *stirng = [dict objectForKey:@"articleContent"];
                if ([stirng isKindOfClass:[NSString class]]) {
                    stirng = [emojiStringChange emojiStringChange:stirng];
                    [dict setObject:stirng forKey:@"articleContent"];
                }
                [commintArr replaceObjectAtIndex:i withObject:dict];
            }
            [dcit setObject:commintArr forKey:@"replyList"];
        }
        [self.benliBenArray replaceObjectAtIndex:i withObject:dcit];
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

-(void)getCircleListFail:(NSNotification*)noti{
    if(self.currentPage == 0){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshListDataBack) userInfo:nil repeats:NO];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadMoreListDataBack) userInfo:nil repeats:NO];
    }
}

-(void)praiseAndReplySuccess:(NSNotification*)noti{
    
}

-(void)setCommentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.benliBenArray objectAtIndex:[self.currentIndexrow integerValue]]];
        NSArray *comARR = [dcit objectForKey:@"replyList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"articleContent"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"articleContent"];
            [self.benliBenArray replaceObjectAtIndex:[self.currentIndexrow integerValue] withObject:dcit];
        }
        //************************
        [self._tableView reloadData];
    });
}

-(void)praiseAndReplyFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    if (self.classId.length > 0) {
        self.headNavView.titleLabel.text = self.className;
        self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    }
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    [self setMainImageView];
    [self setTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTableView{
    self._tableView = [[PullTableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    ((PullTableView*)(self._tableView)).pullDelegate = self;
    self._tableView.tableHeaderView = self.mainImageView;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
}

-(void)setMainImageView{
    self.mainImageView = [[HJHMyImageView alloc]init];
    self.mainImageView.frame = CGRectMake(0, 0, ScreenWidth, 140);
    self.mainImageView.image = [UIImage imageNamed:@"mybaby_top_bg.png"];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.benliBenArray.count;
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
    cell = [[pengyouquanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    pengyouquanTableViewCell *qCell = (pengyouquanTableViewCell*)cell;
    qCell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    qCell.numberIndexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    qCell.delegate2 = self;
    [qCell resetViewView:[self.benliBenArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    pengyouquanTableViewCell *qCell=  [[pengyouquanTableViewCell alloc]init];
    float f = [qCell getCellHeight:[self.benliBenArray objectAtIndex:indexPath.row]];
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.classId.length > 0){
        penyouquanXiangQingViewController *bVC = [[penyouquanXiangQingViewController alloc]initWithDic:[self.benliBenArray objectAtIndex:indexPath.row] classId:self.classId className:self.className];
        [self.navigationController pushViewController:bVC animated:YES];
    }
    else{
        penyouquanXiangQingViewController *bVC = [[penyouquanXiangQingViewController alloc]initWithDic:[self.benliBenArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:bVC animated:YES];
    }
}

#pragma mark - btnClick
-(void)saveBtnClick{
}

-(void)addData{
    if (self.classId.length > 0) {
        pengyouqunFaBuViewController *pVC =[[pengyouqunFaBuViewController alloc]initWithClassId:self.classId className:self.className];
        [self.navigationController pushViewController:pVC animated:YES];
    }
    else{
        pengyouqunFaBuViewController *pVC =[[pengyouqunFaBuViewController alloc]init];
        [self.navigationController pushViewController:pVC animated:YES];
    }
    
}

#pragma mark - BinLiXiangQingCellDelegate
-(void)pingLunBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    self.currentIndexrow = numberIndexRow;
    [self showKeyboard];
}

-(void)yinPinBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    //    self.currentIndexrow = numberIndexRow;
    //    [self showKeyboard];
    AvaPlayer *player = [AvaPlayer sharedManager];
    NSDictionary *dic = [self.benliBenArray objectAtIndex:[numberIndexRow integerValue]];
    [player playWithUrl:[DictionaryStringTool stringFromDictionary:dic forKey:@"voiceUrl"]];
}

-(void)loveBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    self.currentIndexrow = numberIndexRow;
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    NSDictionary *dict = [plistDataManager getDataWithKey:user_playformList];
    NSDictionary *dic = [self.benliBenArray objectAtIndex:[self.currentIndexrow integerValue]];
    NSDictionary *dicton = [DictionaryStringTool stringFromDictionary:dic forKey:@"replyList"];
    
    if (self.classId.length > 0) {
        [youE praiseAndReplyWithClassId:self.classId semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dicton forKey:@"parentId"] type:@"1" content:@""];
    }
    else{
        [youE praiseAndReplyWithClassId:[DictionaryStringTool stringFromDictionary:dict forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dicton forKey:@"parentId"] type:@"1" content:@""];
    }
    
}

#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.currentMessage = message;
    [self setCommentData];
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    message = [emojiStringChange emojiStringChange2:message];
    NSDictionary *dict = [plistDataManager getDataWithKey:user_playformList];
    NSDictionary *dic = [self.benliBenArray objectAtIndex:[self.currentIndexrow integerValue]];
    NSDictionary *dicton = [DictionaryStringTool stringFromDictionary:dic forKey:@"replyList"];
    if (self.classId.length > 0) {
        [youE praiseAndReplyWithClassId:self.classId semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dicton forKey:@"parentId"] type:@"2" content:message];
    }
    else{
        [youE praiseAndReplyWithClassId:[DictionaryStringTool stringFromDictionary:dict forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dicton forKey:@"parentId"] type:@"2" content:message];
    }
    
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
@end
