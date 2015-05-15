//
//  TeacherNetWork.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "TeacherNetWork.h"

@interface TeacherNetWork ()
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation TeacherNetWork
-(void)TeacherLogin{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *passwd = @"123456";
    passwd = [MyMD5 md5WithString:passwd];
    
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    NSDictionary *diction = [plistDataManager getDataWithKey:user_loginList];
    [dic setObject:[DictionaryStringTool stringFromDictionary:diction forKey:@"userName"] forKey:@"userName"];
    [dic setObject:[DictionaryStringTool stringFromDictionary:diction forKey:@"passwd"] forKey:@"passwd"];
//    [dic setObject:passwd forKey:@"passwd"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/login",serverAPIAddress];
    
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
            [plistDataManager writeData:responseObject withKey:teacher_loginList];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"teacherLoginSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"teacherLoginFail" object:msg];
            
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

-(void)getPlatformInformsWithTeacherId:(NSString*)teacherId classId:(NSString*)classId deptId:(NSString*)deptId platformId:(NSString*)platformId appType:(NSString*)appType page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:deptId forKey:@"deptId"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:appType forKey:@"appType"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/getPlatformInforms",serverAPIAddress];
    
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
            [plistDataManager writeData:responseObject withKey:teacher_loginList];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getPlatformInformsSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getPlatformInformsFail" object:msg];
            
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

-(void)getplatforminformDetailWithInfoId:(NSString *)infoId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:infoId forKey:@"infoId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/getPlatformInformDetail",serverAPIAddress];
    
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
        [self.tipView stopLoadingAnimationWithTitle:@"" context:@"" duration:0];
        self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"网络链接失败" cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:self userInfo:nil];
        [self.tipView show];
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
        NSLog(@"%@",error);
        NSLog(@"%@",operation);
    }];
}

-(void)getInspectionDailyPlatformWithMsgDate:(NSString *)msgDate platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/getInspectionDailyPlatform",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInspectionDailyPlatformSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInspectionDailyPlatformFail" object:msg];
            
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

-(void)listDutyInspectionClassWithGradeWithMsgDate:(NSString *)msgDate platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/listDutyInspectionClassWithGrade",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyInspectionClassWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyInspectionClassWithGradeFail" object:msg];
            
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

-(void)listChildMedicineDelegateWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/listChildMedicineDelegate",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildMedicineDelegateWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildMedicineDelegateWithGradeFail" object:msg];
            
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

-(void)listClassChildDutyInspWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/listClassChildDutyInsp",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassChildDutyInspWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassChildDutyInspWithGradeFail" object:msg];
            
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

-(void)getInspectionDailyClassWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/getInspectionDailyClass",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInspectionDailyClassWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInspectionDailyClassWithGradeFail" object:msg];
            
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

-(void)listChildOffApplyWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/listChildOffApply",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildOffApplyWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildOffApplyWithGradeFail" object:msg];
            
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

-(void)listChildCareWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/listChildCare",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildCareWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildCareWithGradeFail" object:msg];
            
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

-(void)approveChildOffApplyWithGradeWithMsgDate:(NSString *)msgDate applyId:(NSString*)applyId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:msgDate forKey:@"msgDate"];
    [dic setObject:applyId forKey:@"applyId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/approveChildOffApply",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"approveChildOffApplyWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"approveChildOffApplyWithGradeFail" object:msg];
            
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

-(void)savePlatformInformWithGradeWithInfoTitle:(NSString *)infoTitle infoContent:(NSString*)infoContent dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd semesterId:(NSString*)semesterId publicClass:(NSString*)publicClass publicClassNames:(NSString*)publicClassNames publicDept:(NSString*)publicDept publicDeptNames:(NSString*)publicDeptNames platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dic setObject:dict forKey:@"bean"];
    [dict setObject:infoTitle forKey:@"infoTitle"];
    [dict setObject:infoContent forKey:@"infoContent"];
    [dict setObject:dateStart forKey:@"dateStart"];
    [dict setObject:dateEnd forKey:@"dateEnd"];
    [dict setObject:semesterId forKey:@"semesterId"];
    if(publicClassNames.length > 0){
        [dict setObject:publicClass forKey:@"publicClass"];
        [dict setObject:publicClassNames forKey:@"publicClassNames"];
        
    }
    if (publicDeptNames.length > 0) {
        [dict setObject:publicDept forKey:@"publicDept"];
        [dict setObject:publicDeptNames forKey:@"publicDeptNames"];
    }
    [dict setObject:platformId forKeyedSubscript:@"platformId"];
    
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    
    NSDictionary *dictt = [plistDataManager getDataWithKey:teacher_loginList];
    [dict setObject:[DictionaryStringTool stringFromDictionary:dictt forKey:@"userId"] forKey:@"createdBy"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/savePlatformInform",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"savePlatformInformSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"savePlatformInformWithGradeFail" object:msg];
            
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

-(void)listDeptWithGradeWithTeacherId:(NSString *)teacherId platformId:(NSString*)platformId appType:(NSString*)appType{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:appType forKey:@"appType"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/message/listDept",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDeptWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDeptWithGradeFail" object:msg];
            
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

