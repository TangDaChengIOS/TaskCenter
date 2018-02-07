//
//  MediaCtrl.h
//  WebRTC
//
//  Created by wushengjun on 16/3/4.
//  Copyright © 2016年 Pristine, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum emRTPPayloadType {
    RTP_PayloadType_ULaw   = 0,
    RTP_PayloadType_ALaw   = 8,
    RTP_PayloadType_ILbc   = 102,
    RTP_PayloadType_Agora  = 100,
    RTP_PayloadType_Opus   = 120
} emRTPPayloadType;

@interface MediaCtrl : NSObject

//attribute
- (void) setAudioEnabled:(Boolean) audioEnabled;
- (Boolean) getAudioEnabled;
- (void) setAgcEnabled:(Boolean) enable;
- (Boolean) getAgcEnabled;
- (void) setNsEnabled:(Boolean) enable;
- (Boolean) getNsEnabled;
- (void) setEcEnabled:(Boolean) enable;
- (Boolean) getEcEnabled;
- (void) setSpeakerEnabled:(Boolean) enable;
- (Boolean) getSpeakerEnabled;
- (void) setApmRecord:(Boolean) enable;
- (Boolean) getApmRecord;
- (void) setAudioRtpDump:(Boolean) enable;
- (Boolean) getAudioRtpDump;
- (int) audioCodecIndex;
- (void) setAudioCodecIndex:(int) codecIndex PayloadValue:(int)plValue;
- (int) getAudioLocalPort;
- (void) setAudioLocalPort:(int) port;
- (int) getAudioRemotePort;
- (void) setAudioRemotePort:(int) audioTxPort;
- (void) setRemoteIp:(NSString*) remoteIp;
- (NSString*) getRemoteIp;

- (NSString*)  GetVersion;

//method
- (void) createSession;
- (void) deleteSession;
- (void) start;
- (void) stop;
- (void) setAudioCodec:(int) payType PayValue:(int) payValue;
- (NSString*) GetSurpportCodec;



@end
