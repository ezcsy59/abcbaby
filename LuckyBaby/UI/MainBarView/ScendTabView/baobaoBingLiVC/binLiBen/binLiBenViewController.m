//
//  binLiBenViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "binLiBenViewController.h"
#import "jianKangNetWork.h"
#import "BinLiXiangQingTableViewCell.h"
#import "BinLiXiangqingViewController.h"
#import "jianKangNetWork.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0

@interface binLiBenViewController ()<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,BinLiXiangQingCellDelegate,sendMessage>
@property(nonatomic,strong)PullTableView *_tableView;
@property(nonatomic,strong)NSMutableArray *benliBenArray;
@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;
@end

@implementation binLiBenViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDiseaseListSuccess:) name:@"getDiseaseListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDiseaseListFail:) name:@"getDiseaseListFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDiseaseCommentSuccess:) name:@"saveDiseaseCommentSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDiseaseCommentFail:) name:@"saveDiseaseCommentFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.benliBenArray = [NSMutableArray array];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [jianK getDiseaseListWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"] page:@"0" pageSize:@"10"];
}

#pragma mark -logic data
-(void)getDiseaseListSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.benliBenArray = [[NSMutableArray alloc]initWithArray:array];
    }
    
    //把［察汗］系列变成［p6］系列
    for (int i = 0; i < self.benliBenArray.count; i++) {
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.benliBenArray objectAtIndex:i]];
        NSString *stirng = [dcit objectForKey:@"diseaseDesc"];
        if ([stirng isKindOfClass:[NSString class]]) {
            stirng = [emojiStringChange emojiStringChange:stirng];
            [dcit setObject:stirng forKeyedSubscript:@"diseaseDesc"];
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
        [self.benliBenArray replaceObjectAtIndex:i withObject:dcit];
    }
    //************************
    [self._tableView reloadData];
}

-(void)getDiseaseListFail:(NSNotification*)noti{
    
}

-(void)saveDiseaseCommentSuccess:(NSNotification*)noti{
    
}

-(void)setCommentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:[self.benliBenArray objectAtIndex:[self.currentIndexrow integerValue]]];
        NSArray *comARR = [dcit objectForKey:@"commentList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"commentDesc"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"commentList"];
            [self.benliBenArray replaceObjectAtIndex:[self.currentIndexrow integerValue] withObject:dcit];
        }
        //************************
        [self._tableView reloadData];
    });
}

-(void)saveDiseaseCommentFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
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
    self._tableView.frame = CGRectMake(0, 0, ScreenWidth, (iPhone5?568:480) - 44 - 80);
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
    return self.benliBenArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell = [[BinLiXiangQingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    BinLiXiangQingTableViewCell *qCell = (BinLiXiangQingTableViewCell*)cell;
    qCell.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    qCell.numberIndexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    qCell.delegate2 = self;
    [qCell resetViewView:[self.benliBenArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BinLiXiangQingTableViewCell *qCell=  [[BinLiXiangQingTableViewCell alloc]init];
    float f = [qCell getCellHeight:[self.benliBenArray objectAtIndex:indexPath.row]];
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BinLiXiangqingViewController *bVC = [[BinLiXiangqingViewController alloc]initWithXiangQingDic:[self.benliBenArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:bVC animated:YES];
}

#pragma mark - btnClick
-(void)saveBtnClick{
}

#pragma mark - BinLiXiangQingCellDelegate
-(void)pingLunBtnClickWithNumberIndexRow:(NSString *)numberIndexRow{
    self.currentIndexrow = numberIndexRow;
    [self showKeyboard];
}

#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.currentMessage = message;
    [self setCommentData];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    message = [emojiStringChange emojiStringChange2:message];
    NSDictionary *dic = [self.benliBenArray objectAtIndex:[self.currentIndexrow integerValue]];
    [jianK saveDiseaseCommentWithDiseaseId:[dic objectForKey:@"diseaseId"] commentDesc:message];
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
