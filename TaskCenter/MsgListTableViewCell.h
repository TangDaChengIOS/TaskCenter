//
//  MsgListTableViewCell.h
//  TaskCenter
//
//  Created by 汤达成 on 18/1/23.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMsgListTableViewCellReuseID @"kMsgListTableViewCellReuseID"

typedef NS_ENUM(NSInteger,CellShowStyle) {
    CellShowStyleLeftShort,
    CellShowStyleRightShort
};

@interface MsgListTableViewCell : UITableViewCell
@property (nonatomic,assign) CellShowStyle showStyle;
-(void)setCellWith:(NSString *)leftStr isNeedRight:(BOOL)isNeedRight rightStr:(NSString *)rightStr;
@end
