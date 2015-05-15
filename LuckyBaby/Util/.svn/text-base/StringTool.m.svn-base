//
//  StringTool.m
//  kugou
//
//  Created by hjh on 2011/6/23.
//  Copyright 2011年 hjh. All rights reserved.
//

#import "StringTool.h"


@implementation StringTool


//根据下载url提取后缀名
+(NSString*)getSongExtentionName:(NSString*)url
{
//    if (url) {
//        NSArray* subStrings = [url componentsSeparatedByString:@"."];
//        NSString* lastString = [subStrings lastObject];
//        return lastString;
//    }
    return @"mp3";
}


+ (NSData*) Unicode2GBK: (NSString*)srcContent
{
    NSString* unicodeStr = [NSString stringWithString: srcContent];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* retData = [unicodeStr dataUsingEncoding: enc];
    return retData;
}

+ (NSData*) GBK2Unicode: (NSString*)srcContent
{
    NSString* gbkStr = [NSString stringWithString: srcContent];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF16);
    NSData* retData = [gbkStr dataUsingEncoding: enc];
    return retData;
}

+ (NSString*) Unicode2GBKString: (NSString*)srcContent
{
    NSData* data = [StringTool Unicode2GBK: srcContent];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString* retStr = [[NSString alloc] initWithData: data encoding: enc];
    return retStr;
}

+ (NSString*) GBK2UnicodeString: (NSString*)srcContent
{
    NSData* data = [StringTool GBK2Unicode: srcContent];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF16);
    NSString* retStr = [[NSString alloc] initWithData: data encoding: enc];
    return retStr;
}
+(NSString*)ReToSQLStr:(NSString*)str
{
    if (str == nil)
    {
        return @"";
    }
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

@end


@implementation NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
	CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
											(CFStringRef)self,
											NULL,
	                                        CFSTR("!*'();:@&=+$,/?%#[] "),
											NSUTF8StringEncoding);
    return result;
}

- (NSString *)fitNSString
{
	return [self stringByReplacingOccurrencesOfString: @" " withString: @""];;
}

- (NSString *)gbEncoding
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *result = (NSString *)
	CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
											(CFStringRef)self,
											NULL,
	                                        CFSTR("!*'();:@&=+$,/?%#[] "),
											enc);
    
    NSString *ecodedContent = [NSString stringWithString: result];
    [result release];

    return ecodedContent;
}

- (NSString *)utf8Encoding
{
    NSString *result = (NSString *)
	CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
											(CFStringRef)self,
											NULL,
	                                        CFSTR("!*'();:@&=+$,/?%#[] "),
											kCFStringEncodingUTF8);
    
    NSString *ecodedContent = [NSString stringWithString: result];
    [result release];
    
    return ecodedContent;
}

- (NSString *)utf8EncodingWithoutSpace
{
    NSString *result = (NSString *)
	CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
											(CFStringRef)self,
											NULL,
	                                        CFSTR("!*'();:@&=+$,/?%#[]"),
											kCFStringEncodingUTF8);
    
    NSString *ecodedContent = [NSString stringWithString: result];
    [result release];
    
    return ecodedContent;
}

- (NSString *)flattenHtmlTrimWhiteSpace:(BOOL)trim
{
    if (!self) {
        return nil;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *str = [regex stringByReplacingMatchesInString:self
                                                    options:NSMatchingReportCompletion
                                                      range:NSMakeRange(0, self.length)
                                               withTemplate:@""];
    NSString *rlt = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return trim ? [rlt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : rlt;
}

- (NSString *)cutStringOfUrl{
    NSString* substringForMatch = nil;
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        substringForMatch = [self substringWithRange:match.range];
        NSLog(@"substringForMatch");
    }
    NSLog(@"%@",substringForMatch);
    return substringForMatch;
}

@end

@implementation NSObject (StringTool)


-(int)kgIntValue
{
    NSScanner* scan = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@",self]];
    int val;
    if ([scan scanInt:&val] && [scan isAtEnd])
    {
        return val;
    }
    return 0;
}




@end
