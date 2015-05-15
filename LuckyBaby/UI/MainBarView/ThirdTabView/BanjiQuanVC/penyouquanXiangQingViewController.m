//
//  penyouquanXiangQingViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "penyouquanXiangQingViewController.h"
#import "pengyouquanTableViewCell.h"
#import "BinLiXiangqingViewController.h"
#import "youErYuanNetWork.h"
#import "pengyouqunFaBuViewController.h"
#define kDefaultToolbarHeight 42
#define kIOS7 0

@interface penyouquanXiangQingViewController ()<UITableViewDataSource,UITableViewDelegate,pengyouquanTableViewCell,sendMessage>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)HJHMyImageView *mainImageView;
@property(nonatomic,strong)NSDictionary *benliBenDic;
@property(nonatomic,strong)NSString *currentIndexrow;
@property(nonatomic,strong)NSString *currentMessage;

@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSString *className;
@end

@implementation penyouquanXiangQingViewController

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.benliBenDic = dic;
    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary *)dic classId:(NSString*)classId className:(NSString*)className{
    if (self = [super init]) {
        self.benliBenDic = dic;
        self.classId = classId;
        self.className = className;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCircleListSuccess:) name:@"getCircleListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCircleListFail:) name:@"getCircleListFail" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(praiseAndReplySuccess:) name:@"praiseAndReplySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(praiseAndReplyFail:) name:@"praiseAndReplyFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
}

#pragma mark -logic data
-(void)getCircleListSuccess:(NSNotification*)noti{
}

-(void)getCircleListFail:(NSNotification*)noti{
    
}

-(void)praiseAndReplySuccess:(NSNotification*)noti{
    
}

-(void)setCommentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dcit = [[NSMutableDictionary alloc]initWithDictionary:self.benliBenDic];
        NSArray *comARR = [dcit objectForKey:@"replyList"];
        if ([comARR isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *commintArr = [[NSMutableArray alloc]initWithArray:comARR];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:self.currentMessage forKey:@"articleContent"];
            [dict setObject:@"爷爷" forKey:@"creatorName"];
            [commintArr addObject:dict];
            [dcit setObject:commintArr forKey:@"articleContent"];
            self.benliBenDic = dict;
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
    
    if (self.classId.length > 0) {
        self.headNavView.titleLabel.text = self.className;
        self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    }
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    [self setTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTableView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, (iPhone5?568:480) - [self getNavHight]);
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
    return 1;
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
    [qCell resetViewView:self.benliBenDic];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    pengyouquanTableViewCell *qCell=  [[pengyouquanTableViewCell alloc]init];
    float f = [qCell getCellHeight:self.benliBenDic];
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - btnClick
-(void)saveBtnClick{
}

-(void)addData{
    if(self.classId.length > 0){
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

#pragma mark - sendMessageDelegate
-(void)postMessage:(NSString *)message{
    self.currentMessage = message;
    [self setCommentData];
    youErYuanNetWork *youE = [[youErYuanNetWork alloc]init];
    message = [emojiStringChange emojiStringChange2:message];
    NSDictionary *dict = [plistDataManager getDataWithKey:user_playformList];
    NSDictionary *dic = self.benliBenDic;
    
    if(self.classId.length > 0){
        [youE praiseAndReplyWithClassId:self.classId semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dic forKey:@"parentId"] type:@"2" content:message];
    }
    else{
        [youE praiseAndReplyWithClassId:[DictionaryStringTool stringFromDictionary:dict forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dict forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dict forKey:@"platformId"] parentId:[DictionaryStringTool stringFromDictionary:dic forKey:@"parentId"] type:@"2" content:message];
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
@end
