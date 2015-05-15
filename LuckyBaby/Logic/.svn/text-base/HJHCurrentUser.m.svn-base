//
//  HJHCurrentUser.m
//  youziyuan
//
//  Created by Dickson on 14-8-23.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "HJHCurrentUser.h"

@implementation HJHCurrentUser
@synthesize _userNickName1,_userId1,_userImage1,_userNickName2,_userId2,_userImage2,_userNickName3,_userId3,_userImage3,_userNickName4,_userId4,_userImage4,_userArray;

+ (HJHCurrentUser *)sharedManager
{
    static HJHCurrentUser *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(id)init{
    if (self = [super init]) {
        _userArray = [NSMutableArray array];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userId1 forKey:@"userId1"];
    [aCoder encodeObject:_userImage1 forKey:@"userImage1"];
    [aCoder encodeObject:_userNickName1 forKey:@"userNickName1"];
    [aCoder encodeObject:_userId2 forKey:@"userId2"];
    [aCoder encodeObject:_userImage2 forKey:@"userImage2"];
    [aCoder encodeObject:_userNickName2 forKey:@"userNickName2"];
    [aCoder encodeObject:_userId3 forKey:@"userId3"];
    [aCoder encodeObject:_userImage3 forKey:@"userImage3"];
    [aCoder encodeObject:_userNickName3 forKey:@"userNickName3"];
    [aCoder encodeObject:_userId4 forKey:@"userId4"];
    [aCoder encodeObject:_userImage4 forKey:@"userImage4"];
    [aCoder encodeObject:_userNickName4 forKey:@"userNickName4"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _userId1 = [aDecoder decodeObjectForKey:@"userId1"];
        _userImage1 = [aDecoder decodeObjectForKey:@"userImage1"];
        _userNickName1 = [aDecoder decodeObjectForKey:@"userNickName1"];
        _userId2 = [aDecoder decodeObjectForKey:@"userId2"];
        _userImage2 = [aDecoder decodeObjectForKey:@"userImage2"];
        _userNickName2 = [aDecoder decodeObjectForKey:@"userNickName2"];
        _userId3 = [aDecoder decodeObjectForKey:@"userId3"];
        _userImage3 = [aDecoder decodeObjectForKey:@"userImage3"];
        _userNickName3 = [aDecoder decodeObjectForKey:@"userNickName3"];
        _userId4 = [aDecoder decodeObjectForKey:@"userId4"];
        _userImage4 = [aDecoder decodeObjectForKey:@"userImage4"];
        _userNickName4 = [aDecoder decodeObjectForKey:@"userNickName4"];
    }
    return self;
}
@end
