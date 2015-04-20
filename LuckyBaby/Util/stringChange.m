//
//  stringChange.m
//  TalkBar
//
//  Created by huang on 11/7/13.
//  Copyright (c) 2013 dengyilei. All rights reserved.
//

#import "stringChange.h"

@implementation stringChange
+(CGFloat)makeStringWedth:(NSString*)str andSize:(CGFloat)size andLenth:(float)oldwedth{
    CGFloat wedth;
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 30);
    CGSize size2 = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    if (size2.width > oldwedth) {
        wedth = oldwedth;
    }else{
        wedth = size2.width;
    }
    return wedth;
}

+(CGFloat)makeStringHeight:(NSString*)str andSize:(CGFloat)size andLenth:(float)oldwedth fixwidth:(float)fixwidth{
    
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 30);
    CGSize size2 = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float numberOfLine = (size2.width + fixwidth)/oldwedth;
    NSLog(@"%f",numberOfLine);
    int line = numberOfLine + 1;
    NSLog(@"%d",line);
    if (line - 1 == numberOfLine) {
        NSLog(@"相等");
        line = numberOfLine;
    }
    CGFloat height = size2.height * line;
    return height;
}


+(CGFloat)makeStringHeight:(NSString*)str andSize:(CGFloat)size andLenth:(float)oldwedth{
    
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 30);
    CGSize size2 = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float numberOfLine = size2.width/oldwedth;
    NSLog(@"%f",numberOfLine);
    int line = numberOfLine + 1;
    NSLog(@"%d",line);
    if (line - 1 == numberOfLine) {
        NSLog(@"相等");
        line = numberOfLine;
    }
    CGFloat height = size2.height * line;
    return height;
}

+(CGFloat)makeStringMaxWidth:(NSString*)str andSize:(CGFloat)size andLenth:(float)lenth{
    CGFloat width;
    if (str.length > lenth) {
        str = [str substringToIndex:lenth];
    }
    NSLog(@"%@",str);
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 30);
    CGSize size2 = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    width = size2.width;
    return width;
}

+(int)makeStringLine:(NSString*)str andSize:(CGFloat)size andwedth:(float)oldwedth{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 30);
    CGSize size2 = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    float numberOfLine = size2.width/oldwedth;
    NSLog(@"%f",numberOfLine);
    int line = numberOfLine + 1;
    NSLog(@"%d",line);
    if (line - 1 == numberOfLine) {
        NSLog(@"相等");
        line = numberOfLine;
    }
    return line;
}

+(NSMutableArray*)subStringToArray:(NSString*)stringH :(NSString*)stringE{
    NSMutableArray *array = [NSMutableArray array];
    int location = 0;
    int lenth = 0;
    if (stringE.length > 0 && stringH.length > 0) {
        NSLog(@"%d",stringE.length);
        NSLog(@"%d",stringE.length);
        if (stringE.length < stringH.length) {
            lenth = stringE.length;
        }else{
            lenth = stringH.length;
        }
        for (int i = 0; i<lenth; i++) {
            NSString *subStringE = [stringE substringToIndex:1];
            NSString *subStringH = [stringH substringToIndex:1];
            [stringH substringFromIndex:1];
            [stringE substringFromIndex:1];
            if ([subStringE isEqualToString:subStringH]) {
                continue;
            }else{
                location = i;
                break;
            }
        }
    }
    [array addObject:[stringE substringToIndex:location]];
    [array addObject:[stringE substringFromIndex:location]];
    [array addObject:[stringH substringFromIndex:location]];
    NSLog(@"+_+_%@",array);
    return array;
}
@end
