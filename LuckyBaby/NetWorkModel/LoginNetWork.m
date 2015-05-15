//
//  LoginNetWork.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-29.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "LoginNetWork.h"

@interface LoginNetWork ()
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation LoginNetWork
-(void)loginWithUserName:(NSString*)userNme passwd:(NSString*)passwd{
    
    passwd = [MyMD5 md5WithString:passwd];
    
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userNme forKey:@"userName"];
    [dic setObject:passwd forKey:@"passwd"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    

    NSString *urlString = [NSString stringWithFormat:@"%@/relatives/login",serverAPIAddress];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[DictionaryStringTool stringFromDictionary:responseObject forKey:@"data"]];
            [dict setObject:userNme forKey:@"userName"];
            [dict setObject:passwd forKey:@"passwd"];
            [responseObject setObject:dict forKey:@"data"];
            [plistDataManager writeData:responseObject withKey:user_loginList];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:responseObject];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginFail" object:msg];
        }
        
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)registerWithUserName:(NSString*)userNme passwd:(NSString*)passwd nickName:(NSString*)nickName{
    
    passwd = [MyMD5 md5WithString:passwd];
    
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userNme forKey:@"userName"];
    [dic setObject:passwd forKey:@"passwd"];
    [dic setObject:nickName forKeyedSubscript:@"nickName"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/relatives/register",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerFail" object:msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}


-(void)useInvitationCodeWithUserName:(NSString*)userName InvitationCode:(NSString*)invitationCode relationsName:(NSString*)relationsName relativesNickname:(NSString*)relativesNickname{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@"reltivesId"];
    [dic setObject:invitationCode forKey:@"invitationCode"];
    [dic setObject:relationsName forKey:@"relationsName"];
    [dic setObject:relativesNickname forKey:@"relativesNickname"];
    dic = [networkDicHeader addHeaderDic:dic];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/relatives/register",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)addBabyWithChildName:(NSString*)childName nickName:(NSString*)nickName gender:(NSString*)gender birthday:(NSString*)birthday bloodType:(NSString*)bloodType portraitUrl:(NSString*)portraitUrl coverUrl:(NSString*)coverUrl bornAddress:(NSString*)bornAddress address:(NSString*)address weight:(NSString*)weight height:(NSString*)height{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([childName isKindOfClass:[NSString class]]) {
        [dic setObject:childName forKey:@"childName"];
    }
    if ([nickName isKindOfClass:[NSString class]]) {
        [dic setObject:nickName forKey:@"nickName"];
    }
    if ([gender isKindOfClass:[NSString class]]) {
        [dic setObject:gender forKey:@"gender"];
    }
    if ([birthday isKindOfClass:[NSString class]]) {
        [dic setObject:birthday forKey:@"birthday"];
    }
    if ([bloodType isKindOfClass:[NSString class]]) {
        [dic setObject:bloodType forKey:@"bloodType"];
    }
    if ([portraitUrl isKindOfClass:[NSString class]]) {
        [dic setObject:portraitUrl forKeyedSubscript:@"coverUrl"];
    }
    if ([bornAddress isKindOfClass:[NSString class]]) {
        [dic setObject:bornAddress forKeyedSubscript:@"bornAddress"];
    }
    if ([address isKindOfClass:[NSString class]]) {
        [dic setObject:address forKeyedSubscript:@"address"];
    }
    if ([weight isKindOfClass:[NSString class]]) {
        [dic setObject:weight forKeyedSubscript:@"weight"];
    }
    if ([height isKindOfClass:[NSString class]]) {
        [dic setObject:height forKeyedSubscript:@"height"];
    }
    NSDictionary *dic1 = [plistDataManager getDataWithKey:user_loginList];
    NSString *user_id = [dic1 objectForKey:@"userId"];
    [dic setObject:user_id forKey:@"createdBy"];

    dic = [networkDicHeader addHeaderDic:dic];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/addBabyInfo",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"修改完成" duration:0.8];
        }
        else{
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"修改失败" duration:0.8];
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerFail" object:msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)listAlertWithPage:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/setting/listAlert",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listAlertSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listAlertFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getAboutApp{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/setting/getAboutApp",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAboutAppSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAboutAppFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}
@end
