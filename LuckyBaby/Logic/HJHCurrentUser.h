//
//  HJHCurrentUser.h
//  youziyuan
//
//  Created by Dickson on 14-8-23.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJHCurrentUser : NSObject{
    UIImage *_userImage1;
    NSString *_userNickName1;
    NSString *_userId1;
    
    UIImage *_userImage2;
    NSString *_userNickName2;
    NSString *_userId2;

    UIImage *_userImage3;
    NSString *_userNickName3;
    NSString *_userId3;

    UIImage *_userImage4;
    NSString *_userNickName4;
    NSString *_userId4;

    NSMutableArray *_userArray;
}
@property(nonatomic,strong)NSMutableArray *_userArray;
@property(nonatomic,strong)UIImage *_userImage1;
@property(nonatomic,strong)NSString *_userNickName1;
@property(nonatomic,strong)NSString *_userId1;
@property(nonatomic,strong)UIImage *_userImage2;
@property(nonatomic,strong)NSString *_userNickName2;
@property(nonatomic,strong)NSString *_userId2;
@property(nonatomic,strong)UIImage *_userImage3;
@property(nonatomic,strong)NSString *_userNickName3;
@property(nonatomic,strong)NSString *_userId3;
@property(nonatomic,strong)UIImage *_userImage4;
@property(nonatomic,strong)NSString *_userNickName4;
@property(nonatomic,strong)NSString *_userId4;

@property(nonatomic,strong)NSString *currentUserId;
+ (HJHCurrentUser *)sharedManager;
@end
