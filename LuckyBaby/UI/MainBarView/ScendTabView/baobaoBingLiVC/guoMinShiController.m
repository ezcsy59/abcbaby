//
//  guoMinShiController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "guoMinShiController.h"
#import "jianKangNetWork.h"
#import "TQRichTextView.h"

@interface guoMinShiController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSArray *guoMinShiArray;


@end

@implementation guoMinShiController

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDiseaseAllergySumSuccess:) name:@"listDiseaseAllergySumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listDiseaseAllergySumFail:) name:@"listDiseaseAllergySumFail" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getData{
    self.guoMinShiArray = [NSArray array];
    jianKangNetWork *jianK = [[jianKangNetWork alloc]init];
    NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
    [jianK listDiseaseAllergySumWithChildIdFamily:[DictionaryStringTool stringFromDictionary:dic forKey:@"childIdFamilyCurrent"]];
}

#pragma mark -logic data
-(void)listDiseaseAllergySumSuccess:(NSNotification*)noti{
    NSDictionary *dic = [noti object];
    NSArray *array = [dic objectForKey:@"data"];
    if ([array isKindOfClass:[NSArray class]]) {
        self.guoMinShiArray = array;
    }
    [self._tableView reloadData];
}

-(void)listDiseaseAllergySumFail:(NSNotification*)noti{
    
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
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, 0, ScreenWidth, (iPhone5?568:480) - 44 - 80);
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self._tableView setContentSize:CGSizeMake(ScreenWidth, 568 - 198 + 95)];
    [self.view addSubview:self._tableView];
    
    HJHMyImageView *headerImage = [[HJHMyImageView alloc]init];
    headerImage.frame = CGRectMake(0, 0, 320, 35);
    self._tableView.tableHeaderView = headerImage;
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, 49, 320, 1);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [headerImage addSubview:footImage];
    
    HJHMyLabel *nameLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(00, 0, 100, 35)];
    nameLabel.text = @"病名";
    nameLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [headerImage addSubview:nameLabel];
    
    HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(100, 0, 100, 35)];
    zuijinLabel.text = @"最近";
    zuijinLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:18];
    zuijinLabel.textAlignment = NSTextAlignmentCenter;
    [headerImage addSubview:zuijinLabel];
    
    HJHMyLabel *coutLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 0, 100, 35)];
    coutLabel.text = @"次数";
    coutLabel.textColor = [UIColor colorWithHexString:@"4DD0C8"];
    coutLabel.backgroundColor = [UIColor clearColor];
    coutLabel.font = [UIFont systemFontOfSize:18];
    coutLabel.textAlignment = NSTextAlignmentCenter;
    [headerImage addSubview:coutLabel];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.guoMinShiArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    NSDictionary *dic = [self.guoMinShiArray objectAtIndex:indexPath.row];
    TQRichTextView *xiangQingLabel = [[TQRichTextView alloc]initWithFrame:CGRectMake(0, 0, 100, 0)];
    xiangQingLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"allergyName"];
    xiangQingLabel.textColor = [UIColor colorWithHexString:@"666666"];
    xiangQingLabel.backgroundColor = [UIColor clearColor];
    xiangQingLabel.font = [UIFont systemFontOfSize:18];
    xiangQingLabel.lineSpacing = 0.1;
    xiangQingLabel.userInteractionEnabled = NO;
    if (xiangQingLabel.drawheigth < 40) {
        xiangQingLabel.frame = CGRectMake(5, 20, 100, 20);
    }
    else{
        xiangQingLabel.frame = CGRectMake(5, 10, 100, xiangQingLabel.drawheigth);
    }
    [cell addSubview:xiangQingLabel];
    
    NSString *time = [DictionaryStringTool stringFromDictionary:dic forKey:@"lastdate"];
    if (time.length >= 3) {
        time = [TimeChange timeChage:[time substringToIndex:time.length - 3]];
    }
    NSArray *timeA = [time componentsSeparatedByString:@" "];
    NSString *timeString = [timeA objectAtIndex:0];
    
    HJHMyLabel *zuijinLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(100, 10, 100, (xiangQingLabel.drawheigth < 40)?50:xiangQingLabel.drawheigth)];
    zuijinLabel.text = timeString;
    zuijinLabel.textColor = [UIColor colorWithHexString:@"666666"];
    zuijinLabel.backgroundColor = [UIColor clearColor];
    zuijinLabel.font = [UIFont systemFontOfSize:18];
    zuijinLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:zuijinLabel];
    
    HJHMyLabel *coutLabel = [[HJHMyLabel alloc]initWithFrame:CGRectMake(200, 10, 100, (xiangQingLabel.drawheigth < 40)?50:xiangQingLabel.drawheigth)];
    coutLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"count"];
    coutLabel.textColor = [UIColor colorWithHexString:@"666666"];
    coutLabel.backgroundColor = [UIColor clearColor];
    coutLabel.font = [UIFont systemFontOfSize:18];
    coutLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:coutLabel];
    
    HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
    footImage.frame = CGRectMake(0, (xiangQingLabel.drawheigth < 40)?60:(xiangQingLabel.drawheigth + 20) - 1, 320, 0.5);
    footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
    [cell addSubview:footImage];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.guoMinShiArray objectAtIndex:indexPath.row];
    TQRichTextView *xiangQingLabel = [[TQRichTextView alloc]initWithFrame:CGRectMake(0, 0, 100, 0)];
    xiangQingLabel.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"allergyName"];
    xiangQingLabel.textColor = [UIColor colorWithHexString:@"666666"];
    xiangQingLabel.backgroundColor = [UIColor clearColor];
    xiangQingLabel.font = [UIFont systemFontOfSize:18];
    xiangQingLabel.lineSpacing = 0.1;
    xiangQingLabel.userInteractionEnabled = NO;
    return (xiangQingLabel.drawheigth < 40)?60:(xiangQingLabel.drawheigth + 20);
}
@end
