//
//  StringTool.h
//  字符串相关功能
//
//  Created by hjh on 2011/6/23.
//  Copyright 2011年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StringTool : NSObject 
{
   
}

+ (NSData*) Unicode2GBK: (NSString*)srcContent;
+ (NSData*) GBK2Unicode: (NSString*)srcContent;
// 由外界释放返回的字符串
+ (NSString*) Unicode2GBKString: (NSString*)srcContent;
// 由外界释放返回的字符串
+ (NSString*) GBK2UnicodeString: (NSString*)srcContent;

+(NSString*)ReToSQLStr:(NSString*)str;

//根据下载url提取后缀名
+(NSString*)getSongExtentionName:(NSString*)url;

@end

@interface NSString (URLEncodingAdditions)
- (NSString *)URLEncodedString;
- (NSString *)gbEncoding;
- (NSString *)utf8Encoding;
- (NSString *)utf8EncodingWithoutSpace;
- (NSString *)fitNSString;
- (NSString *)flattenHtmlTrimWhiteSpace:(BOOL)trim;
- (NSString *)cutStringOfUrl;

@end

@interface NSObject (StringTool)


-(int)kgIntValue;
@end
