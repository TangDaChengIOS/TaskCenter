//
//  WorkStationViewController.h
//  TaskCenter
//
//  Created by 汤达成 on 18/1/19.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBaseViewController.h"
#import <CINVccBar/CINVccBarCore.h>

@interface WorkStationViewController : ATBaseViewController<VccBarEventDelegate>

@property (nonatomic,strong) CINVccBarCore * oCINVccBar;
@property (nonatomic,assign) BOOL isCallOut;
@end
