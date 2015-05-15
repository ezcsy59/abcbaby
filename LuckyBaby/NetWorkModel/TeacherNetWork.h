//
//  TeacherNetWork.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherNetWork : NSObject
//用户登录
-(void)TeacherLogin;
//查询通知通告
-(void)getPlatformInformsWithTeacherId:(NSString*)teacherId classId:(NSString*)classId deptId:(NSString*)deptId platformId:(NSString*)platformId appType:(NSString*)appType page:(NSString*)page pageSize:(NSString*)pageSize;
//查询通知通告详情
-(void)getplatforminformDetailWithInfoId:(NSString *)infoId;
//查询出勤和晨检报告（全校）
-(void)getInspectionDailyPlatformWithMsgDate:(NSString *)msgDate platformId:(NSString*)platformId;
//查询班级出勤和考勤列表
-(void)listDutyInspectionClassWithGradeWithMsgDate:(NSString *)msgDate platformId:(NSString*)platformId;
//查询班级幼儿出勤和晨检列表
-(void)listClassChildDutyInspWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId;
//查询出勤和晨检报告（班级）
-(void)getInspectionDailyClassWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId;
//查询委托服药列表
-(void)listChildMedicineDelegateWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId platformId:(NSString*)platformId;
//查询请假消息列表
-(void)listChildOffApplyWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId;
//重点观察
-(void)listChildCareWithGradeWithMsgDate:(NSString *)msgDate classId:(NSString*)classId;
//批准请假
-(void)approveChildOffApplyWithGradeWithMsgDate:(NSString *)msgDate applyId:(NSString*)applyId;
//发布通知公告
-(void)savePlatformInformWithGradeWithInfoTitle:(NSString *)infoTitle infoContent:(NSString*)infoContent dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd semesterId:(NSString*)semesterId publicClass:(NSString*)publicClass publicClassNames:(NSString*)publicClassNames publicDept:(NSString*)publicDept publicDeptNames:(NSString*)publicDeptNames platformId:(NSString*)platformId;
//查询班级连续几周的出勤和考勤列表
-(void)listDutyInspectionClassWeekWithInspDateStart:(NSString*)inspDateStart inspDateEnd:(NSString*)inspDateEnd platformId:(NSString*)platformId;
//部门列表
-(void)listDeptWithGradeWithTeacherId:(NSString *)teacherId platformId:(NSString*)platformId appType:(NSString*)appType;
//班级列表
-(void)listClassWithGradeWithTeacherId:(NSString *)teacherId platformId:(NSString*)platformId appType:(NSString*)appType semesterId:(NSString*)semesterId;
//查询班级相册
-(void)getAlbumListWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId;
//添加班级相册
-(void)saveAlbumClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumName:(NSString*)albumName albumId:(NSString*)albumId;
//删除班级相册
-(void)delAlbumWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumId:(NSString*)albumId;
//查询班级相册照片或视频
-(void)getAlbumPhotoListWithAlbumId:(NSString*)albumId ClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId;
//删除班级相册照片或视频
-(void)delMediaWithClassId:(NSString*)classId SemesterId:(NSString *)semesterId platformId:(NSString*)platformId userId:(NSString*)userId albumId:(NSString*)albumId photoCount:(NSString*)photoCount videoCount:(NSString*)videoCount mediaIdList:(NSString*)mediaIdList;
//获取学期的基本信息
-(void)getCurrentSemesterWithPlatformId:(NSString*)platformId;
//查询教师列表
-(void)listTeacherContactInfoWithPlatformId:(NSString *)platformId;
//查询班级幼儿列表
-(void)listChildContactInfoWithClassId:(NSString *)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId;
//获取学期异常出勤安排的日期
-(void)getSemesterExceptionWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd;
//获取班级的幼儿晨检汇总数据
-(void)getDutyInspectionClassWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd;
//列表查询班级内学生
-(void)listClassChildWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId scoreType:(NSString*)scoreType weekIndex:(NSString*)weekIndex monthName:(NSString*)monthName;
//保存月评价
-(void)saveScoreMonthWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId monthName:(NSString*)monthName teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList;
//保存周评价
-(void)saveScoreWeekWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId weekIndex:(NSString*)weekIndex teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList scoreList:(NSString*)scoreList dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd;
//保存学期评价
-(void)saveScoreSemesterWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId classId:(NSString*)classId teacherId:(NSString*)teacherId scoreDesc:(NSString*)scoreDesc childIdList:(NSString*)childIdList childNameList:(NSString*)childNameList;
@end
