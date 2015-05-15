//
//  jianKangNetWork.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-3.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "jianKangNetWork.h"

@interface jianKangNetWork ()
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation jianKangNetWork
-(void)getJianKangListWithPageSize:(NSString*)pageSize page:(NSString*)page{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:pageSize forKey:@"pageSize"];
    [dic setObject:page forKey:@"page"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/healthIndex/getKnowledges",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getJianKangListSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getJianKangListFail" object:msg];
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

-(void)listHealthPlatformIndexWithChildIdFamily:(NSString*)childIdFamily pageSize:(NSString*)pageSize page:(NSString*)page{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:pageSize forKey:@"pageSize"];
    [dic setObject:page forKey:@"page"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listHealthPlatformIndex",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHealthPlatformIndexSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHealthPlatformIndexListFail" object:msg];
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

-(void)listVaccinumWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listVaccinum",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listVaccinumSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listVaccinumFail" object:msg];
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

-(void)getVaccinumDescWithVacDocId:(NSString*)vacDocId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:vacDocId forKey:@"vacDocId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/getVaccinumDesc",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getVaccinumDescSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getVaccinumDescFail" object:msg];
            
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

-(void)saveVaccinumWithVacDocId:(NSString*)vacDocId vacDate:(NSString*)vacDate isDone:(NSString*)isDone relativesId:(NSString*)relativesId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:vacDocId forKey:@"vacDocId"];
    [dic setObject:vacDate forKey:@"vacDate"];
    [dic setObject:isDone forKey:@"isDone"];
    [dic setObject:relativesId forKey:@"relativesId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/saveVaccinum",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveVaccinumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveVaccinumFail" object:msg];
            
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

-(void)listWeightRefWithGender:(NSString*)gender{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:gender forKey:@"gender"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listWeightRef",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listWeightRefSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listWeightRefFail" object:msg];
            
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

-(void)listHeightRefWithGender:(NSString*)gender{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:gender forKey:@"gender"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listHeightRef",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHeightRefSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHeightRefFail" object:msg];
            
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

-(void)saveHealthInfoWithChildId:(NSString*)childId weight:(NSString*)weight height:(NSString *)height sightLeft:(NSString *)sightLeft sightRight:(NSString*)sightRight teethTotal:(NSString*)teethTotal teethDisease:(NSString*)teethDisease createdBy:(NSString*)createdBy createdDate:(NSString*)createdDate updatedBy:(NSString*)updatedBy updatedDate:(NSString*)updatedDate seflItemValue1:(NSString*)seflItemValue1 seflItemValue2:(NSString*)seflItemValue2 seflItemValue3:(NSString*)seflItemValue3 seflItemValue4:(NSString*)seflItemValue4 seflItemValue5:(NSString*)seflItemValue5 seflItemValue6:(NSString*)seflItemValue6{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:childId forKey:@"childId"];
    [dict setObject:weight forKey:@"weight"];
    [dict setObject:height forKey:@"height"];
    [dict setObject:sightLeft forKey:@"sightLeft"];
    [dict setObject:sightRight forKey:@"sightRight"];
    [dict setObject:teethTotal forKey:@"teethTotal"];
    [dict setObject:teethDisease forKey:@"teethDisease"];
    [dict setObject:createdBy forKey:@"createdBy"];
    [dict setObject:createdDate forKey:@"createdDate"];
    [dict setObject:updatedBy forKey:@"updatedBy"];
    [dict setObject:updatedDate forKey:@"updatedDate"];
    [dict setObject:seflItemValue1 forKey:@"seflItemValue1"];
    [dict setObject:seflItemValue2 forKey:@"seflItemValue2"];
    [dict setObject:seflItemValue3 forKey:@"seflItemValue3"];
    [dict setObject:seflItemValue4 forKey:@"seflItemValue4"];
    [dict setObject:seflItemValue5 forKey:@"seflItemValue5"];
    [dict setObject:seflItemValue6 forKey:@"seflItemValue6"];
    [dic setObject:dict forKey:@"healthFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/saveHealthInfo",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveHealthInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveHealthInfoFail" object:msg];
            
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

-(void)getHealthPlatformWithHealthId:(NSString*)healthId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:healthId forKey:@"healthId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/getHealthPlatform",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getHealthPlatformSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getHealthPlatformFail" object:msg];
            
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

-(void)listHealthInfoWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listHealthInfo",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHealthInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listHealthInfoFail" object:msg];
            
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

-(void)delHealthInfoWithHealthId:(NSString*)healthId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:healthId forKey:@"healthId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/delHealthInfo",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delHealthInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delHealthInfoFail" object:msg];
            
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

-(void)updHealthInfoSelfNameWithSelfItemName:(NSArray*)selfItemNames childIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:selfItemNames forKey:@"selfItemName"];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/updHealthInfoSelfName",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updHealthInfoSelfNameSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updHealthInfoSelfNameFail" object:msg];
            
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

