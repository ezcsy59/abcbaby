//
//  addBuMenViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "addBuMenViewController.h"

@interface addBuMenViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *_tableView;
@property(nonatomic,strong)NSMutableArray *buMenArray;
@property(nonatomic,strong)NSMutableArray *buMenArray2;
@property(nonatomic,strong)NSMutableArray *buMenArray3;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)NSMutableArray *compleArray;
@end

@implementation addBuMenViewController

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
    self.buMenArray2 = [NSMutableArray array];
    self.buMenArray3 = [NSMutableArray array];
    for (NSDictionary *dict in self.buMenArray) {
        if ([[DictionaryStringTool stringFromDictionary:dict forKey:@"deptLevel"] isEqualToString:@"1"]) {
            [self.buMenArray2 addObject:dict];
        }
        else{
            [self.buMenArray3 addObject:dict];
        }
    }
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.buMenArray2.count;
    }
    return self.buMenArray3.count;
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
        NSDictionary *dic = [self.buMenArray2 objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(0, 0, 320, 50);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"] forState:UIControlStateNormal];
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
    if (indexPath.section == 1) {
        NSDictionary *dic = [self.buMenArray3 objectAtIndex:indexPath.row];
        HJHMyLabel *label3 = [[HJHMyLabel alloc]init];
        label3.text = [DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"];
        label3.font = [UIFont systemFontOfSize:18];
        label3.frame = CGRectMake(10, 0, 300, 50);
        label3.textColor = [UIColor blackColor];
        [cell addSubview:label3];
        
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"] forState:UIControlStateNormal];
        btn.titleLabel.alpha = 0;
        btn.frame = CGRectMake(260, 10, 30, 30);
        btn.tag = 20000 + 1000 + indexPath.row + 4;
        [btn setImage:[UIImage imageNamed:@"auth_follow_cb_unc"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"auth_follow_cb_chd"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        [self.btnArray addObject:btn];
        
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
            if (![btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                [array addObject:dic];
            }
        }
        self.compleArray = array;
    }
    else{
        btn.selected = YES;
        BOOL canAdd = YES;
        for (NSDictionary *dic in self.compleArray) {
            if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                canAdd = NO;
            }
        }
        if (canAdd == YES) {
            if (btn.tag > 20000) {
                for (NSDictionary *dic in self.buMenArray3) {
                    if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                        [self.compleArray addObject:dic];
                    }
                }
            }
            else{
                for (NSDictionary *dic in self.buMenArray2) {
                    if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                        [self.compleArray addObject:dic];
                    }
                }
            }
        }
    }
    
    if (btn.tag < 20000) {
        if (btn.selected == YES) {
            for (NSDictionary *dic in self.buMenArray2) {
                NSLog(@"%@",btn.titleLabel.text);
                if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                    for (NSDictionary *dict in self.buMenArray3) {
                        if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"] isEqualToString:[DictionaryStringTool stringFromDictionary:dict forKey:@"parentId"]]) {
                            for (HJHMyButton *btn2 in self.btnArray) {
                                if (btn2.tag > 20000) {
                                    btn2.selected = YES;
                                }
                            }
                            
                            for (NSDictionary *dic in self.buMenArray3) {
                                BOOL canAdd = YES;
                                for (NSDictionary *dict in self.compleArray) {
                                    if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"] isEqualToString:[DictionaryStringTool stringFromDictionary:dict forKey:@"deptName"]]) {
                                        canAdd = NO;
                                    }
                                }
                                if (canAdd == YES) {
                                    [self.compleArray addObject:dic];
                                }
                            }
                        }
                    }
                }
            }
        }
        else{
            for (NSDictionary *dic in self.buMenArray2) {
                if ([btn.titleLabel.text isEqualToString:[DictionaryStringTool stringFromDictionary:dic forKey:@"deptName"]]) {
                    for (NSDictionary *dict in self.buMenArray3) {
                        if ([[DictionaryStringTool stringFromDictionary:dic forKey:@"deptId"] isEqualToString:[DictionaryStringTool stringFromDictionary:dict forKey:@"parentId"]]) {
                            for (HJHMyButton *btn2 in self.btnArray) {
                                if (btn2.tag > 20000) {
                                    btn2.selected = NO;
                                }
                            }
                            NSMutableArray *array = [NSMutableArray array];
                            for (NSDictionary *dic in self.compleArray) {
                                if (![[DictionaryStringTool stringFromDictionary:dic forKey:@"deptLevel"] isEqualToString:@"2"]) {
                                    [array addObject:dic];
                                }
                            }
                            self.compleArray = array;
                        }
                    }
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
