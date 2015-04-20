//
//  youErYuanNetWork.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "youErYuanNetWork.h"


@interface youErYuanNetWork ()
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation youErYuanNetWork
-(void)withoutBindWithUserName:(NSString*)userName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@"userName"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/index/withoutBind",serverAPIAddress];
    
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
            [plistDataManager writeData:responseObject withKey:user_playformList];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"withoutBindSuccess" object:responseObject];
           
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"withoutBindFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getFamilyAddressCoordinateWithChildIdPlatform:(NSString*)childIdPlatform{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/index/getCurrentClass",serverAPIAddress];
    
//    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
//    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getFamilyAddressCoordinateSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getFamilyAddressCoordinateFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}


-(void)getPlatformInformsWithchildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId platformId:(NSString*)platformId semesterId:(NSString*)semesterId page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];

    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/index/getPlatformInforms",serverAPIAddress];
    
//    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
//    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getPlatformInformsSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getPlatformInformsFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}


-(void)getMealSchedulePlatformWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString *)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:dateStart forKey:@"dateStart"];
    [dic setObject:dateEnd forKey:@"dateEnd"];
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/meal/getMealSchedulePlatform",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getMealSchedulePlatformSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getMealSchedulePlatformFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getCourseSchedulePlatformWeekWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/course/getCourseSchedulePlatformWeek",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCourseSchedulePlatformWeekSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCourseSchedulePlatformWeekFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getplatforminformDetailWithInfoId:(NSString*)infoId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:infoId forKey:@"infoId"];
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/index/getPlatformInformDetail",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getplatforminformDetailSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getplatforminformDetailFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getCircleListWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/getCircleList",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCircleListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCircleListFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)praiseAndReplyWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId parentId:(NSString*)parentId type:(NSString*)type content:(NSString*)content{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:parentId forKey:@"parentId"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:content forKey:@"content"];
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/circle/praiseAndReply",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"praiseAndReplySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"praiseAndReplyFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getSemesterExceptionWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    if (![dateStart isEqualToString:@""]) {
        [dic setObject:dateStart forKey:@"dateStart"];
    }
    if (![dateEnd isEqualToString:@""]) {
        [dic setObject:dateEnd forKey:@"dateEnd"];
    }
    
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/semester/getSemesterException",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getSemesterExceptionSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getSemesterExceptionFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getDutyInspectionWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    if (![dateStart isEqualToString:@""]) {
        [dic setObject:dateStart forKey:@"dateStart"];
    }
    if (![dateEnd isEqualToString:@""]) {
        [dic setObject:dateEnd forKey:@"dateEnd"];
    }
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/getDutyInspection",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDutyInspectionSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDutyInspectionFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)listDutyOffApplyWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/listDutyOffApply",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyOffApplySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyOffApplyFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)newDutyOffApplyWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd offReason:(NSString*)offReason offType:(NSString*)offType relativesId:(NSString*)relativesId childNamePlatform:(NSString*)childNamePlatform{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:dateStart forKey:@"dateStart"];
    [dic setObject:dateEnd forKey:@"dateEnd"];
    [dic setObject:offReason forKey:@"offReason"];
    [dic setObject:offType forKey:@"offType"];
    [dic setObject:relativesId forKey:@"relativesId"];
    [dic setObject:childNamePlatform forKey:@"childNamePlatform"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/newDutyOffApply",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newDutyOffApplySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newDutyOffApplyFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)delDutyOffApplyWithApplyId:(NSString*)applyId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:applyId forKey:@"applyId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/delDutyOffApply",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delDutyOffApplySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delDutyOffApplyFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)listCareWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/listCare",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listCareSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listCareFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)newCareWithChildIdPlatform:(NSString*)childIdPlatform careDate:(NSString*)careDate careDesc:(NSString*)careDesc relativesId:(NSString*)relativesId childNamePlatform:(NSString*)childNamePlatform classId:(NSString*)classId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:careDate forKey:@"careDate"];
    [dic setObject:careDesc forKey:@"careDesc"];
    [dic setObject:relativesId forKey:@"relativesId"];
    [dic setObject:childNamePlatform forKey:@"childNamePlatform"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/newCare",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newCareSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newCareFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)declareWithCareId:(NSString*)careId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:careId forKey:@"careId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/delCare",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"declareSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"declareFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)listMedicineWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/listMedicine",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listMedicineSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listMedicineFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)newMedicineWithChildIdPlatform:(NSString*)childIdPlatform takeDate:(NSString*)takeDate medicineName:(NSString*)medicineName takeQty:(NSString*)takeQty takeDesc:(NSString*)takeDesc relativesId:(NSString*)relativesId alertTime1:(NSString*)alertTime1 alertTime2:(NSString*)alertTime2 alertTime3:(NSString*)alertTime3 childNamePlatform:(NSString*)childNamePlatform classId:(NSString*)classId className:(NSString*)className{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:takeDate forKey:@"takeDate"];
    [dic setObject:medicineName forKey:@"medicineName"];
    [dic setObject:takeQty forKey:@"takeQty"];
    [dic setObject:takeDesc forKey:@"takeDesc"];
    [dic setObject:relativesId forKey:@"relativesId"];
    [dic setObject:alertTime1 forKey:@"alertTime1"];
    [dic setObject:alertTime2 forKey:@"alertTime2"];
    [dic setObject:alertTime3 forKey:@"alertTime3"];
    [dic setObject:childNamePlatform forKey:@"childNamePlatform"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:className forKey:@"className"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/newMedicine",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newMedicineSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"newMedicineFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)delMedicineWithMedicineId:(NSString*)medicineId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medicineId forKey:@"medicineId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/duty/delMedicine",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delMedicineSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delMedicineFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getScoreInfoWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId childIdPlatform:(NSString*)childIdPlatform weekIndex:(NSString*)weekIndex{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:childIdPlatform forKey:@"childIdPlatform"];
    [dic setObject:weekIndex forKey:@"weekIndex"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/getScoreInfo",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getScoreInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getScoreInfoFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:msg duration:0.8];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}
@end
