//
//  BanjiQunViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "BanjiQunViewController.h"
#import "HJHTalkingViewController.h"
@interface BanjiQunViewController ()

@end

@implementation BanjiQunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    HJHTalkingViewController *tVC = [[HJHTalkingViewController alloc]init];
    [self addChildViewController:tVC];
    tVC.view.frame = CGRectMake(0, 0, 320, (iPhone5?568:480));
    [self.view addSubview:tVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
