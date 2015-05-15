//
//  LoginNetWork.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-29.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginNetWork : NSObject
//登录接口
-(void)loginWithUserName:(NSString*)userNme passwd:(NSString*)passwd;
//注册接口
-(void)registerWithUserName:(NSString*)userNme passwd:(NSString*)passwd nickName:(NSString*)nickName;

//添加宝宝
-(void)addBabyWithChildName:(NSString*)childName nickName:(NSString*)nickName gender:(NSString*)gender birthday:(NSString*)birthday bloodType:(NSString*)bloodType portraitUrl:(NSString*)portraitUrl coverUrl:(NSString*)coverUrl bornAddress:(NSString*)bornAddress address:(NSString*)address weight:(NSString*)weight height:(NSString*)height;

//列表查询提醒
-(void)listAlertWithPage:(NSString*)page pageSize:(NSString*)pageSize;

//关于app
-(void)getAboutApp;
@end