-(void)getDiseaseListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/getDiseaseList",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDiseaseListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDiseaseListFail" object:msg];
            
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

-(void)listDiseaseAllergySumWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listDiseaseAllergySum",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDiseaseAllergySumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDiseaseAllergySumFail" object:msg];
            
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

-(void)listDiseaseSumWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/listDiseaseSum",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDiseaseSumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDiseaseSumFail" object:msg];
            
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

-(void)saveDiseaseCommentWithDiseaseId:(NSString*)diseaseId commentDesc:(NSString*)commentDesc{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:diseaseId forKey:@"diseaseId"];
    [dic setObject:commentDesc forKey:@"commentDesc"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/saveDiseaseComment",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveDiseaseCommentSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveDiseaseCommentFail" object:msg];
            
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

-(void)saveDiseaseWithChildIdFamily:(NSString*)childIdFamily diseaseType:(NSString*)diseaseType diseaseDesc:(NSString*)diseaseDesc voiceUrl:(NSString*)voiceUrl videoUrl:(NSString*)videoUrl imageList:(NSArray*)imageList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:diseaseType forKey:@"diseaseType"];
    [dic setObject:diseaseDesc forKey:@"diseaseDesc"];
    [dic setObject:voiceUrl forKey:@"voiceUrl"];
    [dic setObject:videoUrl forKey:@"videoUrl"];
    [dic setObject:imageList forKey:@"imageList"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/saveDisease",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveDiseaseSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveDiseaseFail" object:msg];
            
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

