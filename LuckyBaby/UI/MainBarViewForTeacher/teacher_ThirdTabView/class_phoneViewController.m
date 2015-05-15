//
//  class_phoneViewController.m
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "class_phoneViewController.h"
#import "TeacherNetWork.h"

@interface class_phoneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *listarray;
    NSArray *secLabelArray;
    NSMutableDictionary *arrayDict;
    NSMutableArray *arrayDictKey;
    UITableView* tableView;
}
@property (nonatomic,retain)NSArray *listarray;
@property (nonatomic,retain)NSArray *secLabelArray;
@property (nonatomic,retain)NSMutableDictionary *arrayDict;
@property (nonatomic,retain)NSMutableArray *arrayDictKey;
@property (nonatomic,retain)UITableView* tableView;
@property(nonatomic,strong)NSArray *tongGaoArray;

@property(nonatomic,strong)HJHMyButton *sSelectBtn;
@property(nonatomic,strong)HJHMyButton *s_sSelectBtn;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *insertDic;
@end

@implementation class_phoneViewController

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.insertDic = [[NSDictionary alloc]initWithDictionary:dic];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listChildContactInfoWithGradeSuccess:) name:@"listChildContactInfoWithGradeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listChildContactInfoWithGradeFail:) name:@"listChildContactInfoWithGradeFail" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -logic data
-(void)listChildContactInfoWithGradeSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            NSString *name = [DictionaryStringTool stringFromDictionary:dict forKey:@"name"];
            [mArray addObject:name];
        }
        self.dataArray = [[NSMutableArray alloc]initWithArray:array];
        [self setMainTableView:mArray];
        
    }
    //************************
}

