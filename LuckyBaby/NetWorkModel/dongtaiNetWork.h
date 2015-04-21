//
//  dongtaiNetWork.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dongtaiNetWork : NSObject
//获取宝宝列表
-(void)getBabyListWithRelativesId:(NSString*)relativesId;

//获取亲列表
-(void)getQinListWithRelativesId:(NSString*)relativesId childIdFamily:(NSString*)childIdFamily;

//修改亲信息
-(void)updateFollowWithRecId:(NSString*)recId relationsName:(NSString*)relationsName relativesNickname:(NSString*)relativesNickname relativesRole:(NSString*)relativesRole;

//删除亲信息
-(void)delFollowWithRecId:(NSString*)recId;

//设定默认的家庭幼儿
-(void)setDefaultChildFamilyWithChildIdFamily:(NSString*)childIdFamily childNicknameFamily:(NSString*)childNicknameFamily;

//查询相册汇总
-(void)getAllAlbumWithChildIdFamily:(NSString*)childIdFamily;

//查询年月相册列表
-(void)getAlbumListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page size:(NSString*)size;

//导入照片和视频
-(void)uploadMediaWithChildIdFamily:(NSString*)childIdFamily mediaType:(NSString*)mediaType mediaList:(NSArray*)mediaList;

//查询全部照片
-(void)getAllPhotosWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page size:(NSString*)size;

//获取邀请码
-(void)getInvitationCodeWithChildIdFamily:(NSString*)childIdFamily;

//宝宝详情
-(void)getBabyInfoWithChildIdFamily:(NSString*)childIdFamily;

//删除宝宝信息
-(void)delBabyInfoWithChildIdFamily:(NSString*)childIdFamily relativesId:(NSString*)relativesId;

//查询事件列表
-(void)getStoryListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize;

//查询宝宝第一次事件列表
-(void)getStoryFirstListWithChildIdFamily:(NSString*)childIdFamily page:(NSString*)page pageSize:(NSString*)pageSize;

//评论事件
-(void)saveStoryCommentWithStoryId:(NSString*)storyId commentDesc:(NSString*)commentDesc voiceUrl:(NSString*)voiceUrl;

//新增事件详情
-(void)saveStoryWithChildIdFamily:(NSString*)childIdFamily storyDesc:(NSString*)storyDesc voiceUrl:(NSString*)voiceUrl videoUrl:(NSString*)videoUrl firstType:(NSString*)firstType storyPlace:(NSString*)storyPlace publicRange:(NSString*)publicRange storyLatitude:(NSString*)storyLatitude storyLongitude:(NSString*)storyLongitude imageList:(NSArray *)imageList;
@end
