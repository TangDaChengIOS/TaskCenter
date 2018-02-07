//
//  CINSipCore.h
//  CINSipApp
//
//  Created by wushengjun on 16/2/1.
//  Copyright © 2016年 BJCINCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SipDefines.h"

//////////////////////
////
//////////////////

@interface SipPhoneCtrl : NSObject

//attribute


-(NSString*)GetServer;
-(void)SetServer:(NSString*)sValue;
-(NSString*)GetDomain;
-(void)SetDomain:(NSString*)sValue;
-(int)GetServerPort;
-(void)SetServerPort:(int)nValue;
-(NSString*)GetPassWord;
-(void)SetPassWord:(NSString*)sValue;
-(NSString*)GetNumber;
-(void)SetNumber:(NSString*)sValue;
-(NSString*)GetAuthName;
-(void)SetAuthName:(NSString*)sValue;
-(int)GetAuthType;
-(void)SetAuthType:(int)nValue;
-(int)GetDefaultCodec;
-(void)SetDefaultCodec:(int)nValue;
-(int)GetAutoAnswer;
-(void)SetAutoAnswer:(int)nValue;


//Method
-(void) SetSipTraceFlag:(int)flags;

-(int) Initial;
-(int) UnInitial;
-(int) Register;
-(int) UnRegister;
-(int) DoCall:(NSString*)strNum;
-(int) Answer;
-(int) Disconnect;
-(int) SendDtmf:(int)tapKey;
-(Boolean) SetSpeakMode;

-(SipCoreCall*) GetSipCoreCall;
-(NSString *) GetVersion;
-(NSString*) UploadLogFile:(NSString *)sServer Port:(int)nPort;

//Event
@property (nonatomic, weak) id<SIPEventDelegate> delegate;


-(id)init;
-(void)dealloc;
+(id) getInstance;
+(void) releaseInstance;


@end
