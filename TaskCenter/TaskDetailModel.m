//
//  TaskDetailModel.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/6.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "TaskDetailModel.h"

@implementation TaskDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        [super setValue:value forKey:@"descript"];
    }
}
-(NSString *)operationId_des{
    switch ([_operationId integerValue]) {
        case 1:
            return @"营销类";
            break;
        case 2:
            return @"推销类";
            break;
        case 3:
            return @"回访类";
            break;
        case 4:
            return @"催缴类";
            break;
        case 5:
            return @"调查类";
            break;
        case 6:
            return @"关怀类";
            break;
        case 7:
            return @"其他类";
            break;
        default:
            return @"其他类";
            break;
    }
}


@end
