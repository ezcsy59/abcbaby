//
//  ThirdTabViewController.h
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ThirdTabViewController : UIViewController<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
-(void)pullTableRefresh:(PullTableView*)pullTableView;
-(void)pullTableViewLoadMore:(PullTableView*)pullTableView;
@end
