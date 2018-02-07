//
//  CINSipDefines.h
//  CINSipApp
//
//  Created by wushengjun on 16/2/2.
//  Copyright © 2016年 BJCINCC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum emRegistrationState {
    RegistrationNone = 0,
    RegistrationProgress ,
    RegistrationOk ,
    RegistrationCleared ,
    RegistrationFailed
} emRegistrationState;

typedef enum emCallState {
    Idle  = 0,
    IncomingReceived,
    OutgoingInit,
    OutgoingProgress,
    OutgoingRinging,
    OutgoingEarlyMedia,
    Connected,
    StreamsRunning,
    Pausing,
    Paused,
    Resuming,
    Refered,
    Error,
    CallEnd,
    PausedByRemote,
    CallUpdatedByRemote,
    CallIncomingEarlyMedia,
    CallUpdating,
    CallReleased
} emCallState;


////////////////////////////////////
////CallState
////////////////////////////////////
@interface CallState : NSObject
{
    @public
    emCallState callState;
}

- (NSString*) ToString;
-(id)init;

@end

////////////////////////////////////
////RTPCodec
////////////////////////////////////
@interface RTPCodec : NSObject
{
@public
    int codec;
}

- (NSString*) ToString;
-(id)init;

@end

////////////////////////////////////
////RegistrationState
////////////////////////////////////
@interface RegistrationState : NSObject
{
    @public
    emRegistrationState regState;
}

-(NSString*) ToString;
-(id)init;

@end



////////////////////////////////////
////SipCoreCall
////////////////////////////////////
@interface SipCoreCall : NSObject
{
    @public
    RegistrationState* regState;//register status
    CallState* callState;
    RTPCodec*  aCodec;

    NSString*  sNum;//对方电话号码
    NSString*  sCurID;////session id
    int        nCode; //error code
    NSString*  sDescription ;//error des
    int        regCode;///register code
}
-(id)init;
@end

@protocol SIPEventDelegate <NSObject>

@required
- (void)OnRegistrationStateChanged:(RegistrationState*)state Message:(NSString *)message;
- (void)OnCallStateChanged:(SipCoreCall*)sipcall State:(CallState*)state Message:(NSString *)message;
- (void)OnDebugMessage:(NSString*)sMsg;
- (void)OnMessage:(int)code Message:(NSString*)sMsg;
@end


