//
//  CINVccBarDefines.h
//  CINVccBar
//
//  Created by wushengjun on 16/4/29.
//  Copyright © 2016年 BJCINCC. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol VccBarEventDelegate <NSObject>

@required
- (void)OnCallRing:(NSString *)callingNo CalledNo:(NSString *)calledno OrgCalledNo:(NSString *)orgcallno CallData:(NSString *)calldata SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect CallID:(NSString *)callid UserParam:(NSString *)userparam TaskID:(NSString *)taskid UserDn:(NSString *)userdn AgentDn:(NSString *)agentdn AreaCode:(NSString *)areacode  Filename:(NSString *)filename NetWorkInfo:(NSString *)networkinfo QueueTime:(NSString *)queuetime OpAgentID:(NSString *)opagentid;
- (void)OnCallConnectd:(NSString *)UserNo AnswerTime:(NSString *)answertime SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect CallID:(NSString *)callid UserParam:(NSString *)userparam TaskID:(NSString *)taskid;
- (void)OnCallEnd:(NSString *)callID SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect UserNo:(NSString *)userno BgnTime:(NSString *)bgntime EndTime:(NSString *)endtime AgentAlertTime:(NSString *)agentalerttime UserAlertTime:(NSString *)useralerttime FileName:(NSString *)filename Directory:(NSString *)directory DisconnectType:(int)disconnecttype UserParam:(NSString *)userparam TaskID:(NSString *)taskid ServerName:(NSString *)servername NetWorkInfo:(NSString *)networkinfo;

- (void)OnPrompt:(int)code description:(NSString *)des;
- (void)OnReportBtnStatus:(NSString *)btnIDS;
- (void)OnInitialSuccess;
- (void)OnInitalFailure:(int)code description:(NSString *)des;
- (void)OnAgentWorkReport:(int)workStatus description:(NSString *)des;
- (void)OnBarExit:(int)code description:(NSString *)des;
- (void)OnMethodResponseEvent:(NSString *)cmdName param:(NSString *)p;

- (void)OnCallDataChanged:(NSString *)callData;
- (void)OnSystemMessage:(int)code Description:(NSString *)des;

@optional
- (void)OnEventPrompt:(int)eventIndex EventParam:(NSString *)eventparam;
- (void)OnWorkStaticInfoReport:(NSString *)staticInfo;
- (void)OnQueueReport:(NSString *)serviceReportInfo;

@end



@interface CINVccBarDefines : NSObject

@end
