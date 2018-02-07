//
//  IosAndJavaScriptWebView.h
//  JSTest
//
//  Created by wushengjun on 16/6/8.
//  Copyright © 2016年 wushengjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CINWebVccBar : NSObject

-(id)init;
-(void) Initial:(UIWebView*)wv;

-(void) LoadURL:(NSString*)sUrl;
-(void) LoadLocalHtml:(NSString*)sfileName FileExt:(NSString*)sFileExt;

-(void) ExecuteJS:(NSString*)strJS;

@end
