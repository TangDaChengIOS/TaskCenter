//
//  TaskDetailModel.h
//  TaskCenter
//
//  Created by 汤达成 on 18/2/6.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailModel : NSObject

@property (nonatomic,copy) NSString * auditStatus;//审核状态0:待审核；1:审核通过；2:审核不通过
@property (nonatomic,copy) NSString * awardCamp;//发包方公司
@property (nonatomic,copy) NSString * beginDate;//任务开始时间
@property (nonatomic,copy) NSString * callEndBonus;//接通酬金
@property (nonatomic,copy) NSString * campaignId;//
@property (nonatomic,copy) NSString * campaignName;//
@property (nonatomic,copy) NSString * channelId;//
@property (nonatomic,copy) NSString * connectBonus;//拨打酬金
@property (nonatomic,copy) NSString * contactNum;//
@property (nonatomic,copy) NSString * descript;//
@property (nonatomic,copy) NSString * endDate;//任务结束时间
@property (nonatomic,copy) NSString * execuCamps;//
@property (nonatomic,copy) NSString * handleWay;//
@property (nonatomic,copy) NSString * highestBonus;//最高酬金
@property (nonatomic,copy) NSString * isGrab;//
@property (nonatomic,copy) NSString * ivrFlag;//是否支持转IVR语音确认
@property (nonatomic,copy) NSString * languageId;//
@property (nonatomic,copy) NSString * operationId;//基础类型	1：营销；2：推销；3：回访；4：催缴；5：调查；6：关怀；7：其他
@property (nonatomic,copy) NSString * operationId_des;//基础类型	1：营销；2：推销；3：回访；4：催缴；5：调查；6：关怀；7：其他

@property (nonatomic,copy) NSString * operationSubId;//扩展业务类型
@property (nonatomic,copy) NSString * orderWay;//任务分配方式
@property (nonatomic,copy) NSString * paySuccessBonus;//付款成功酬金
@property (nonatomic,copy) NSString * personnelNum;//
@property (nonatomic,copy) NSString * provinceId;//
@property (nonatomic,copy) NSString * pushOrderBonus;//下单酬金
@property (nonatomic,copy) NSString * qualificationPeriod;//
@property (nonatomic,copy) NSString * regionId;//
@property (nonatomic,copy) NSString * releaseTime;//
@property (nonatomic,copy) NSString * sampleCount;//样本总数
@property (nonatomic,copy) NSString * sampleDone;//
@property (nonatomic,copy) NSString * skillDesc;//
@property (nonatomic,copy) NSString * skillQueueId;//
@property (nonatomic,copy) NSString * staffId;//
@property (nonatomic,copy) NSString * staffName;//
@property (nonatomic,copy) NSString * starLevelId;//任务星级要求
@property (nonatomic,copy) NSString * state;//任务状态	01：策划；04：执行中；05：暂停；06：完成；07：过期;
@property (nonatomic,copy) NSString * stopDateTime;//
@property (nonatomic,copy) NSString * strategyDesignType;//外呼类型	渠道类型，1：人工外呼；2：预测外呼;
@property (nonatomic,copy) NSString * subccNo;//
@property (nonatomic,copy) NSString * succeedNum;//
@property (nonatomic,copy) NSString * surveyBonus;//问卷调研酬金
@property (nonatomic,copy) NSString * vdnId;//
@property (nonatomic,copy) NSString * warnId;//
@property (nonatomic,copy) NSString * warnSwatchNum;//样本剩余预警数

@property (nonatomic,assign) NSInteger surveyFlag;
@end
