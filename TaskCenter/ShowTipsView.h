//
//  ShowTipsView.h
//  TaskCenter
//
//  Created by 汤达成 on 18/2/3.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTipsView : UIView

@property (nonatomic,copy) NSString * tips;
+(void)showTipsView:(NSString *)tips;

@end
