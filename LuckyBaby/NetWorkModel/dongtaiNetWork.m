//
//  dongtaiNetWork.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "dongtaiNetWork.h"

@interface dongtaiNetWork ()
@property(nonatomic,strong)KGTipView *tipView;
@end

@implementation dongtaiNetWork
-(void)getBabyListWithRelativesId:(NSString*)relativesId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:relativesId forKey:@"relativesId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getBabyList",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getBabyListSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getBabyListFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)getQinListWithRelativesId:(NSString*)relativesId childIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:relativesId forKey:@"relativesId"];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/followList",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getQinListSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getQinListFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)updateFollowWithRecId:(NSString*)recId relationsName:(NSString*)relationsName relativesNickname:(NSString*)relativesNickname relativesRole:(NSString*)relativesRole{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:recId forKey:@"recId"];
    [dic setObject:relationsName forKey:@"relationsName"];
    [dic setObject:relativesNickname forKey:@"relativesNickname"];
    if (relativesRole.length > 0) {
        [dic setObject:relativesRole forKey:@"relativesRole"];
    }
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/updateFollow",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateFollowSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateFollowFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)delFollowWithRecId:(NSString*)recId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:recId forKey:@"recId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/delFollow",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delFollowSuccess" object:responseObject];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delFollowFail" object:msg];
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)setDefaultChildFamilyWithChildIdFamily:(NSString*)childIdFamily childNicknameFamily:(NSString*)childNicknameFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:childNicknameFamily forKey:@"childNicknameFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/relatives/setDefaultChildFamily",serverAPIAddress];
    
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
            //改plist的值childIdFamily和childNicknameFamily
            NSDictionary *dic = [plistDataManager getDataWithKey:user_loginList];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [dict setObject:childIdFamily forKey:@"childIdFamilyCurrent"];
            [dict setObject:childNicknameFamily forKey:@"childNicknameFamilyCurrent"];
            NSMutableDictionary *dictData = [NSMutableDictionary dictionary];
            [dictData setObject:dict forKey:@"data"];
            
            [plistDataManager writeData:dictData withKey:user_loginList];
            
            NSDictionary *dic2 = [plistDataManager getDataWithKey:user_loginList];
            NSLog(@"%@",dic2);
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setDefaultChildFamilySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setDefaultChildFamilyFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)getAllAlbumWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getAllAlbum",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAllAlbumSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAllAlbumFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)getAlbumListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page size:(NSString*)size{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:size forKey:@"size"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getAlbumList",serverAPIAddress];
    
//    self.tipView = [[KGTipView alloc]initWithTitle:@"" context:@"数据加载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
//    [self.tipView showWithLoading];
    
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
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)getAllPhotosWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page size:(NSString*)size{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:size forKey:@"size"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getAllPhotos",serverAPIAddress];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAllPhotosSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAllPhotosFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"加载失败" duration:0.8];
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

-(void)uploadMediaWithChildIdFamily:(NSString*)childIdFamily mediaType:(NSString*)mediaType mediaList:(NSArray*)mediaList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:mediaType forKey:@"mediaType"];
    [dic setObject:mediaList forKey:@"mediaList"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/uploadMedia",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadMediaSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadMediaFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)getInvitationCodeWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getInvitationCode",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInvitationSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getInvitationFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)getBabyInfoWithChildIdFamily:(NSString*)childIdFamily{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/getBabyInfo",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getBabyInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getBabyInfoFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)delBabyInfoWithChildIdFamily:(NSString*)childIdFamily relativesId:(NSString*)relativesId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:relativesId forKey:@"relativesId"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/baby/delBabyInfo",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delBabyInfoSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"delBabyInfoFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)getStoryListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/story/getStoryList",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getStoryListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getStoryListFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)getStoryFirstListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/story/getStoryFirstList",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getStoryFirstListSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getStoryFirstListFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)saveStoryCommentWithStoryId:(NSString*)storyId commentDesc:(NSString*)commentDesc voiceUrl:(NSString*)voiceUrl{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:storyId forKey:@"storyId"];
    [dic setObject:commentDesc forKey:@"commentDesc"];
    [dic setObject:voiceUrl forKey:@"voiceUrl"];
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/story/saveStoryComment",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveStoryCommentSuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveStoryCommentFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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

-(void)saveStoryWithChildIdFamily:(NSString*)childIdFamily storyDesc:(NSString*)storyDesc voiceUrl:(NSString*)voiceUrl videoUrl:(NSString*)videoUrl firstType:(NSString*)firstType storyPlace:(NSString*)storyPlace publicRange:(NSString*)publicRange storyLatitude:(NSString*)storyLatitude storyLongitude:(NSString*)storyLongitude imageList:(NSArray *)imageList{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:childIdFamily forKey:@"childIdFamily"];
    [dic setObject:storyDesc forKey:@"storyDesc"];
    if (voiceUrl.length > 0) {
        [dic setObject:voiceUrl forKey:@"voiceUrl"];
    }
    
    if (videoUrl.length > 0) {
        [dic setObject:videoUrl forKey:@"videoUrl"];
    }
    
    [dic setObject:firstType forKey:@"firstType"];
    [dic setObject:storyPlace forKey:@"storyPlace"];
    [dic setObject:publicRange forKey:@"publicRange"];
    [dic setObject:storyLatitude forKey:@"storyLatitude"];
    if (imageList.count > 0) {
        [dic setObject:imageList forKey:@"imageList"];
    }
    
    dic = [networkDicHeader addHeaderDic:dic];
    NSString *urlString = [NSString stringWithFormat:@"%@/school/story/saveStory",serverAPIAddress];
    
    self.tipView = [[KGTipView alloc]initWithTitle:nil context:@"数据下载中..." cancelButtonTitle:nil otherCancelButton:nil lockType:LockTypeGlobal delegate:nil userInfo:nil];
    [self.tipView showWithLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        NSLog(@"%@",responseObject);
        NSString *flag = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveStorySuccess" object:responseObject];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载完成" duration:0.8];
        }
        else{
            NSString *msg = [DictionaryStringTool stringFromDictionary:responseObject forKey:@"msg"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"saveStoryFail" object:msg];
            
            [self.tipView stopLoadingAnimationWithTitle:@"" context:@"下载失败" duration:0.8];
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
