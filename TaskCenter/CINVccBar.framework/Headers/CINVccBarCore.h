//
//  CINVccBarCore.h
//  CINVccBarCore
//
//  Created by wsj on 15-11-5.
//  Copyright (c) 2015年 wsj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CINVccBarDefines.h"


@interface CINVccBarCore : NSObject

//attribute

-(NSString*)AgentID;
-(void)setAgentID:(NSString*)sValue;
-(NSString*)VccID;
-(void)setVccID:(NSString*)sValue;
-(NSString*)PassWord;
-(void)setPassWord:(NSString*)sValue;
-(NSString*)Dn;
-(void)setDn:(NSString*)sValue;
-(NSString*)MainIp;
-(void)setMainIp:(NSString*)sValue;
-(NSString*)BackIp;
-(void)setBackIp:(NSString*)sValue;
-(int)MainPort;
-(void)setMainPort:(int)nValue;
-(int)BackPort;
-(void)setBackPort:(int)nValue;
-(NSString*)TaskId;
-(void)setTaskId:(NSString*)sValue;
-(int)PhoneType;
-(void)setPhoneType:(int)nValue;
-(NSString*)SipServer;
-(void)setSipServer:(NSString*)sValue;
-(NSString*)SipPassword;
-(void)setSipPassword:(NSString*)sValue;
-(int)SipPort;
-(void)setSipPort:(int)nValue;
-(int)AutoAnswer;
-(void)setAutoAnswer:(int)nValue;


//Method
//1) base
-(void) VccBarCreate;
-(void) VccBarClear;
-(void) SetAcpTraceFlag:(int)flags;
-(void) SetSipTraceFlag:(int)flags;
-(void) SetLogFileEnable:(int)flag;
-(int) Initial;
-(int) SerialBtn:(NSString *)showIDS hiddenIDS:(NSString *)hIDS;
-(NSString *) GetBtnStatus;
-(int) UnInitial:(int)code;
-(NSString *) GetVersion;

//2) base status
-(int) SetIdle;
-(int) SetBusy:(int)subStatus;
-(int) SetWrapUp;
-(int) SetCTICalloutTask:(NSString *)TastNum;
-(NSString *) GetCTICalloutTask;
-(NSString *) GetCallData:(NSString *)destAgentID;
-(int) SetCallData:(NSString *)destAgentID callData:(NSString *)data;
-(NSString *) GetTransfer;
-(int) SetTransfer:(NSString *)forwardDeviceID forwardState:(int)fs answerType:(int)at;
-(NSString *) GetCallID;
-(NSString *) GetCallInfo;
-(int) SetTransparentParameter:(NSString *)transparentParam;
-(int) GetAgentStatus;
-(int) GetAgentSubBusyStatus;
-(NSString *) GetBusySubStatus ;
-(int) SetDisplayNumber:(NSString *)destNum;
-(NSString *) GetDisplayNumber;
-(int) SetActiveService:(NSString *)ServiceNum;
-(NSString *) GetActiveService;
-(NSString *) GetExitCause;

//3) call command
-(int) CallOutSide:(NSString *)DestNum serviceDirect:(int)sd taskID:(NSString *)td transParentParam:(NSString *)tpp phoneID:(NSString *)pi;
-(int) CallIn:(NSString *)DestAgentID serviceDirect:(int)sd taskID:(NSString *)td transParentParam:(NSString *)tpp;
-(int) TransferOut:(int)lTransferType DestNum:(NSString *)dn;
-(int) Hold;
-(int) RetrieveHold;
-(int) Disconnect:(int) callType;
-(int) Answer;
-(int) Consult:(int)lConsultType ConsultNum:(NSString *)cn;
-(int) Transfer;
-(int) Conference;
-(int) SendDTMF:(NSString *)TapKey;
-(int) Bridge:(NSString *)IVRNum bEndCall:(int)ec;
-(int) Mute:(int) flag;
-(int) ReleaseThirdOne:(int)retrieveCall;
-(int) FroceReset;

//Event
@property (nonatomic, weak) id<VccBarEventDelegate> delegate;


-(id)init;
-(void)dealloc;
//+(id) getInstance;
//+(void) releaseInstance;



@end
