//
//  DictionaryStringTool.m
//  huang
//
//  Created by AA on 14-1-9.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "DictionaryStringTool.h"

@implementation DictionaryStringTool

+ (id)stringFromDictionary:(NSDictionary *)dic forKey:(NSString *)key
{
    id value = [dic valueForKey:key];
    if (!value) {
        return nil;
    }else if ([value isKindOfClass:[NSString class]]) {
        return value;
    }else if([value isKindOfClass:[NSNull class]]){
        return nil;
    }else if([value isKindOfClass:[NSDictionary class]]){
        return value;
    }else if([value isKindOfClass:[NSArray class]]){
        return value;
    }else{
        return [NSString stringWithFormat:@"%@", value];
    }
}

-(id)objectForKey:(id)aKey{
    id value = [self valueForKey:aKey];
    if (!value) {
        return nil;
    }else if ([value isKindOfClass:[NSString class]]) {
        return value;
    }else if([value isKindOfClass:[NSNull class]]){
        return nil;
    }else if([value isKindOfClass:[NSDictionary class]]){
        return value;
    }else if([value isKindOfClass:[NSArray class]]){
        return value;
    }else{
        return [NSString stringWithFormat:@"%@", value];
    }
}

+(NSMutableDictionary*)changeDictionaryTyle:(NSDictionary*)dic{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < dic.allKeys.count; i++) {
        id sDic = [dic objectForKey:[dic.allKeys objectAtIndex:i]];
        NSString *string = [NSString stringWithFormat:@"%@",sDic];
        if ([string isKindOfClass:[NSNull class]]) {
            string = @"";
        }
        if (!(string.length > 0)) {
            string = @"";
        }
        if([string isEqualToString:@"<null>"]){
            string = @"";
        }
        [dict setObject:string forKey:[dic.allKeys objectAtIndex:i]];
    }
    return dict;
}
@end
