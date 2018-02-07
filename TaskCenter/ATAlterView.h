//
//  ATAlterView.h
//  TaskCenter
//
//  Created by 汤达成 on 18/2/3.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(BOOL isOk);

@interface ATAlterView : UIView

@property (nonatomic,copy) NSString * message;
@property (nonatomic,copy) NSAttributedString * attributeMessage;

@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) AlertBlock alertBlock;

/**显示提示框，参数：普通信息、按钮事件YES确定NO取消*/
+(void)showAlertViewWithMessage:(NSString *)message andBlock:(AlertBlock)alertBlock;

/**显示提示框，参数：可变文本信息、按钮事件YES确定NO取消*/
+(void)showAlertViewWithAttributeMessage:(NSAttributedString *)attributeMessage andBlock:(AlertBlock)alertBlock;

/**显示提示框，参数：可变文本信息、套餐价格、按钮事件YES确定NO取消*/
+(void)showAlertViewWithAttributeMessage:(NSAttributedString *)attributeMessage andPrice:(NSString *)price andBlock:(AlertBlock)alertBlock;
@end
