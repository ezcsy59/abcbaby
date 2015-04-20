//
//  UIBasicNavigationViewController.m
//  huang
//
//  Created by AA on 14-1-2.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "UIBasicNavigationViewController.h"

@interface UIBasicNavigationViewController ()

@end

@implementation UIBasicNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//   
//    UIViewController* viewController = [super popViewControllerAnimated:NO];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    transition.removedOnCompletion = YES;
//    [self.view.layer addAnimation:transition forKey:@""];
//  
//    return viewController;
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
