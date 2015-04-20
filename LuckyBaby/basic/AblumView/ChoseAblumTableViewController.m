//
//  ChoseAblumTableViewController.m
//  xiaozhan
//
//  Created by huang on 7/10/14.
//  Copyright (c) 2014 Kugou. All rights reserved.
//

#import "ChoseAblumTableViewController.h"
#import "PostDataBean.h"
#import "ChoseAblumTableViewCell.h"
#import "ColorEx.h"

@interface ChoseAblumTableViewController ()
@property(nonatomic,strong)NSMutableArray *AblumsStringArray;
@property(nonatomic,strong)NSMutableArray *AblumsPhotoCountArray;
@property(nonatomic,strong)NSMutableArray *AblumsFirstPhotoArray;
@end

@implementation ChoseAblumTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.AblumsStringArray = [NSMutableArray array];
    self.AblumsFirstPhotoArray = [NSMutableArray array];
    self.AblumsPhotoCountArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setLeftReturnBtn];
    [self getData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark -navigationItemSet
//返回上一页的按钮
-(void)setLeftReturnBtn{
    UIButton* editeNoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editeNoteButton.frame = CGRectMake(0, 0, 40, 40);
    [editeNoteButton setTitle:@"返回" forState:UIControlStateNormal];
    [editeNoteButton addTarget:self action:@selector(returnLastPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editeNoteButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)getData{
    [self.AblumsFirstPhotoArray removeAllObjects];
    [self.AblumsPhotoCountArray removeAllObjects];
    [self.AblumsStringArray removeAllObjects];
    
    self.library = [[ALAssetsLibrary alloc]init];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"%@",group);
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            [result valueForProperty:ALAssetPropertyType];
            if (result) {
                if (index == 0) {
                    NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                    NSString *g2 = [self cutString:g];
                    NSString *g3 = [self cutStringForPhotoCount:g];
                    [self.AblumsPhotoCountArray addObject:g3];
                    [self.AblumsStringArray addObject:g2];
                    NSLog(@"%@",result);
                    CustomImage* image = [[CustomImage alloc]initWithCGImage:[result thumbnail]];
                    if (image == nil) {
                        image = (CustomImage*)[UIImage imageNamed:@""];
                    }
                    [self.AblumsFirstPhotoArray addObject:image];
                    [self.tableView reloadData];
                }
            }
        }];
    } failureBlock:^(NSError *error) {
        
    }];
}

//切割不同的group
-(NSString*)cutString:(NSString*)string{
    NSString *g2 = @"";
    if (string && [string isKindOfClass:[NSString class]] && string.length > 16) {
        NSLog(@"gg:%@",string);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
        NSString *g1=[string substringFromIndex:16] ;
        NSArray *arr= nil;
        arr=[g1 componentsSeparatedByString:@","];
        g2=[[arr objectAtIndex:0] substringFromIndex:5];
    }
    return g2;
}

//切割不同的图片数
-(NSString*)cutStringForPhotoCount:(NSString*)string{
    NSString *g2 = @"";
    if (string && [string isKindOfClass:[NSString class]] && string.length > 16) {
        NSLog(@"gg:%@",string);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
        NSString *g1=[string substringFromIndex:16] ;
        NSArray *arr= nil;
        arr=[g1 componentsSeparatedByString:@","];
        g2=[[arr objectAtIndex:2] substringFromIndex:14];
    }
    return g2;
}

//返回上一页的方法
-(void)returnLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.AblumsStringArray.count;
}

#pragma mark - getPhotoDelegate
//直接传到上一级
-(void)getPhotoDataArray:(NSMutableArray *)array{
    [self.delegate2 getPhotoDataArray:array];
}

-(void)reloadTableView{
    //[self.delegate2 reloadTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    
    cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // Configure the cell...
    if (!cell) {
            NSLog(@"%d",indexPath.row);
            cell = [[ChoseAblumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    if (cell) {
        ChoseAblumTableViewCell *caCell = (ChoseAblumTableViewCell*)cell;
        caCell.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
        if (indexPath.row < self.AblumsStringArray.count) {
            caCell.namesLabel.text = [self.AblumsStringArray objectAtIndex:indexPath.row];
        }
        if (indexPath.row < self.AblumsFirstPhotoArray.count) {
            caCell.headImageView.image = [self.AblumsFirstPhotoArray objectAtIndex:indexPath.row];
        }
        
        if (indexPath.row < self.AblumsPhotoCountArray.count) {
            caCell.namesLabel2.text = [self.AblumsPhotoCountArray objectAtIndex:indexPath.row];
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GetPhotoViewController *vc = [[GetPhotoViewController alloc]initWithStyle:1];
    vc.sendPhotoStyle = self.sendPhotoStyle;
    [vc maxPhotoCanChose:self.maxPhotoChose];
    //计算又多少张图片
    [vc maxPhotoCanChose2:self.maxPhotoChose2];
    if (indexPath.row < self.AblumsPhotoCountArray.count) {
        vc.ablumName = [self.AblumsStringArray objectAtIndex:indexPath.row];
    }
    vc.delegate2 = self;
    vc.photoNumber = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
