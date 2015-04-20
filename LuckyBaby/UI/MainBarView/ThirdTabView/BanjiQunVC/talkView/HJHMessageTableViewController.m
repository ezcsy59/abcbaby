//
//  HJHMessageTableViewController.m
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHMessageTableViewController.h"
#import "stringChange.h"
#import "HJHMessageBean.h"
@interface HJHMessageTableViewController ()
@property(nonatomic,assign)CGFloat allHeight;
@end

@implementation HJHMessageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.allHeight = 0;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSLog(@"%ld",(long)indexPath.row);
        cell = [[HJHMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    HJHMessageTableViewCell *mCell = (HJHMessageTableViewCell*)cell;
    NSLog(@"%@,%ld",self.messageArray,(long)indexPath.row);
    HJHMessageBean *mBean = [self.messageArray objectAtIndex:indexPath.row];
    mCell.messageLabel.text = mBean.messageText;
    mCell.isMyMessage = mBean.isMyMessage;
    HJHCurrentUser *userDefualt = [HJHCurrentUser sharedManager];
    if (mCell.isMyMessage) {
        CGFloat height = [stringChange makeStringHeight:mCell.messageLabel.text andSize:15 andLenth:240];
        NSInteger line = [stringChange makeStringLine:mCell.messageLabel.text andSize:15 andwedth:240];
        CGFloat width;
        if (height > 18) {
            width = 240;
        }else{
            width = [stringChange makeStringMaxWidth:mCell.messageLabel.text andSize:15 andLenth:240];
        }
        mCell.messageLabel.numberOfLines = line;
        mCell.messageLabel.frame = CGRectMake(5, 10, width, 18*line);
        mCell.bgImageView.frame = CGRectMake(320 - 40 - width - 35, 25, width+35, 20 + 18*line);
        mCell.userImageView.frame = CGRectMake(320 - 30 -5, 25, 30, 30);
        mCell.messageName.text = self.talkingToName;
        mCell.messageName.frame = CGRectMake(320 - 40 - 35, 10, 150, 15);
//        [mCell.userImageView setImage:userDefualt._userImage4];
        UIImage *image = [UIImage imageNamed:@"talk_002.9"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [mCell.bgImageView setImage:image];
        mCell.messageLabel.textColor = [UIColor whiteColor];
    }else{
        HJHCurrentUser *user = [HJHCurrentUser sharedManager];
        CGFloat height = [stringChange makeStringHeight:mCell.messageLabel.text andSize:15 andLenth:240];
        NSInteger line = [stringChange makeStringLine:mCell.messageLabel.text andSize:15 andwedth:240];
        CGFloat width;
        if (height > 18) {
            width = 240;
        }else{
            width = [stringChange makeStringMaxWidth:mCell.messageLabel.text andSize:15 andLenth:240];
        }
        mCell.messageLabel.numberOfLines = line;
        mCell.messageLabel.frame = CGRectMake(5, 10, width, 18*line);
        mCell.bgImageView.frame = CGRectMake(40, 25, width+35, 20 + 18*line);
        mCell.userImageView.frame = CGRectMake(5, 25, 30, 30);
//        [mCell.userImageView setImage:self.talkingToImage];
        mCell.messageName.text = user._userNickName4;
        mCell.messageName.frame = CGRectMake(40, 10, 150, 15);
        UIImage *image = [UIImage imageNamed:@"talk_001.9"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [mCell.bgImageView setImage:image];
        mCell.messageLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HJHMessageBean *mBean = [self.messageArray objectAtIndex:indexPath.row];
    NSInteger line = [stringChange makeStringLine:mBean.messageText andSize:15 andwedth:240];
    CGFloat height = 39 + line * 18;
    self.allHeight += height;
    if (iPhone5) {
        if (self.allHeight > 470) {
            [tableView setContentOffset:CGPointMake(0, self.allHeight - 470)];
        }
    }else{
        if (self.allHeight > 470 - 88) {
            [tableView setContentOffset:CGPointMake(0, self.allHeight - 470 - 88)];
        }
    }
    
    return height;
}

@end
