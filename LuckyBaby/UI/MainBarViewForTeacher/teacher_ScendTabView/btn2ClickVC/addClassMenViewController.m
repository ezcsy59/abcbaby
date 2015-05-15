//
//  addClassViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addClassViewController.h"

@interface addClassViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSMutableArray *buMenArray;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)NSMutableArray *compleArray;
@end

@implementation addClassViewController

-(instancetype)initWithBuMenArray:(NSArray*)array{
    if (self = [super init]) {
        self.buMenArray = [[NSMutableArray alloc]initWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = self.title;
    self.btnArray = [NSMutableArray array];
    self.compleArray = [NSMutableArray array];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.rigthBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self setTableView];
    
}

-(void)setTableView{
    self._tableView = [[UITableView alloc]init];
    self._tableView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, 568 - [self getNavHight]);
    if (!iPhone5) {
        self._tableView.frame = CGRectMake(0, [self getNavHight], ScreenWidth, 480 - [self getNavHight]);
    }
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    [self.view addSubview:self._tableView];
    
    self._tableView.bounces = NO;
    self._tableView.showsHorizontalScrollIndicator = NO;
    self._tableView.showsVerticalScrollIndicator = NO;
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
    return self.buMenArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    if (indexPath.section == 0) {
        NSDictionary *dic = [self.buMenArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"className"];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(0, 0, 320, 50);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"] forState:UIControlStateNormal];
        btn.titleLabel.alpha = 0;
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(260, 10, 30, 30);
        btn.tag = 10000 + 1000 + indexPath.row;
        [btn setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        HJHMyImageView *footImage = [[HJHMyImageView alloc]init];
        footImage.frame = CGRectMake(0, 49, 320, 0.5);
        footImage.backgroundColor = [UIColor colorWithHexString:@"C8C7CC"];
        [cell addSubview:footImage];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(void)selectbtnClick:(UIButton*)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.compleArray) {
            if (![btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"]]) {
                [array addObject:dic];
            }
        }
        self.compleArray = array;
    }
    else{
        btn.selected = YES;
        BOOL canAdd = YES;
        for (NSDictionary *dic in self.compleArray) {
            if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"]]) {
                canAdd = NO;
            }
        }
        if (canAdd == YES) {
            for (NSDictionary *dic in self.buMenArray) {
                if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"className"]]) {
                    [self.compleArray addObject:dic];
                }
            }
        }
    }
}

-(void)saveBtnClick{
    [self.delegate2 selectBuMenArray:self.compleArray];
    [self.navigationController popViewControllerAnimated:YES];
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