-(void)listChildContactInfoWithGradeFail:(NSNotification*)noti{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"选择班级";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.tongGaoArray = [NSArray array];
    
    TeacherNetWork *tNet = [[TeacherNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:teacher_loginList];
    [tNet listChildContactInfoWithClassId:[DictionaryStringTool stringFromDictionary:self.insertDic forKey:@"classId"] semesterId:[DictionaryStringTool stringFromDictionary:dic forKey:@"semesterId"] platformId:[DictionaryStringTool stringFromDictionary:dic forKey:@"platformId"]];
    // Do any additional setup after loading the view.
}
//NSInteger nickNameSort(id user1, id user2, void *context)
//{
//    NSString *u1,*u2;
//    //类型转换
//    u1 = (User*)artificer1;
//    u2 = (User*)artificer2;
//    return  [u1.nickName localizedCompare:u2.nickName
//             ];
//}
-(void)setMainTableView:(NSArray *)array{
    NSArray *sortArr = [array sortedArrayUsingFunction:nickNameSort context:NULL];
    //    NSLog(@"%@,%@",sortArr,string);
    //    self.listarray = array;
    //    NSLog(@"listarryCount:%d",[listarray count]);
    //    secLabelArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C",@"D", @"E", @"F",@"G", @"H", @"I",@"J", @"K", @"L",@"M", @"N", @"O",@"P", @"Q", @"R",@"S", @"T", @"U",@"V", @"W", @"X",@"Y", @"Z", nil];
    
    NSMutableArray *arrayA = [NSMutableArray array];
    NSMutableArray *arrayB = [NSMutableArray array];
    NSMutableArray *arrayC = [NSMutableArray array];
    NSMutableArray *arrayD = [NSMutableArray array];
    NSMutableArray *arrayE = [NSMutableArray array];
    NSMutableArray *arrayF = [NSMutableArray array];
    NSMutableArray *arrayG = [NSMutableArray array];
    NSMutableArray *arrayH = [NSMutableArray array];
    NSMutableArray *arrayI = [NSMutableArray array];
    NSMutableArray *arrayJ = [NSMutableArray array];
    NSMutableArray *arrayK = [NSMutableArray array];
    NSMutableArray *arrayL = [NSMutableArray array];
    NSMutableArray *arrayM = [NSMutableArray array];
    NSMutableArray *arrayN = [NSMutableArray array];
    NSMutableArray *arrayO = [NSMutableArray array];
    NSMutableArray *arrayP = [NSMutableArray array];
    NSMutableArray *arrayQ = [NSMutableArray array];
    NSMutableArray *arrayR = [NSMutableArray array];
    NSMutableArray *arrayS = [NSMutableArray array];
    NSMutableArray *arrayT = [NSMutableArray array];
    NSMutableArray *arrayU = [NSMutableArray array];
    NSMutableArray *arrayV = [NSMutableArray array];
    NSMutableArray *arrayW = [NSMutableArray array];
    NSMutableArray *arrayX = [NSMutableArray array];
    NSMutableArray *arrayY = [NSMutableArray array];
    NSMutableArray *arrayZ = [NSMutableArray array];
    
    
    for (NSString *string in sortArr) {
        NSString *changeString = [self transformToPinyin:string];
        changeString = [changeString substringToIndex:1];
        if ([changeString isEqualToString:@"a"] || [changeString isEqualToString:@"A"]) {
            [arrayA addObject:string];
        }
        else if([changeString isEqualToString:@"b"] || [changeString isEqualToString:@"B"]){
            [arrayB addObject:string];
        }
        else if([changeString isEqualToString:@"c"] || [changeString isEqualToString:@"C"]){
            [arrayC addObject:string];
        }
        else if([changeString isEqualToString:@"d"] || [changeString isEqualToString:@"D"]){
            [arrayD addObject:string];
        }
        else if([changeString isEqualToString:@"e"] || [changeString isEqualToString:@"E"]){
            [arrayE addObject:string];
        }
        else if([changeString isEqualToString:@"f"] || [changeString isEqualToString:@"F"]){
            [arrayF addObject:string];
        }
        else if([changeString isEqualToString:@"g"] || [changeString isEqualToString:@"G"]){
            [arrayG addObject:string];
        }
        else if([changeString isEqualToString:@"h"] || [changeString isEqualToString:@"H"]){
            [arrayH addObject:string];
        }
        else if([changeString isEqualToString:@"i"] || [changeString isEqualToString:@"I"]){
            [arrayI addObject:string];
        }
        else if([changeString isEqualToString:@"j"] || [changeString isEqualToString:@"J"]){
            [arrayJ addObject:string];
        }
        else if([changeString isEqualToString:@"k"] || [changeString isEqualToString:@"K"]){
            [arrayK addObject:string];
        }
        else if([changeString isEqualToString:@"l"] || [changeString isEqualToString:@"L"]){
            [arrayL addObject:string];
        }
        else if([changeString isEqualToString:@"m"] || [changeString isEqualToString:@"M"]){
            [arrayM addObject:string];
        }
        else if([changeString isEqualToString:@"n"] || [changeString isEqualToString:@"N"]){
            [arrayN addObject:string];
        }
        else if([changeString isEqualToString:@"o"] || [changeString isEqualToString:@"O"]){
            [arrayO addObject:string];
        }
        else if([changeString isEqualToString:@"p"] || [changeString isEqualToString:@"P"]){
            [arrayP addObject:string];
        }
        else if([changeString isEqualToString:@"q"] || [changeString isEqualToString:@"Q"]){
            [arrayQ addObject:string];
        }
        else if([changeString isEqualToString:@"r"] || [changeString isEqualToString:@"R"]){
            [arrayR addObject:string];
        }
        else if([changeString isEqualToString:@"s"] || [changeString isEqualToString:@"S"]){
            [arrayS addObject:string];
        }
        else if([changeString isEqualToString:@"t"] || [changeString isEqualToString:@"T"]){
            [arrayT addObject:string];
        }
        else if([changeString isEqualToString:@"u"] || [changeString isEqualToString:@"U"]){
            [arrayU addObject:string];
        }
        else if([changeString isEqualToString:@"v"] || [changeString isEqualToString:@"V"]){
            [arrayV addObject:string];
        }
        else if([changeString isEqualToString:@"w"] || [changeString isEqualToString:@"W"]){
            [arrayW addObject:string];
        }
        else if([changeString isEqualToString:@"x"] || [changeString isEqualToString:@"X"]){
            [arrayX addObject:string];
        }
        else if([changeString isEqualToString:@"y"] || [changeString isEqualToString:@"Y"]){
            [arrayY addObject:string];
        }
        else if([changeString isEqualToString:@"z"] || [changeString isEqualToString:@"Z"]){
            [arrayZ addObject:string];
        }
    }
    
    arrayDictKey = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    arrayDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:arrayA,[arrayDictKey objectAtIndex:0],
                 arrayB,[arrayDictKey objectAtIndex:1],
                 arrayC,[arrayDictKey objectAtIndex:2],
                 arrayD,[arrayDictKey objectAtIndex:3],
                 arrayE,[arrayDictKey objectAtIndex:4],
                 arrayF,[arrayDictKey objectAtIndex:5],
                 arrayG,[arrayDictKey objectAtIndex:6],
                 arrayH,[arrayDictKey objectAtIndex:7],
                 arrayI,[arrayDictKey objectAtIndex:8],
                 arrayJ,[arrayDictKey objectAtIndex:9],
                 arrayK,[arrayDictKey objectAtIndex:10],
                 arrayL,[arrayDictKey objectAtIndex:11],
                 arrayM,[arrayDictKey objectAtIndex:12],
                 arrayN,[arrayDictKey objectAtIndex:13],
                 arrayO,[arrayDictKey objectAtIndex:14],
                 arrayP,[arrayDictKey objectAtIndex:15],
                 arrayQ,[arrayDictKey objectAtIndex:16],
                 arrayR,[arrayDictKey objectAtIndex:17],
                 arrayS,[arrayDictKey objectAtIndex:18],
                 arrayT,[arrayDictKey objectAtIndex:19],
                 arrayU,[arrayDictKey objectAtIndex:20],
                 arrayV,[arrayDictKey objectAtIndex:21],
                 arrayW,[arrayDictKey objectAtIndex:22],
                 arrayX,[arrayDictKey objectAtIndex:23],
                 arrayY,[arrayDictKey objectAtIndex:24],
                 arrayZ,[arrayDictKey objectAtIndex:25],
                 nil];
    NSLog(@"arrayrow:%d",[[arrayDict objectForKey:[arrayDictKey objectAtIndex:1]] count]);
    
    if (!(arrayA.count > 0)) {
        [arrayDict removeObjectForKey:@"A"];
        [arrayDictKey removeObject:@"A"];
    }
    if (!(arrayB.count > 0)) {
        [arrayDict removeObjectForKey:@"B"];
        [arrayDictKey removeObject:@"B"];
    }
    if (!(arrayC.count > 0)) {
        [arrayDict removeObjectForKey:@"C"];
        [arrayDictKey removeObject:@"C"];
    }
    if (!(arrayD.count > 0)) {
        [arrayDict removeObjectForKey:@"D"];
        [arrayDictKey removeObject:@"D"];
    }
    if (!(arrayE.count > 0)) {
        [arrayDict removeObjectForKey:@"E"];
        [arrayDictKey removeObject:@"E"];
    }
    if (!(arrayF.count > 0)) {
        [arrayDict removeObjectForKey:@"F"];
        [arrayDictKey removeObject:@"F"];
    }
    if (!(arrayG.count > 0)) {
        [arrayDict removeObjectForKey:@"G"];
        [arrayDictKey removeObject:@"G"];
    }
    if (!(arrayH.count > 0)) {
        [arrayDict removeObjectForKey:@"H"];
        [arrayDictKey removeObject:@"H"];
    }
    if (!(arrayI.count > 0)) {
        [arrayDict removeObjectForKey:@"I"];
        [arrayDictKey removeObject:@"I"];
    }
    if (!(arrayJ.count > 0)) {
        [arrayDict removeObjectForKey:@"J"];
        [arrayDictKey removeObject:@"J"];
    }
    if (!(arrayK.count > 0)) {
        [arrayDict removeObjectForKey:@"K"];
        [arrayDictKey removeObject:@"K"];
    }
    if (!(arrayL.count > 0)) {
        [arrayDict removeObjectForKey:@"L"];
        [arrayDictKey removeObject:@"L"];
    }
    if (!(arrayM.count > 0)) {
        [arrayDict removeObjectForKey:@"M"];
        [arrayDictKey removeObject:@"M"];
    }
    if (!(arrayN.count > 0)) {
        [arrayDict removeObjectForKey:@"N"];
        [arrayDictKey removeObject:@"N"];
    }
    if (!(arrayO.count > 0)) {
        [arrayDict removeObjectForKey:@"O"];
        [arrayDictKey removeObject:@"O"];
    }
    if (!(arrayP.count > 0)) {
        [arrayDict removeObjectForKey:@"P"];
        [arrayDictKey removeObject:@"P"];
    }
    if (!(arrayQ.count > 0)) {
        [arrayDict removeObjectForKey:@"Q"];
        [arrayDictKey removeObject:@"Q"];
    }
    if (!(arrayR.count > 0)) {
        [arrayDict removeObjectForKey:@"R"];
        [arrayDictKey removeObject:@"R"];
    }
    if (!(arrayS.count > 0)) {
        [arrayDict removeObjectForKey:@"S"];
        [arrayDictKey removeObject:@"S"];
    }
    if (!(arrayT.count > 0)) {
        [arrayDict removeObjectForKey:@"T"];
        [arrayDictKey removeObject:@"T"];
    }
    if (!(arrayU.count > 0)) {
        [arrayDict removeObjectForKey:@"U"];
        [arrayDictKey removeObject:@"U"];
    }
    if (!(arrayV.count > 0)) {
        [arrayDict removeObjectForKey:@"V"];
        [arrayDictKey removeObject:@"V"];
    }
    if (!(arrayW.count > 0)) {
        [arrayDict removeObjectForKey:@"W"];
        [arrayDictKey removeObject:@"W"];
    }
    if (!(arrayX.count > 0)) {
        [arrayDict removeObjectForKey:@"X"];
        [arrayDictKey removeObject:@"X"];
    }
    if (!(arrayY.count > 0)) {
        [arrayDict removeObjectForKey:@"Y"];
        [arrayDictKey removeObject:@"Y"];
    }
    if (!(arrayZ.count > 0)) {
        [arrayDict removeObjectForKey:@"Z"];
        [arrayDictKey removeObject:@"Z"];
    }
    
    if(!tableView){
        tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHight], 320, (iPhone5?568:480) - [self getNavHight])];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [self.view addSubview:tableView];
    }
    [tableView reloadData];
}