-(void)saveHealthPlatformWithHealthId:(NSString*)healthId childIdFamily:(NSString*)childIdFamily historyDisease:(NSString*)historyDisease weight:(NSString*)weight weightComment:(NSString*)weightComment height:(NSString*)height heightComment:(NSString*)heightComment skin:(NSString*)skin eyesLeft:(NSString*)eyesLeft eyesRight:(NSString*)eyesRight sightLeft:(NSString*)sightLeft sightRight:(NSString*)sightRight sightComment:(NSString*)sightComment earLeft:(NSString*)earLeft earRight:(NSString*)earRight earComment:(NSString*)earComment teethTotal:(NSString*)teethTotal teethDisease:(NSString*)teethDisease head:(NSString*)head breast:(NSString*)breast backboneLimbs:(NSString*)backboneLimbs throat:(NSString*)throat heartLung:(NSString*)heartLung liverSpleen:(NSString*)liverSpleen externalGenitals:(NSString*)externalGenitals bodyOthers:(NSString*)bodyOthers hb:(NSString*)hb auxOthers:(NSString*)auxOthers alt:(NSString*)alt resultDesc:(NSString*)resultDesc doctorComment:(NSString*)doctorComment doctorName:(NSString*)doctorName diagnoseBy:(NSString*)diagnoseBy diagnoseDate:(NSString*)diagnoseDate{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dict setObject:dic forKey:@"healthPlatformItem"];
    if ([childIdFamily isKindOfClass:[NSString class]]) {
        [dic setObject:childIdFamily forKey:@"childIdFamily"];
    }
    if ([healthId isKindOfClass:[NSString class]]) {
        [dic setObject:healthId forKey:@"healthId"];
    }
    if ([historyDisease isKindOfClass:[NSString class]]) {
        [dic setObject:historyDisease forKey:@"historyDisease"];
    }
    if ([weight isKindOfClass:[NSString class]]) {
        [dic setObject:weight forKey:@"weight"];
    }
    if ([weightComment isKindOfClass:[NSString class]]) {
        [dic setObject:weightComment forKey:@"weightComment"];
    }
    if ([height isKindOfClass:[NSString class]]) {
        [dic setObject:height forKey:@"height"];
    }
    if ([heightComment isKindOfClass:[NSString class]]) {
        [dic setObject:heightComment forKey:@"heightComment"];
    }
    if ([skin isKindOfClass:[NSString class]]) {
        [dic setObject:skin forKey:@"skin"];
    }
    if ([eyesLeft isKindOfClass:[NSString class]]) {
        [dic setObject:eyesLeft forKey:@"eyesLeft"];
    }
    if ([eyesRight isKindOfClass:[NSString class]]) {
        [dic setObject:eyesRight forKey:@"eyesRight"];
    }
    if ([sightLeft isKindOfClass:[NSString class]]) {
        [dic setObject:sightLeft forKey:@"sightLeft"];
    }
    if ([sightRight isKindOfClass:[NSString class]]) {
        [dic setObject:sightRight forKey:@"sightRight"];
    }
    if ([sightComment isKindOfClass:[NSString class]]) {
        [dic setObject:sightComment forKey:@"sightComment"];
    }
    if ([earLeft isKindOfClass:[NSString class]]) {
        [dic setObject:earLeft forKey:@"earLeft"];
    }
    if ([earRight isKindOfClass:[NSString class]]) {
        [dic setObject:earRight forKey:@"earRight"];
    }
    if ([earComment isKindOfClass:[NSString class]]) {
        [dic setObject:earComment forKey:@"earComment"];
    }
    if ([teethTotal isKindOfClass:[NSString class]] && teethTotal.length > 0) {
        [dic setObject:teethTotal forKey:@"teethTotal"];
    }
    if ([teethDisease isKindOfClass:[NSString class]] && teethDisease.length > 0) {
        [dic setObject:teethDisease forKey:@"teethDisease"];
    }
    if ([head isKindOfClass:[NSString class]]) {
        [dic setObject:head forKey:@"head"];
    }
    if ([breast isKindOfClass:[NSString class]]) {
        [dic setObject:breast forKey:@"breast"];
    }
    if ([backboneLimbs isKindOfClass:[NSString class]]) {
        [dic setObject:backboneLimbs forKey:@"backboneLimbs"];
    }
    if ([throat isKindOfClass:[NSString class]]) {
        [dic setObject:throat forKey:@"throat"];
    }
    if ([heartLung isKindOfClass:[NSString class]]) {
        [dic setObject:heartLung forKey:@"heartLung"];
    }
    if ([liverSpleen isKindOfClass:[NSString class]]) {
        [dic setObject:liverSpleen forKey:@"liverSpleen"];
    }
    if ([externalGenitals isKindOfClass:[NSString class]]) {
        [dic setObject:externalGenitals forKey:@"externalGenitals"];
    }
    if ([bodyOthers isKindOfClass:[NSString class]]) {
        [dic setObject:bodyOthers forKey:@"bodyOthers"];
    }
    if ([hb isKindOfClass:[NSString class]]) {
        [dic setObject:hb forKey:@"hb"];
    }
    if ([auxOthers isKindOfClass:[NSString class]]) {
        [dic setObject:auxOthers forKey:@"auxOthers"];
    }
    if ([alt isKindOfClass:[NSString class]]) {
        [dic setObject:alt forKey:@"alt"];
    }
    if ([resultDesc isKindOfClass:[NSString class]]) {
        [dic setObject:resultDesc forKey:@"resultDesc"];
    }
    if ([doctorComment isKindOfClass:[NSString class]]) {
        [dic setObject:doctorComment forKey:@"doctorComment"];
    }
    if ([doctorName isKindOfClass:[NSString class]]) {
        [dic setObject:doctorName forKey:@"doctorName"];
    }
    if ([diagnoseBy isKindOfClass:[NSString class]]) {
        [dic setObject:diagnoseBy forKey:@"diagnoseBy"];
    }
    if ([diagnoseDate isKindOfClass:[NSString class]]) {
        [dic setObject:diagnoseDate forKey:@"diagnoseDate"];
    }
    NSDictionary *dic1 = [plistDataManager getDataWithKey:user_loginList];
    NSString *user_id = [dic1 objectForKey:@"userId"];
    [dic setObject:user_id forKey:@"createdBy"];
    
    dict = [networkDicHeader addHeaderDic:dict];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/health/saveHealthPlatform",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveHealthPlatformSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveHealthPlatformFail" object:msg];
            
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
