//
//  Tab5_insertFirstTabVC.h
//  shuoshuo3
//
//  Created by huang on 3/5/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "UIInputToolbarViewController2.h"

@interface Tab5_insertFirstTabVC : UIViewController<PullTableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIInputToolbarViewController2 *InputToolbarView;
}

-(void)pullTableRefresh:(PullTableView*)pullTableView;
-(void)pullTableViewLoadMore:(PullTableView*)pullTableView;
@end