NSInteger nickNameSort(id user1, id user2, void *context)
{
    NSString *u1,*u2;
    //类型转换
    u1 = (NSString*)user1;
    u2 = (NSString*)user2;
    return  [u1 localizedCompare:u2
             ];
}

- (NSString *)transformToPinyin:(NSString *)string {
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    //* 出现几组
    //if(aTableView == self.tableView) return 27;
    return [arrayDict count];
}

//*字母排序搜索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //* 字母索引列表
    /*NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
     
     for(char c= 'A';c<='Z';c++)
     
     [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];*/
    
    return arrayDictKey;
    
    /*NSMutableArray *newarr=[[NSMutableArray alloc]initWithArray:listarray];
     [newarr addObject:@"{search}"]; //等价于[arr addObject:UITableViewIndexSearch];
     return newarr;*/
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //搜索时显示按索引第几组
    NSInteger count = 0;
    NSLog(@"%@",title);
    for(NSString *character in arrayDictKey)
    {
        
        if([character isEqualToString:title])
        {
            
            return count;
            
        }
        
        count ++;
        
    }
    
    return count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    /*if([listarray count]==0)
     
     {
     
     return @"";
     
     }*/
    
    //return [listarray objectAtIndex:section];   //*分组标签s
    return [arrayDictKey objectAtIndex:section];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.listarray count];    //*每组要显示的行数
    //NSInteger i = [[listarray objectAtIndex:section] ]
    NSInteger i =  [[arrayDict objectForKey:[arrayDictKey objectAtIndex:section]] count];
    return i;
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    //返回类型选择按钮
    
    return UITableViewCellAccessoryNone;   //每行右边的图标
}
- (UITableViewCell *)tableView:(UITableView *)tableview
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    NSUInteger row = [indexPath row];
    NSUInteger sectionMy = [indexPath section];
    NSLog(@"sectionMy:%d",sectionMy);
    
    HJHMyLabel *label = [[HJHMyLabel alloc]init];
    label.text = [[arrayDict objectForKey:[arrayDictKey objectAtIndex:sectionMy]] objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:18];
    label.frame = CGRectMake(50, 0, 100, 50);
    label.textColor = [UIColor blackColor];
    [cell addSubview:label];
    
    //    NSString *str=  [NSString stringWithFormat: @"%d", row];
    
    
    NSDictionary *diction = [NSDictionary dictionary];
    for (NSDictionary *dict in self.dataArray) {
        if ([[DictionaryStringTool stringFromDictionary:dict forKey:@"name"] isEqualToString:label.text]) {
        diction = dict;
        }
    }
    
    HJHMyImageView *imageV = [[HJHMyImageView alloc]init];
    imageV.frame = CGRectMake(10, 10, 30, 30);
    imageV.clipsToBounds = YES;
    imageV.layer.cornerRadius = 15;
    [cell addSubview:imageV];
    
    if ([[DictionaryStringTool stringFromDictionary:diction forKey:@"headImgUrl"] isKindOfClass:[NSString class]]) {
        [imageV setImageWithURL:[NSURL URLWithString:[DictionaryStringTool stringFromDictionary:diction forKey:@"headImgUrl"]] placeholderImage:nil];
    }
    else{
        [imageV setImage:[UIImage imageNamed:@"imgheader"]];
    }
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 49, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    HJHMyImageView *rightImage = [[HJHMyImageView alloc]init];
    rightImage.contentMode = UIViewContentModeScaleAspectFit;
    rightImage.clipsToBounds = YES;
    rightImage.backgroundColor = [UIColor whiteColor];
    rightImage.frame = CGRectMake(275, 10, 20, 30);
    rightImage.image = [UIImage imageNamed:@"phone"];
    [cell addSubview:rightImage];
    
    return cell;
}
//划动cell是否出现del按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return YES;  //是否需要删除图标
}
//编辑状态(不知道干什么用)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewDidLoad];
}

//选中时执行的操作
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    NSDictionary *diction = [NSDictionary dictionary];
    for (NSDictionary *dict in self.dataArray) {
        if ([[DictionaryStringTool stringFromDictionary:dict forKey:@"name"] isEqualToString:string]) {
            diction = dict;
        }
    }
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[DictionaryStringTool stringFromDictionary:diction forKey:@"mobile"]]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    return indexPath;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //这里控制值的大小
    return 50.0;  //控制行高
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.listarray = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