-(void)listClassWithGradeWithTeacherId:(NSString *)teacherId platformId:(NSString*)platformId appType:(NSString*)appType semesterId:(NSString*)semesterId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:appType forKey:@"appType"];
    [dic setObject:appType forKey:@"semesterId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/listClass",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassWithGradeFail" object:msg];
            
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

-(void)listTeacherContactInfoWithPlatformId:(NSString *)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/assist/listTeacherContactInfo",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listTeacherContactInfoWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listTeacherContactInfoWithGradeFail" object:msg];
            
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

-(void)listChildContactInfoWithClassId:(NSString *)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/assist/listChildContactInfo",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildContactInfoWithGradeSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listChildContactInfoWithGradeFail" object:msg];
            
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

-(void)getAlbumListWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/getAlbumList",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAlbumListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAlbumListFail" object:msg];
            
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

-(void)saveAlbumClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumName:(NSString*)albumName albumId:(NSString*)albumId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:albumName forKey:@"albumName"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    if (albumId.length > 0) {
        [dic setObject:albumId forKeyedSubscript:@"albumId"];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/saveAlbum",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addSaveAlbumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addSaveAlbumFail" object:msg];
            
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

-(void)delAlbumWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumId:(NSString*)albumId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    if (albumId.length > 0) {
        [dic setObject:albumId forKeyedSubscript:@"albumId"];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/delAlbum",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delAlbumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delAlbumFail" object:msg];
            
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

-(void)delMediaWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumId:(NSString*)albumId photoCount:(NSString*)photoCount videoCount:(NSString*)videoCount mediaIdList:(NSString*)mediaIdList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:photoCount forKey:@"photoCount"];
    [dic setObject:videoCount forKey:@"videoCount"];
    [dic setObject:mediaIdList forKey:@"mediaIdList"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    if (albumId.length > 0) {
        [dic setObject:albumId forKeyedSubscript:@"albumId"];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/delMedia",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delMediaSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delMediaFail" object:msg];
            
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

-(void)getAlbumPhotoListWithAlbumId:(NSString*)albumId ClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:albumId forKey:@"albumId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/class/getAlbumPhotoList",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAlbumPhotoListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAlbumPhotoListFail" object:msg];
            
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

-(void)getCurrentSemesterWithPlatformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/semester/getCurrentSemester",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCurrentSemesterListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getCurrentSemesterFail" object:msg];
            
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

-(void)listDutyInspectionClassWeekWithInspDateStart:(NSString*)inspDateStart inspDateEnd:(NSString*)inspDateEnd platformId:(NSString*)platformId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:inspDateStart forKey:@"inspDateStart"];
    [dic setObject:inspDateEnd forKey:@"inspDateEnd"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/listDutyInspectionClassWeek",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyInspectionClassWeekSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listDutyInspectionClassWeekFail" object:msg];
            
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

-(void)getSemesterExceptionWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:dateStart forKey:@"dateStart"];
    [dic setObject:dateEnd forKey:@"dateEnd"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getSemesterExceptionWeekFail" object:msg];
            
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

-(void)getDutyInspectionClassWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:dateStart forKey:@"dateStart"];
    [dic setObject:dateEnd forKey:@"dateEnd"];
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/getDutyInspectionClass",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDutyInspectionClassSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getDutyInspectionClassFail" object:msg];
            
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

-(void)listClassChildWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId scoreType:(NSString*)scoreType weekIndex:(NSString*)weekIndex monthName:(NSString*)monthName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:scoreType forKey:@"scoreType"];
    if (weekIndex.length > 0) {
        [dic setObject:weekIndex forKey:@"weekIndex"];
    }
    if (monthName.length > 0) {
        [dic setObject:monthName forKeyedSubscript:@"monthName"];
    }
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/listClassChild",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassChildSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"listClassChildFail" object:msg];
            
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

-(void)saveScoreMonthWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId monthName:(NSString*)monthName teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:monthName forKey:@"monthName"];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:scoreDesc forKey:@"scoreDesc"];
    [dic setObject:childIdList forKey:@"childIdList"];
    [dic setObject:childNameList forKey:@"childNameList"];
    
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/saveScoreMonth",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreMonthSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreMonthFail" object:msg];
            
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

-(void)saveScoreWeekWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId weekIndex:(NSString*)weekIndex teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList scoreList:(NSString*)scoreList dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:weekIndex forKey:@"weekIndex"];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:scoreDesc forKey:@"scoreDesc"];
    [dic setObject:childIdList forKey:@"childIdList"];
    [dic setObject:childNameList forKey:@"childNameList"];
    [dic setObject:scoreList forKey:@"scoreList"];
    [dic setObject:dateStart forKey:@"dateStart"];
    [dic setObject:dateEnd forKey:@"dateEnd"];
    
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/saveScoreWeek",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreWeekSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreWeekFail" object:msg];
            
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

-(void)saveScoreSemesterWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:classId forKey:@"classId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:platformId forKey:@"platformId"];
    [dic setObject:teacherId forKey:@"teacherId"];
    [dic setObject:semesterId forKey:@"semesterId"];
    [dic setObject:scoreDesc forKey:@"scoreDesc"];
    [dic setObject:childIdList forKey:@"childIdList"];
    [dic setObject:childNameList forKey:@"childNameList"];
    
    [dic setObject:device_id forKeyedSubscript:@"deviceId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/teacher/class/saveScoreSemester",serverAPIAddress];
    
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
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreSemesterSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveScoreSemesterFail" object:msg];
            
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
