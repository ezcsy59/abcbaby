//
//  HJHUserManager.m
//  youziyuan
//
//  Created by Dickson on 14-8-23.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "HJHUserManager.h"

@implementation HJHUserManager
-(void)creatUser{
    HJHCurrentUser *user = [HJHCurrentUser sharedManager];
    for (int i = 0; i<4; i++) {
        switch (i) {
            case 0:
            {
                user._userImage1 = [UIImage imageNamed:@"T1.jpg"];
                user._userNickName1 = @"张俊";
                user._userId1 = @"37";
            }
                break;
            case 1:
            {
                user._userImage2 = [UIImage imageNamed:@"T2.jpg"];
                user._userNickName2 = @"陈虎";
                user._userId2 = @"38";
            }
                break;
            case 2:
            {
                user._userImage3 = [UIImage imageNamed:@"T4.jpg"];
                user._userNickName3 = @"李丽";
                user._userId3 = @"39";
            }
                break;
            case 3:
            {
                user._userImage4 = [UIImage imageNamed:@"T3.jpg"];
                user._userNickName4 = @"Chris Mo";
                user._userId4 = @"40";
            }
                break;
            default:
                break;
        }
    }
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userData forKey:@"userArray"];
    [userDefaults setObject:@"yes" forKey:@"userHadCreate"];
    [userDefaults synchronize];
}
@end
