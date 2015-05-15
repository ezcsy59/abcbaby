//
//  modChoseViewController.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-5-9.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "modChoseViewController.h"

@interface modChoseViewController ()

@end

@implementation modChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headNavView.titleLabel.text = @"评价模版";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.headNavView.backgroundColor = [UIColor colorWithHexString:@"#7FC369"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
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
