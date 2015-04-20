//
//  youErYuanNetWork.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-6.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface youErYuanNetWork : NSObject
//校验是否开通幼儿园服务
-(void)withoutBindWithUserName:(NSString*)userName;

//查询通知通告列表
-(void)getPlatformInformsWithchildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId platformId:(NSString*)platformId semesterId:(NSString*)semesterId page:(NSString*)page pageSize:(NSString*)pageSize;

//查询当前班级信息（含学期）
-(void)getFamilyAddressCoordinateWithChildIdPlatform:(NSString*)childIdPlatform;

//查询食物档案
-(void)getMealSchedulePlatformWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString *)dateStart dateEnd:(NSString*)dateEnd;

//查询学校周课表
-(void)getCourseSchedulePlatformWeekWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId;

//查询通知通告详情
-(void)getplatforminformDetailWithInfoId:(NSString*)infoId;

//获取班级圈列表
-(void)getCircleListWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId page:(NSString*)page pageSize:(NSString*)pageSize;

//点赞和回复
-(void)praiseAndReplyWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId parentId:(NSString*)parentId type:(NSString*)type content:(NSString*)content;

//获取学期异常出勤安排的日期
-(void)getSemesterExceptionWithPlatformId:(NSString*)platformId semesterId:(NSString*)semesterId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd;

//获取幼儿晨检数据
-(void)getDutyInspectionWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd;

//列表查询请假
-(void)listDutyOffApplyWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize;

//新增请假
-(void)newDutyOffApplyWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId dateStart:(NSString*)dateStart dateEnd:(NSString*)dateEnd offReason:(NSString*)offReason offType:(NSString*)offType relativesId:(NSString*)relativesId childNamePlatform:(NSString*)childNamePlatform;

//删除请假
-(void)delDutyOffApplyWithApplyId:(NSString*)applyId;

//列表查询重点观察
-(void)listCareWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize;

//新增重点观察
-(void)newCareWithChildIdPlatform:(NSString*)childIdPlatform careDate:(NSString*)careDate careDesc:(NSString*)careDesc relativesId:(NSString*)relativesId childNamePlatform:(NSString*)childNamePlatform classId:(NSString*)classId;

//删除重点观察
-(void)declareWithCareId:(NSString*)careId;

//列表查询委托用药
-(void)listMedicineWithChildIdPlatform:(NSString*)childIdPlatform classId:(NSString*)classId page:(NSString*)page pageSize:(NSString*)pageSize;

//新增委托用药
-(void)newMedicineWithChildIdPlatform:(NSString*)childIdPlatform takeDate:(NSString*)takeDate medicineName:(NSString*)medicineName takeQty:(NSString*)takeQty takeDesc:(NSString*)takeDesc relativesId:(NSString*)relativesId alertTime1:(NSString*)alertTime1 alertTime2:(NSString*)alertTime2 alertTime3:(NSString*)alertTime3 childNamePlatform:(NSString*)childNamePlatform classId:(NSString*)classId className:(NSString*)className;

//删除重点观察
-(void)delMedicineWithMedicineId:(NSString*)medicineId;

//获取评价列表
-(void)getScoreInfoWithClassId:(NSString*)classId semesterId:(NSString*)semesterId platformId:(NSString*)platformId childIdPlatform:(NSString*)childIdPlatform weekIndex:(NSString*)weekIndex;
@end
