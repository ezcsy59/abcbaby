//
//  networkDicHeader.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-31.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "networkDicHeader.h"

@implementation networkDicHeader
+(NSMutableDictionary*)addHeaderDic:(NSMutableDictionary*)dic{
    NSString *device_id = [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    [dic setObject:device_id forKey:@"deviceId"];
    NSDictionary *dic1 = [plistDataManager getDataWithKey:user_loginList];
    NSString *user_id = [dic1 objectForKey:@"userId"];
    NSString *user_token = [dic1 objectForKey:@"token"];
    [dic setObject:user_id forKey:@"userId"];
    [dic setObject:user_token forKey:@"token"];
    return dic;
}
@end
